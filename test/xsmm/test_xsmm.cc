#include <immintrin.h>
#include <libxsmm.h>

#include <chrono>

#include "constants/constants.h"
#include "gemm/gemm.h"
#include "gtest/gtest.h"

TEST(LIBXSMM, Test) {
  index_t m = 10;
  index_t n = 10;
  index_t k = 10;

  libxsmm_mmfunction<float> xsmm_kernel(LIBXSMM_GEMM_FLAG_NONE, m, n, k,
                                        1.0 /*alpha*/, 0.0 /*beta*/);
  float *A =
      static_cast<float *>(_mm_malloc(m * k * sizeof(float), ALIGN_BYTE_SIZE));
  float *B =
      static_cast<float *>(_mm_malloc(k * n * sizeof(float), ALIGN_BYTE_SIZE));
  float *C =
      static_cast<float *>(_mm_malloc(m * n * sizeof(float), ALIGN_BYTE_SIZE));
  float *C_REF =
      static_cast<float *>(_mm_malloc(m * n * sizeof(float), ALIGN_BYTE_SIZE));

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('T', 'T', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  xsmm_kernel(A, B, C);

  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < n; ++j) {
      EXPECT_EQ(C_REF[j * m + i], C[i * n + j]);
    }
  }

  _mm_free(A);
  _mm_free(B);
  _mm_free(C);
  _mm_free(C_REF);
}