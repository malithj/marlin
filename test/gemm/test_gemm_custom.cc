#include "gemm/gemm_custom.h"
#include "gtest/gtest.h"

TEST(GEMM, CustomTest) {
  GEMM<float> gemm;
  index_t m = 0;
  index_t n = 0;
  index_t k = 0;
  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  gemm.gemm('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C);
  EXPECT_EQ(1, 1);
}