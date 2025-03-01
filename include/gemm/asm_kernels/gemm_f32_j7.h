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
#ifndef __GEMM_ASM_F32_J7_H_
#define __GEMM_ASM_F32_J7_H_

#include <immintrin.h>
#include <memory.h>

#include <iostream>

#include "../../types/types.h"

inline index_t gemm_f32_j7(char transa, char transb, index_t m, index_t n,
                           index_t k, float alpha, float* a, index_t lda,
                           float* b, index_t ldb, float beta, float* c,
                           index_t ldc) {
  uint32_t arr_a[16];
  for (uint32_t i = 0; i < 16; ++i) {
    arr_a[i] = i * lda;
  }

  uint32_t arr_c[16];
  for (uint32_t i = 0; i < 16; ++i) {
    arr_c[i] = i * ldc;
  }
  __m512 zmm0 = _mm512_setzero_ps();
  __m512i zmm1 = _mm512_loadu_si512(&arr_c);

  // load m rows
  uint16_t mask = ~(0xffff << m);

  float* c_ptr = c;
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

  zmm1 = _mm512_loadu_si512(&arr_a);
  for (index_t kk = 0; kk < k; kk += 1) {
    float* a_ptr = a + kk;
    __m512 azmm0 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, a_ptr, 0x4);

    // load n B columns
    float* b_ptr = b + kk * ldb;
    __m512 bzmm1 = _mm512_set1_ps(*b_ptr);
    __m512 bzmm2 = _mm512_set1_ps(*(b_ptr + 1));
    __m512 bzmm3 = _mm512_set1_ps(*(b_ptr + 2));
    __m512 bzmm4 = _mm512_set1_ps(*(b_ptr + 3));
    __m512 bzmm5 = _mm512_set1_ps(*(b_ptr + 4));
    __m512 bzmm6 = _mm512_set1_ps(*(b_ptr + 5));
    __m512 bzmm7 = _mm512_set1_ps(*(b_ptr + 6));

    czmm16 = _mm512_fmadd_ps(azmm0, bzmm1, czmm16);
    czmm17 = _mm512_fmadd_ps(azmm0, bzmm2, czmm17);
    czmm18 = _mm512_fmadd_ps(azmm0, bzmm3, czmm18);
    czmm19 = _mm512_fmadd_ps(azmm0, bzmm4, czmm19);
    czmm20 = _mm512_fmadd_ps(azmm0, bzmm5, czmm20);
    czmm21 = _mm512_fmadd_ps(azmm0, bzmm6, czmm21);
    czmm22 = _mm512_fmadd_ps(azmm0, bzmm7, czmm22);
  }

  zmm1 = _mm512_loadu_si512(&arr_c);

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
  return 1;
}

#endif
