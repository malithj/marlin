#include <chrono>

#include "gemm/gemm.h"
#include "gemm/kernels/gemm_f32_j1.h"
#include "gemm/kernels/gemm_f32_j10.h"
#include "gemm/kernels/gemm_f32_j11.h"
#include "gemm/kernels/gemm_f32_j12.h"
#include "gemm/kernels/gemm_f32_j13.h"
#include "gemm/kernels/gemm_f32_j14.h"
#include "gemm/kernels/gemm_f32_j15.h"
#include "gemm/kernels/gemm_f32_j2.h"
#include "gemm/kernels/gemm_f32_j3.h"
#include "gemm/kernels/gemm_f32_j4.h"
#include "gemm/kernels/gemm_f32_j5.h"
#include "gemm/kernels/gemm_f32_j6.h"
#include "gemm/kernels/gemm_f32_j7.h"
#include "gemm/kernels/gemm_f32_j8.h"
#include "gemm/kernels/gemm_f32_j9.h"
#include "gtest/gtest.h"

TEST(GEMM, f32_j1) {
  index_t m = 15;
  index_t n = 1;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j1('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j2) {
  index_t m = 12;
  index_t n = 2;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j2('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j3) {
  index_t m = 12;
  index_t n = 3;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j3('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j4) {
  index_t m = 12;
  index_t n = 4;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j4('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j5) {
  index_t m = 12;
  index_t n = 5;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j5('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j6) {
  index_t m = 12;
  index_t n = 6;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j6('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j7) {
  index_t m = 12;
  index_t n = 7;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j7('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j8) {
  index_t m = 12;
  index_t n = 8;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j8('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j9) {
  index_t m = 12;
  index_t n = 9;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j9('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j10) {
  index_t m = 10;
  index_t n = 10;
  index_t k = 10;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j10('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j11) {
  constexpr index_t m = 11;
  constexpr index_t n = 11;
  constexpr index_t k = 12;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j11('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j12) {
  constexpr index_t m = 12;
  constexpr index_t n = 12;
  constexpr index_t k = 13;

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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j12('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
}

TEST(GEMM, f32_j13) {
  constexpr index_t m = 13;
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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j13('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j14) {
  constexpr index_t m = 14;
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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j14('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}

TEST(GEMM, f32_j15) {
  constexpr index_t m = 15;
  constexpr index_t n = 15;
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

  memset(C, 0, m * n * sizeof(float));
  memset(C_REF, 0, m * n * sizeof(float));
  gemm<float>('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C_REF, n);
  gemm_f32_j15('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n);

  for (index_t i = 0; i < m * n; ++i) {
    EXPECT_EQ(C_REF[i], C[i]);
  }

  std::free(A);
  std::free(B);
  std::free(C);
  std::free(C_REF);
}