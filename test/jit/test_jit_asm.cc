#include <chrono>

#include "gemm/gemm.h"
#include "gtest/gtest.h"
#include "jit/jitter.h"

extern "C" index_t asm_gemm(index_t k, float *a, float *c, void *p_addr,
                            index_t *offset_data, uint32_t *arr_a,
                            uint32_t *arr_c, uint16_t mask, index_t idx);

TEST(JIT, ASM_GEMM) {
  index_t m = 16;
  index_t n = 15;
  index_t k = 1;
  index_t idx = 0;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  float *C_REF = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  uint32_t *temp =
      static_cast<uint32_t *>(std::malloc(m * n * sizeof(uint32_t)));

  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::nanoseconds duration;

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

  memset(C, 0, m * n * sizeof(float));
  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < n; ++j) {
      C[i * n + j] = j;
    }
  }

  // generate code
  std::shared_ptr<Jitter<float>> jitter = std::make_shared<Jitter<float>>();
  jitter->generate_code(B, m, k, n);
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  float x = asm_gemm(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
                     jitter->get_a_offsets(), jitter->get_c_offsets(),
                     jitter->get_mask(), idx);
  std::cout << x << std::endl;
  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < n; ++j) {
      std::cout << C[i * n + j] << " ";
    }
    std::cout << "" << std::endl;
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
  std::free(temp);
}