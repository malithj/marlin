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
               T alpha, T* a, index_t lda, T* b, index_t ldb, T beta, T* c);
};

template <typename T>
index_t GEMM<T>::gemm(char transa, char transb, index_t m, index_t n, index_t k,
                      T alpha, T* a, index_t lda, T* b, index_t ldb, T beta,
                      T* c) {
  uint32_t arr[16];
  for (uint32_t i = 0; i < 16; ++i) {
    arr[i] = i * k;
  }
  __m512 zmm0 = _mm512_setzero_ps();
  __m512i zmm1 = _mm512_loadu_si512(&arr);

  // load 15 C columns
  uint16_t mask = ~(0xffff << m);

  T* c_ptr = c;
  __m512 czmm16 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm17 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm18 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm19 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm20 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm21 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm22 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm23 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm24 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm25 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);

  __m512 azmm0;
  for (index_t kk = 0; kk < k; kk += 1) {
    float* a_ptr = a + kk;
    azmm0 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, a_ptr, 0x4);

    // load 15 B columns
    T* b_ptr = b + kk * n;
    __m512 bzmm1 = _mm512_set1_ps(*b_ptr);
    __m512 bzmm2 = _mm512_set1_ps(*(b_ptr + 1));
    __m512 bzmm3 = _mm512_set1_ps(*(b_ptr + 2));
    __m512 bzmm4 = _mm512_set1_ps(*(b_ptr + 3));
    __m512 bzmm5 = _mm512_set1_ps(*(b_ptr + 4));
    __m512 bzmm6 = _mm512_set1_ps(*(b_ptr + 5));
    __m512 bzmm7 = _mm512_set1_ps(*(b_ptr + 6));
    __m512 bzmm8 = _mm512_set1_ps(*(b_ptr + 7));
    __m512 bzmm9 = _mm512_set1_ps(*(b_ptr + 8));
    __m512 bzmm10 = _mm512_set1_ps(*(b_ptr + 9));

    czmm16 = _mm512_fmadd_ps(azmm0, bzmm1, czmm16);
    czmm17 = _mm512_fmadd_ps(azmm0, bzmm2, czmm17);
    czmm18 = _mm512_fmadd_ps(azmm0, bzmm3, czmm18);
    czmm19 = _mm512_fmadd_ps(azmm0, bzmm4, czmm19);
    czmm20 = _mm512_fmadd_ps(azmm0, bzmm5, czmm20);
    czmm21 = _mm512_fmadd_ps(azmm0, bzmm6, czmm21);
    czmm22 = _mm512_fmadd_ps(azmm0, bzmm7, czmm22);
    czmm23 = _mm512_fmadd_ps(azmm0, bzmm8, czmm23);
    czmm24 = _mm512_fmadd_ps(azmm0, bzmm9, czmm24);
    czmm25 = _mm512_fmadd_ps(azmm0, bzmm10, czmm25);
  }

  c_ptr = c;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm16, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm17, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm18, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm19, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm20, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm21, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm22, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm23, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm24, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm25, 0x4);
  return 1;
}

#endif
