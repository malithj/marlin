#include <chrono>

#include "gemm/gemm.h"
#include "gtest/gtest.h"
#include "jit/jitter.h"

extern "C" index_t asm_gemm_f32_j13(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

extern "C" index_t asm_gemm_f32_j14(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

TEST(ASM_GEMM, f32_j13) {
  constexpr index_t m = 16;
  constexpr index_t n = 13;
  constexpr index_t k = 15;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  float *C_REF = static_cast<float *>(std::malloc(m * n * sizeof(float)));

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
  index_t idx = 0;

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  asm_gemm_f32_j13(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
                   jitter->get_a_offsets(), jitter->get_c_offsets(),
                   jitter->get_mask(), idx);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(ASM_GEMM, f32_j14) {
  constexpr index_t m = 16;
  constexpr index_t n = 14;
  constexpr index_t k = 15;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  float *C_REF = static_cast<float *>(std::malloc(m * n * sizeof(float)));

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
  index_t idx = 0;

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  asm_gemm_f32_j14(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
                   jitter->get_a_offsets(), jitter->get_c_offsets(),
                   jitter->get_mask(), idx);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}