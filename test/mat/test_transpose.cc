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
#include <immintrin.h>

#include <chrono>

#include "constants/constants.h"
#include "gtest/gtest.h"
#include "mat/transpose.h"

TEST(Matrix, Transpose_4x4) {
  index_t h = 10;
  index_t w = 10;

  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::nanoseconds duration;

  float *mat_4x4 =
      static_cast<float *>(_mm_malloc(h * w * sizeof(float), ALIGN_BYTE_SIZE));
  float *mat_4x4_tp =
      static_cast<float *>(_mm_malloc(h * w * sizeof(float), ALIGN_BYTE_SIZE));

  for (index_t i = 0; i < 16; ++i) {
    mat_4x4[i] = i;
  }

  transpose4x4<float>(mat_4x4, mat_4x4_tp, h, w);
  _mm_free(mat_4x4);
  _mm_free(mat_4x4_tp);
}