/*******************************************************************************
 * Copyright (c) Malith Jayaweera - All rights reserved.                       *
 * This file is part of the MARLIN library.                                    *
 *                                                                             *
 * For information on the license, see the LICENSE file.                       *
 * Further information: https://github.com/malithj/marlin/                     *
 * SPDX-License-Identifier: BSD-3-Clause                                       *
 ******************************************************************************/
/* Malith Jayaweera
*******************************************************************************/
#ifndef __ONEDNN_MATMUL_H__
#define __ONEDNN_MATMUL_H__

#include <stdlib.h>

#include <chrono>
#include <fstream>

#include "dnnl.hpp"

using namespace dnnl;

// template code extracted from
// https://oneapi-src.github.io/oneDNN/cpu_sgemm_and_matmul_cpp.html and is
// licensed under the Apache License, Version 2.0

// Create a _dynamic_ MatMul primitive that can work with arbitrary shapes
// and alpha parameters.
// Warning: current limitation is that beta parameter should be known in
// advance (use fixed_beta).
matmul dynamic_matmul_create(engine &eng, float fixed_beta = 0) {
  // We assume that beta is known at the primitive creation time
  float beta = fixed_beta;
  memory::dims a_shape = {DNNL_RUNTIME_DIM_VAL, DNNL_RUNTIME_DIM_VAL};
  memory::dims b_shape = {DNNL_RUNTIME_DIM_VAL, DNNL_RUNTIME_DIM_VAL};
  memory::dims c_shape = {DNNL_RUNTIME_DIM_VAL, DNNL_RUNTIME_DIM_VAL};
  memory::dims a_strides = {DNNL_RUNTIME_DIM_VAL, DNNL_RUNTIME_DIM_VAL};
  memory::dims b_strides = {DNNL_RUNTIME_DIM_VAL, DNNL_RUNTIME_DIM_VAL};
  memory::dims c_strides = {DNNL_RUNTIME_DIM_VAL, 1};
  memory::desc a_md(a_shape, memory::data_type::f32, a_strides);
  memory::desc b_md(b_shape, memory::data_type::f32, b_strides);
  memory::desc c_md(c_shape, memory::data_type::f32, c_strides);
  // Create attributes (to handle alpha dynamically and beta if necessary)
  primitive_attr attr;
  attr.set_output_scales(/* mask */ 0, {DNNL_RUNTIME_F32_VAL});
  if (beta != 0.f) {
    post_ops po;
    po.append_sum(beta);
    attr.set_post_ops(po);
  }
  // Create a MatMul primitive
  matmul::desc matmul_d(a_md, b_md, c_md);
  matmul::primitive_desc matmul_pd(matmul_d, attr, eng);
  return matmul(matmul_pd);
}

// Execute a _dynamic_ MatMul primitive created earlier. All the parameters are
// passed at a run-time (except for beta which has to be specified at the
// primitive creation time due to the current limitation).
void dynamic_matmul_execute(matmul &matmul_p, engine &eng, char transA,
                            char transB, int64_t M, int64_t N, int64_t K,
                            float alpha, const float *A, int64_t lda,
                            const float *B, int64_t ldb, float beta, float *C,
                            int64_t ldc) {
  using dims = memory::dims;
  // Translate transA and transB
  dims a_strides = tolower(transA) == 'n' ? dims{lda, 1} : dims{1, lda};
  dims b_strides = tolower(transB) == 'n' ? dims{ldb, 1} : dims{1, ldb};
  // Wrap raw pointers into oneDNN memories (with proper shapes)
  memory A_m({{M, K}, memory::data_type::f32, a_strides}, eng, (void *)A);
  memory B_m({{K, N}, memory::data_type::f32, b_strides}, eng, (void *)B);
  memory C_m({{M, N}, memory::data_type::f32, {ldc, 1}}, eng, (void *)C);
  // Prepare oneDNN memory for alpha
  memory alpha_m({{1}, memory::data_type::f32, {1}}, eng, &alpha);
  // Execute the MatMul primitive
  stream s(eng);
  matmul_p.execute(s, {{DNNL_ARG_SRC, A_m},
                       {DNNL_ARG_WEIGHTS, B_m},
                       {DNNL_ARG_DST, C_m},
                       {DNNL_ARG_ATTR_OUTPUT_SCALES, alpha_m}});
  s.wait();
}

// Create and execute a _static_ MatMul primitive. All shapes and parameters
// are hard-coded in the primitive and cannot be changed later.
void static_matmul_create_and_execute(engine &eng, char transA, char transB,
                                      int64_t M, int64_t N, int64_t K,
                                      float alpha, const float *A, int64_t lda,
                                      const float *B, int64_t ldb, float beta,
                                      float *C, int64_t ldc) {
  using dims = memory::dims;
  // Prepare strides based on the transA and transB flags: transposed
  // matrices have strides swapped
  dims a_strides = tolower(transA) == 'n' ? dims{lda, 1} : dims{1, lda};
  dims b_strides = tolower(transB) == 'n' ? dims{ldb, 1} : dims{1, ldb};
  // Prepare memory descriptors
  memory::desc a_md({M, K}, memory::data_type::f32, a_strides);
  memory::desc b_md({K, N}, memory::data_type::f32, b_strides);
  memory::desc c_md({M, N}, memory::data_type::f32, {ldc, 1});
  // Create attributes (to handle alpha and beta if necessary)
  primitive_attr attr;
  if (alpha != 1.f) attr.set_output_scales(/* mask */ 0, {alpha});
  if (beta != 0.f) {
    post_ops po;
    po.append_sum(beta);
    attr.set_post_ops(po);
  }
  // Create a MatMul primitive
  matmul::desc matmul_d(a_md, b_md, c_md);
  matmul::primitive_desc matmul_pd(matmul_d, attr, eng);
  matmul matmul_p(matmul_pd);
  // Wrap raw pointers into oneDNN memory objects
  memory A_m(a_md, eng, (void *)A);
  memory B_m(b_md, eng, (void *)B);
  memory C_m(c_md, eng, (void *)C);
  // Execute the MatMul primitive.
  // Since here all shapes and parameters are static, please note that we
  // don't need to pass alpha (scales) again, as they are already hard-coded
  // in the primitive descriptor. Also, we are not allowed to change the
  // shapes of matrices A, B, and C -- they should exactly match
  // the memory descriptors passed to MatMul operation descriptor.
  stream s(eng);
  matmul_p.execute(
      s, {{DNNL_ARG_SRC, A_m}, {DNNL_ARG_WEIGHTS, B_m}, {DNNL_ARG_DST, C_m}});
  s.wait();
}

#endif