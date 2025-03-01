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

#include "gemm/gemm.h"
#include "gtest/gtest.h"

extern "C" index_t asm_transpose(float *A, float *B, float *C, float *A_T,
                                 float *C_T, index_t m, index_t n, index_t k);

TEST(GEMM, CPP) {
  index_t m = 10;
  index_t n = 10;
  index_t k = 10;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));

  float C_REF[100] = {
      3355,  3410,  3465,  3520,  3575,  3630,  3685,  3740,  3795,  3850,
      7955,  8110,  8265,  8420,  8575,  8730,  8885,  9040,  9195,  9350,
      12555, 12810, 13065, 13320, 13575, 13830, 14085, 14340, 14595, 14850,
      17155, 17510, 17865, 18220, 18575, 18930, 19285, 19640, 19995, 20350,
      21755, 22210, 22665, 23120, 23575, 24030, 24485, 24940, 25395, 25850,
      26355, 26910, 27465, 28020, 28575, 29130, 29685, 30240, 30795, 31350,
      30955, 31610, 32265, 32920, 33575, 34230, 34885, 35540, 36195, 36850,
      35555, 36310, 37065, 37820, 38575, 39330, 40085, 40840, 41595, 42350,
      40155, 41010, 41865, 42720, 43575, 44430, 45285, 46140, 46995, 47850,
      44755, 45710, 46665, 47620, 48575, 49530, 50485, 51440, 52395, 53350};

  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < k; ++j) {
      A[i * k + j] = i * k + j + 1;
    }
  }
  for (index_t i = 0; i < k; ++i) {
    for (index_t j = 0; j < n; ++j) {
      index_t idx = i * n + j;
      B[i * n + j] = idx + 1;
    }
  }

  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
}

TEST(GEMM, ASM) {
  index_t m = 10;
  index_t n = 10;
  index_t k = 10;

  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::nanoseconds duration;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  float *A_T = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *C_T = static_cast<float *>(std::malloc(m * n * sizeof(float)));

  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < k; ++j) {
      index_t idx = i * k + j;
      A[i * k + j] = static_cast<float>(idx + 1);
    }
  }
  for (index_t i = 0; i < k; ++i) {
    for (index_t j = 0; j < n; ++j) {
      float idx = i * n + j;
      B[i * n + j] = static_cast<float>(idx + 1);
    }
  }
  memset(A_T, 0, sizeof(float) * m * k);

  asm_transpose(A, B, C, A_T, C_T, m, n, k);

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(A_T);
  std::free(C_T);
}