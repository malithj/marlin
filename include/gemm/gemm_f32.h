#ifndef __GEMM_F32_H_
#define __GEMM_F32_H_

#include <immintrin.h>
#include <memory.h>

#include <iostream>

#include "../types/types.h"
#ifdef ENABLE_JIT
#include "asm_kernels.h"
#include "jit/jitter.h"
#else
#include "./kernels.h"
#endif

// Performs GEMM (General Matrix Multiplication)
// block size for all three dimensions is set to the above "N" value by
// default.
// The following variables are used to define the functionality (compatible
// with available BLAS APIs)
//
// parameters
// ----------
// transa - whether to transpose A ('N|n': use original, 'T|t': transpose)
// transb - whether to transpose B ('N|n': use original, 'T|t': transpose)
// m      - number of rows in matrix A (row major)
// n      - number of columns in matrix B (row major)
// k      - numer of columns in matrix A and rows in matrix B (row major)
// alpha  - factor of matrix A (alpha * AB + beta * C) @TODO(malith):
// a      - pointer of type T of matrix A
// lda    - leading dimension of matrix A (stride offset) @TODO(malith):
// b      - pointer of type T of matrix B
// ldb    - leading dimension of matrix B (stride offset) @TODO(malith):
// beta   - factor of matrix B (alpha * AB + beta * C) @TODO(malith):
// c      - pointer of type T of matrix C
// ldc    - leading dimension of matrix C (stride offset) @TODO(malith):
#ifdef ENABLE_JIT
inline index_t sgemm(char transa, char transb, index_t m, index_t n, index_t k,
                     float alpha, float* a, index_t lda, float* b, index_t ldb,
                     float beta, float* c, index_t ldc,
                     std::shared_ptr<Jitter<float>> jitter) {
#else
inline index_t sgemm(char transa, char transb, index_t m, index_t n, index_t k,
                     float alpha, float* a, index_t lda, float* b, index_t ldb,
                     float beta, float* c, index_t ldc) {
#endif
  // full tile bounding limit
  index_t ftile_j_lim = (n / 15) * 15;
  index_t ftile_i_lim = m & ~(0xf);
  // partial tile bounding limit
  index_t ptile_j_remain = n - ftile_j_lim;
  index_t ptile_i_remain = m & 0xf;
  float* a_ptr;
  float* b_ptr;
  float* c_ptr;

#ifdef ENABLE_JIT
  index_t idx = 0;
  auto execute_kernel = [&](index_t ielem, index_t jelem) {
    switch (jelem) {
      case 1:
        gemm_f32_j1('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 2:
        gemm_f32_j2('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 3:
        gemm_f32_j3('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 4:
        gemm_f32_j4('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 5:
        gemm_f32_j5('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 6:
        gemm_f32_j6('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 7:
        gemm_f32_j7('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 8:
        gemm_f32_j8('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 9:
        gemm_f32_j9('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 10:
        gemm_f32_j10('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 11:
        gemm_f32_j11('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 12:
        gemm_f32_j12('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 13:
        gemm_f32_j13('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 14:
        gemm_f32_j14('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
    }
  };
#else
  auto execute_kernel = [&](index_t ielem, index_t jelem) {
    switch (jelem) {
      case 1:
        gemm_f32_j1('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 2:
        gemm_f32_j2('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 3:
        gemm_f32_j3('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 4:
        gemm_f32_j4('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 5:
        gemm_f32_j5('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 6:
        gemm_f32_j6('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 7:
        gemm_f32_j7('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 8:
        gemm_f32_j8('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 9:
        gemm_f32_j9('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                    n);
        break;
      case 10:
        gemm_f32_j10('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 11:
        gemm_f32_j11('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 12:
        gemm_f32_j12('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 13:
        gemm_f32_j13('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
      case 14:
        gemm_f32_j14('N', 'N', ielem, jelem, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr,
                     n);
        break;
    }
  };
#endif

  for (index_t i = 0; i < ftile_i_lim; i += 0x10) {
    for (index_t j = 0; j < ftile_j_lim; j += 0xf) {
      a_ptr = a + i * k;
      b_ptr = b + j;
      c_ptr = c + i * n + j;
#ifdef ENABLE_JIT
      gemm_f32_j15(k, a_ptr, c_ptr, jitter->get_p_addr(),
                   jitter->get_offset_data(), jitter->get_a_offsets(),
                   jitter->get_c_offsets(), jitter->get_mask(), idx);
#else
      gemm_f32_j15('N', 'N', 0x10, 0xf, k, 1, a_ptr, k, b_ptr, n, 0, c_ptr, n);
#endif
    }
  }

#ifdef ENABLE_JIT
  idx += (ftile_i_lim / 16) * (ftile_j_lim / 15);
#endif

  if (ptile_i_remain) {
    a_ptr = a + ftile_i_lim * k;
    for (index_t j = 0; j < ftile_j_lim; j += 0xf) {
      b_ptr = b + j;
      c_ptr = c + ftile_i_lim * n + j;
#ifdef ENABLE_JIT
      gemm_f32_j15(k, a_ptr, c_ptr, jitter->get_p_addr(),
                   jitter->get_offset_data(), jitter->get_a_offsets(),
                   jitter->get_c_offsets(), jitter->get_pmask(), idx);
#else
      gemm_f32_j15('N', 'N', ptile_i_remain, 0xf, k, 1, a_ptr, k, b_ptr, n, 0,
                   c_ptr, n);
#endif
    }
  }

  if (ptile_j_remain) {
    b_ptr = b + ftile_j_lim;
    for (index_t i = 0; i < ftile_i_lim; i += 0x10) {
      a_ptr = a + i * k;
      c_ptr = c + i * n + ftile_j_lim;
      execute_kernel(0x10, ptile_j_remain);
    }

    if (ptile_i_remain) {
      a_ptr = a + ftile_i_lim * k;
      c_ptr = c + ftile_i_lim * n + ftile_j_lim;
      execute_kernel(ptile_i_remain, ptile_j_remain);
    }
  }

  return 1;
}

#endif