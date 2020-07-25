#include <chrono>

#include "gemm/gemm_custom.h"
#include "gtest/gtest.h"

TEST(GEMM, CustomTest) {
  GEMM<float> gemm;
  index_t m = 10;
  index_t n = 10;
  index_t k = 10;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  float *A_T = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *C_T = static_cast<float *>(std::malloc(m * n * sizeof(float)));

  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < k; ++j) {
      A[i * k + j] = i * k + j + 1;
    }
  }
  for (index_t i = 0; i < k; ++i) {
    for (index_t j = 0; j < n; ++j) {
      B[i * n + j] = 1;
    }
  }

  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::nanoseconds duration;

  for (index_t i = 0; i < 100; ++i) {
    begin = std::chrono::steady_clock::now();
    gemm.gemm('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, A_T, C_T);
    end = std::chrono::steady_clock::now();
    duration =
        std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
    std::cout << "duration: " << duration.count() << std::endl;
  }
  // for (index_t i = 0; i < m; ++i) {
  //   for (index_t j = 0; j < k; ++j) {
  //     std::cout << A_T[i * k + j] << " ";
  //   }
  //   std::cout << " " << std::endl;
  // }
  // for (index_t i = 0; i < m; ++i) {
  //   for (index_t j = 0; j < n; ++j) {
  //     std::cout << C[i * n + j] << " ";
  //   }
  //   std::cout << " " << std::endl;
  // }
  std::free(A_T);
  std::free(C_T);
  EXPECT_EQ(1, 1);
}