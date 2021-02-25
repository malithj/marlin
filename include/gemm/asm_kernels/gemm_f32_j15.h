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
#ifndef __GEMM_ASM_F32_J15_H_
#define __GEMM_ASM_F32_J15_H_

#include <immintrin.h>
#include <memory.h>

#include <iostream>

#include "../../jit/jitter.h"
#include "../../types/types.h"

inline index_t gemm_f32_j15(index_t k, float* a, float* c, void* p_addr,
                            index_t* offset_data, uint32_t* arr_a,
                            uint32_t* arr_c, uint16_t mask, index_t idx) {
  __m512 zmm0 = _mm512_setzero_ps();
  __m512i zmm1 = _mm512_loadu_si512(arr_c);
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
  c_ptr++;
  __m512 czmm23 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm24 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm25 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm26 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm27 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm28 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm29 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);
  c_ptr++;
  __m512 czmm30 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, c_ptr, 0x4);

  zmm1 = _mm512_loadu_si512(arr_a);
  for (index_t kk = 0; kk < k; kk += 1) {
    float* a_ptr = a + kk;
    __m512 azmm0 = _mm512_mask_i32gather_ps(zmm0, mask, zmm1, a_ptr, 0x4);

    // load n B columns
    void (*execute_function)();
    index_t offset = offset_data[idx++];
    execute_function = reinterpret_cast<void (*)()>(
        static_cast<unsigned char*>(p_addr) + offset);
    execute_function();

    __asm__ __volatile__(
        "vmovaps %[azmm], %%zmm0\n\t"
        "vmovaps %[czmm0], %%zmm1\n\t"
        "vmovaps %[czmm1], %%zmm2\n\t"
        "vmovaps %[czmm2], %%zmm3\n\t"
        "vmovaps %[czmm3], %%zmm4\n\t"
        "vmovaps %[czmm4], %%zmm5\n\t"
        "vmovaps %[czmm5], %%zmm6\n\t"
        "vmovaps %[czmm6], %%zmm7\n\t"
        "vmovaps %[czmm7], %%zmm8\n\t"
        "vmovaps %[czmm8], %%zmm9\n\t"
        "vmovaps %[czmm9], %%zmm10\n\t"
        "vmovaps %[czmm10], %%zmm11\n\t"
        "vmovaps %[czmm11], %%zmm12\n\t"
        "vmovaps %[czmm12], %%zmm13\n\t"
        "vmovaps %[czmm13], %%zmm14\n\t"
        "vmovaps %[czmm14], %%zmm15\n\t"
        "vfmadd231ps %[azmm], %%zmm31, %%zmm1\n\t"   // z1 += z0 *
                                                     // z31
        "vfmadd231ps %[azmm], %%zmm30, %%zmm2\n\t"   // z2 += z0 *
                                                     // z30
        "vfmadd231ps %[azmm], %%zmm29, %%zmm3\n\t"   // z3 += z0 *
                                                     // z29
        "vfmadd231ps %[azmm], %%zmm28, %%zmm4\n\t"   // z4 += z0 *
                                                     // z28
        "vfmadd231ps %[azmm], %%zmm27, %%zmm5\n\t"   // z5 += z0 *
                                                     // z27
        "vfmadd231ps %[azmm], %%zmm26, %%zmm6\n\t"   // z6 += z0 *
                                                     // z26
        "vfmadd231ps %[azmm], %%zmm25, %%zmm7\n\t"   // z7 += z0 *
                                                     // z25
        "vfmadd231ps %[azmm], %%zmm24, %%zmm8\n\t"   // z8 += z0 *
                                                     // z24
        "vfmadd231ps %[azmm], %%zmm23, %%zmm9\n\t"   // z9 += z0 *
                                                     // z23
        "vfmadd231ps %[azmm], %%zmm22, %%zmm10\n\t"  // z10 += z0 *
                                                     // z22
        "vfmadd231ps %[azmm], %%zmm21, %%zmm11\n\t"  // z11 += z0 *
                                                     // z21
        "vfmadd231ps %[azmm], %%zmm20, %%zmm12\n\t"  // z12 += z0 *
                                                     // z20
        "vfmadd231ps %[azmm], %%zmm19, %%zmm13\n\t"  // z13 += z0 *
                                                     // z19
        "vfmadd231ps %[azmm], %%zmm18, %%zmm14\n\t"  // z14 += z0 *
                                                     // z18
        "vfmadd231ps %[azmm], %%zmm17, %%zmm15\n\t"  // z15 += z0 *
                                                     // z17
        ::[azmm] "v"(azmm0),
        [czmm0] "v"(czmm16), [czmm1] "v"(czmm17), [czmm2] "v"(czmm18),
        [czmm3] "v"(czmm19), [czmm4] "v"(czmm20), [czmm5] "v"(czmm21),
        [czmm6] "v"(czmm22), [czmm7] "v"(czmm23), [czmm8] "v"(czmm24),
        [czmm9] "v"(czmm25), [czmm10] "v"(czmm26), [czmm11] "v"(czmm27),
        [czmm12] "v"(czmm28), [czmm13] "v"(czmm29), [czmm14] "v"(czmm30));

    __asm__ __volatile__(
        "vmovaps %%zmm1, %[czmm0]\n\t"
        "vmovaps %%zmm2, %[czmm1]\n\t"
        "vmovaps %%zmm3, %[czmm2]\n\t"
        "vmovaps %%zmm4, %[czmm3]\n\t"
        "vmovaps %%zmm5, %[czmm4]\n\t"
        "vmovaps %%zmm6, %[czmm5]\n\t"
        "vmovaps %%zmm7, %[czmm6]\n\t"
        "vmovaps %%zmm8, %[czmm7]\n\t"
        "vmovaps %%zmm9, %[czmm8]\n\t"
        "vmovaps %%zmm10, %[czmm9]\n\t"
        "vmovaps %%zmm11, %[czmm10]\n\t"
        "vmovaps %%zmm12, %[czmm11]\n\t"
        "vmovaps %%zmm13, %[czmm12]\n\t"
        "vmovaps %%zmm14, %[czmm13]\n\t"
        "vmovaps %%zmm15, %[czmm14]\n\t"
        : [czmm0] "=v"(czmm16), [czmm1] "=v"(czmm17), [czmm2] "=v"(czmm18),
          [czmm3] "=v"(czmm19), [czmm4] "=v"(czmm20), [czmm5] "=v"(czmm21),
          [czmm6] "=v"(czmm22), [czmm7] "=v"(czmm23), [czmm8] "=v"(czmm24),
          [czmm9] "=v"(czmm25), [czmm10] "=v"(czmm26), [czmm11] "=v"(czmm27),
          [czmm12] "=v"(czmm28), [czmm13] "=v"(czmm29), [czmm14] "=v"(czmm30)
        :
        :);
  }

  zmm1 = _mm512_loadu_si512(arr_c);

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
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm26, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm27, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm28, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm29, 0x4);
  c_ptr++;
  _mm512_mask_i32scatter_ps(c_ptr, mask, zmm1, czmm30, 0x4);
  return 1;
}

#endif
