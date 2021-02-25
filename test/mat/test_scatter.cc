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
#include <chrono>

#include "constants/constants.h"
#include "gtest/gtest.h"
#include "immintrin.h"

TEST(Matrix, Scatter) {
  uint32_t h = 10;
  uint32_t w = 10;

  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::nanoseconds duration;

  float *A =
      static_cast<float *>(_mm_malloc(h * w * sizeof(float), ALIGN_BYTE_SIZE));

  for (index_t i = 0; i < h * w; ++i) {
    A[i] = h * w - i;
  }

  uint32_t *arr = static_cast<uint32_t *>(
      _mm_malloc(16 * sizeof(uint32_t), ALIGN_BYTE_SIZE));
  for (uint32_t i = 0; i < 16; ++i) {
    arr[i] = i * w;
  }

  __m512 zmm1 = _mm512_setzero_ps();
  for (index_t i = 0; i < 10; ++i) {
    __m512i zmm0 = _mm512_load_epi32(arr);
    uint16_t mask = ~(0xffff << w);
    begin = std::chrono::steady_clock::now();
    float *a_ptr = A;
    _mm512_mask_i32scatter_ps(a_ptr, mask, zmm0, zmm1, 0x4);
    end = std::chrono::steady_clock::now();
    duration =
        std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
  }

  _mm_free(A);
  _mm_free(arr);
}