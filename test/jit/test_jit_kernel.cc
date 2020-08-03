#include <chrono>

#include "gemm/asm_kernels.h"
#include "gemm/gemm.h"
#include "gtest/gtest.h"
#include "jit/jitter.h"

TEST(ASM_GEMM, f32_j1) {
  constexpr index_t m = 16;
  constexpr index_t n = 1;
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
  asm_gemm_f32_j1(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j2) {
  constexpr index_t m = 16;
  constexpr index_t n = 2;
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
  asm_gemm_f32_j2(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j3) {
  constexpr index_t m = 16;
  constexpr index_t n = 3;
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
  asm_gemm_f32_j3(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j4) {
  constexpr index_t m = 16;
  constexpr index_t n = 4;
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
  asm_gemm_f32_j4(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j5) {
  constexpr index_t m = 16;
  constexpr index_t n = 5;
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
  asm_gemm_f32_j5(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j6) {
  constexpr index_t m = 16;
  constexpr index_t n = 6;
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
  asm_gemm_f32_j6(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j7) {
  constexpr index_t m = 16;
  constexpr index_t n = 7;
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
  asm_gemm_f32_j7(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j8) {
  constexpr index_t m = 16;
  constexpr index_t n = 8;
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
  asm_gemm_f32_j8(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j9) {
  constexpr index_t m = 16;
  constexpr index_t n = 9;
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
  asm_gemm_f32_j9(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j10) {
  constexpr index_t m = 16;
  constexpr index_t n = 10;
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
  asm_gemm_f32_j10(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j11) {
  constexpr index_t m = 16;
  constexpr index_t n = 11;
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
  asm_gemm_f32_j11(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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

TEST(ASM_GEMM, f32_j12) {
  constexpr index_t m = 16;
  constexpr index_t n = 12;
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
  asm_gemm_f32_j12(k, A, C, jitter->get_p_addr(), jitter->get_offset_data(),
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