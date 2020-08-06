#include <chrono>

#include "gemm/gemm.h"
#include "gtest/gtest.h"
#include "jit/jitter.h"

extern "C" index_t asm_gemm(index_t m, index_t k, index_t n, float *a, float *c,
                            void *p_addr, index_t *offset_data, uint16_t mask,
                            index_t idx);

TEST(JIT, ASM_GEMM) {
  index_t m = 5;
  index_t n = 15;
  index_t k = 10;
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

  // generate code
  std::shared_ptr<Jitter<float>> jitter = std::make_shared<Jitter<float>>();
  jitter->generate_code(B, m, k, n);

  for (index_t i = 0; i < 100; ++i) {
    memset(C, 0, m * n * sizeof(float));
    memset(C_REF, 0, m * n * sizeof(float));
    gemm<float>('T', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
    begin = std::chrono::steady_clock::now();
    asm_gemm(m, k, n, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
             jitter->get_pmask(), idx);
    end = std::chrono::steady_clock::now();
    duration =
        std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
    std::cout << "duration: " << duration.count() << std::endl;
  }

  // asm: col major & gemm: row major
  for (index_t i = 0; i < n; ++i) {
    for (index_t j = 0; j < m; ++j) {
      EXPECT_EQ(C_REF[j * n + i], C[i * m + j]);
    }
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
  std::free(temp);
}