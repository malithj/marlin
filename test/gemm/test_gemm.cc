#include <chrono>

#include "gemm/gemm.h"
#include "gtest/gtest.h"

TEST(GEMM, CPP) {
  index_t m = 10;
  index_t n = 10;
  index_t k = 10;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));

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

  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < n; ++j) {
      std::cout << C[i * n + j] << " ";
    }
    std::cout << " " << std::endl;
  }

  std::free(A);
  std::free(B);
  std::free(C);
}