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
#ifndef __GEMM_WINOGRAD_H_
#define __GEMM_WINOGRAD_H_

#define ENABLE_EXT_COMPILE 1

#if ENABLE_EXT_COMPILE == ENABLE_EXT
#include <libxsmm.h>
#include <mkl.h>

#include "dnnl.hpp"
#endif

#include "types/types.h"

template <typename T>
class GEMMWinograd {
 public:
  GEMMWinograd() { lib_switch = LIBMKL; };
  ~GEMMWinograd() = default;
  void compute(T* A, T* B, index_t batch, index_t m, index_t n, index_t k,
               T* C);
  void sgemm(char transa, char transb, index_t m, index_t n, index_t k, T alpha,
             T* a, index_t lda, T* b, index_t ldb, T beta, T* c, index_t ldc);
  void set_switch(gemm_library lib_switch) { this->lib_switch = lib_switch; }
  void init_jit_library(const index_t m, const index_t n, const index_t k);

 private:
  gemm_library lib_switch;
  bool jit_status = false;
  void* jitter;
#if ENABLE_EXT_COMPILE == ENABLE_EXT
  sgemm_jit_kernel_t mkl_sgemm;
#endif
};

template <typename T>
void GEMMWinograd<T>::compute(T* A, T* B, index_t batch, index_t m, index_t n,
                              index_t k, T* C) {
  if (!std::is_same<T, float>::value) {
    throw std::runtime_error("type mismatch. only floats are supported.");
  }

#if ENABLE_EXT_COMPILE == ENABLE_EXTT
#pragma omp parallel for
  for (index_t b = 0; b < batch; ++b) {
    T* mat_a = A + (m * k) * b;
    T* mat_b = B + (n * k) * b;
    T* mat_c = C + (m * n) * b;
    this->sgemm(CblasNoTrans, CblasNoTrans, m, n, k, 1, mat_a, k, mat_b, n, 0,
                mat_c, n);
  }
#else
  throw std::runtime_error(
      "jit run time disabled and external GEMM library not provided. cannot "
      "compute without a GEMM library!");
#endif
}

template <typename T>
void GEMMWinograd<T>::init_jit_library(const index_t m, const index_t n,
                                       const index_t k) {
  if (this->jit_status) return;
#if ENABLE_EXT_COMPILE == ENABLE_EXTT
  mkl_jit_status_t status =
      mkl_jit_create_sgemm(&this->jitter, MKL_ROW_MAJOR, MKL_NOTRANS,
                           MKL_NOTRANS, m, n, k, 1, k, n, 0, n);
  if (MKL_JIT_ERROR == status) {
    throw std::runtime_error(
        "insufficient memory to JIT and store the DGEMM kernel");
  }
  // retrieve the function pointer to the SGEMM kernel
  this->mkl_sgemm = mkl_jit_get_sgemm_ptr(this->jitter);
  this->jit_status = true;
#endif
}

template <typename T>
void GEMMWinograd<T>::sgemm(char transa, char transb, index_t m, index_t n,
                            index_t k, T alpha, T* a, index_t lda, T* b,
                            index_t ldb, T beta, T* c, index_t ldc) {
#if ENABLE_EXT_COMPILE == ENABLE_EXT
  if (lib_switch == LIBMKL) {
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, a, k, b,
                n, 0, c, n);
  } else if (lib_switch == LIBONEDNN) {
    dnnl_sgemm('N', 'N', m, n, k, 1, a, k, b, n, 0, c, n);
  } else if (lib_switch == JITMKL) {
    this->mkl_sgemm(this->jitter, a, b, c);
  } else if (lib_switch == JITLIBXSMM) {
    std::unique_ptr<libxsmm_mmfunction<float>> xsmm_kernel =
        std::make_unique<libxsmm_mmfunction<float>>(LIBXSMM_GEMM_FLAG_NONE, n,
                                                    m, k, alpha, beta);
    xsmm_kernel->operator()(b, a, c);
  } else {
    throw std::runtime_error("unknown library switch");
  }
#endif
}

#endif