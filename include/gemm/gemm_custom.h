#ifndef __GEMM_CUSTOM_H_
#define __GEMM_CUSTOM_H_

#include <immintrin.h>
#include <memory.h>

#include <iostream>

#include "../types/types.h"

template <typename T>
class GEMM {
 public:
  GEMM(){};
  // Performs GEMM (General Matrix Multiplication) using AVX512 assembly
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
  // cs     - pointer of code store with instructions of matrix B
  index_t gemm(char transa, char transb, index_t m, index_t n, index_t k,
               T alpha, T* a, index_t lda, T* b, index_t ldb, T beta, T* c,
               T* a_t, T* c_t);
};

template <typename T>
index_t GEMM<T>::gemm(char transa, char transb, index_t m, index_t n, index_t k,
                      T alpha, T* a, index_t lda, T* b, index_t ldb, T beta,
                      T* c, T* a_t, T* c_t) {
  for (index_t h = 0; h < k; ++h) {
    for (index_t w = 0; w < m; ++w) {
      a_t[h * m + w] = a[w * k + h];
    }
  }
  memset(c_t, 0, m * n * sizeof(T));

  for (index_t j = 0; j < m; j += 2) {
    uint16_t mask = ~(0xffff << m);
    __m512 azmm0 = _mm512_maskz_loadu_ps(mask, a_t);
    __m512 azmm1 = _mm512_maskz_loadu_ps(mask, a_t + m);
    __m512 azmm2 = _mm512_maskz_loadu_ps(mask, a_t + 2 * m);
    __m512 azmm3 = _mm512_maskz_loadu_ps(mask, a_t + 3 * m);
    __m512 azmm4 = _mm512_maskz_loadu_ps(mask, a_t + 4 * m);
    __m512 azmm5 = _mm512_maskz_loadu_ps(mask, a_t + 5 * m);
    __m512 azmm6 = _mm512_maskz_loadu_ps(mask, a_t + 6 * m);
    __m512 azmm7 = _mm512_maskz_loadu_ps(mask, a_t + 7 * m);
    __m512 azmm8 = _mm512_maskz_loadu_ps(mask, a_t + 8 * m);
    __m512 azmm9 = _mm512_maskz_loadu_ps(mask, a_t + 9 * m);

    uint16_t maskb = 0xffff;
    T* b_ptr = b + j;
    T* c_ptr = c_t + j * m;

    __m512 bzmm10 = _mm512_set1_ps(*b_ptr);
    __m512 bzmm11 = _mm512_set1_ps(*(b_ptr + n));
    __m512 bzmm12 = _mm512_set1_ps(*(b_ptr + 2 * n));
    __m512 bzmm13 = _mm512_set1_ps(*(b_ptr + 3 * n));
    __m512 bzmm14 = _mm512_set1_ps(*(b_ptr + 4 * n));
    __m512 bzmm15 = _mm512_set1_ps(*(b_ptr + 5 * n));
    __m512 bzmm16 = _mm512_set1_ps(*(b_ptr + 6 * n));
    __m512 bzmm17 = _mm512_set1_ps(*(b_ptr + 7 * n));
    __m512 bzmm18 = _mm512_set1_ps(*(b_ptr + 8 * n));
    __m512 bzmm19 = _mm512_set1_ps(*(b_ptr + 9 * n));

    __m512 bzmm20 = _mm512_set1_ps(*(b_ptr + 1));
    __m512 bzmm21 = _mm512_set1_ps(*(b_ptr + n + 1));
    __m512 bzmm22 = _mm512_set1_ps(*(b_ptr + 2 * n + 1));
    __m512 bzmm23 = _mm512_set1_ps(*(b_ptr + 3 * n + 1));
    __m512 bzmm24 = _mm512_set1_ps(*(b_ptr + 4 * n + 1));
    __m512 bzmm25 = _mm512_set1_ps(*(b_ptr + 5 * n + 1));
    __m512 bzmm26 = _mm512_set1_ps(*(b_ptr + 6 * n + 1));
    __m512 bzmm27 = _mm512_set1_ps(*(b_ptr + 7 * n + 1));
    __m512 bzmm28 = _mm512_set1_ps(*(b_ptr + 8 * n + 1));
    __m512 bzmm29 = _mm512_set1_ps(*(b_ptr + 9 * n + 1));

    __m512 czmm30 = _mm512_maskz_loadu_ps(mask, c_ptr);
    __m512 czmm31 = _mm512_maskz_loadu_ps(mask, c_ptr + m);

    czmm30 = _mm512_fmadd_ps(azmm0, bzmm10, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm1, bzmm11, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm2, bzmm12, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm3, bzmm13, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm4, bzmm14, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm5, bzmm15, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm6, bzmm16, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm7, bzmm17, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm8, bzmm18, czmm30);
    czmm30 = _mm512_fmadd_ps(azmm9, bzmm19, czmm30);

    czmm31 = _mm512_fmadd_ps(azmm0, bzmm20, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm1, bzmm21, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm2, bzmm22, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm3, bzmm23, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm4, bzmm24, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm5, bzmm25, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm6, bzmm26, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm7, bzmm27, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm8, bzmm28, czmm31);
    czmm31 = _mm512_fmadd_ps(azmm9, bzmm29, czmm31);

    _mm512_mask_storeu_ps(c_ptr, mask, czmm30);
    _mm512_mask_storeu_ps(c_ptr + m, mask, czmm31);
  }
  for (index_t h = 0; h < m; ++h) {
    for (index_t w = 0; w < n; ++w) {
      c[h * n + w] = c_t[w * m + h];
    }
  }
}

#endif
