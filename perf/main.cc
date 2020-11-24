#include "../ext/benchmark.h"
#include "../ext/onednn_matmul.h"

int main(int argc, char *argv[]) {
  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::microseconds duration;
  begin = std::chrono::steady_clock::now();
  index_t m = 100;
  index_t n = 100;
  index_t k = 100;
  index_t iterations = 100;
  index_t mode = 0;
  float sparsity = 0;
  const index_t alpha = 1.0f;
  const index_t beta = 0.0f;

  auto help = [] {
    printf("asmGEMM. Distributed as part of profiling.\n");
    printf("\nusage: perf M N K ITERATIONS MODE [SPARSITY]\n");
    printf("\nThe modes supported by perf are:\n");
    printf("  0\toneDNN dynamic\n");
    printf("  1\toneDNN static\n");
    printf("  2\toneDNN sgemm\n");
    printf("  3\tMARLIN\n");
    printf("  4\tIntel MKL\n");
    printf("  5\tLIBXSMM\n");
    printf("  6\tEigen\n");
    printf("  7\tOpenBLAS\n");
    printf("\nSee 'perf help for more tool help'\n");
  };

  auto check_digit = [](char *value) {
    if (!isdigit(*value)) {
      throw std::runtime_error("cannot parse values. check usage");
    }
    return atoi(value);
  };

  auto check_float = [](char *value) {
    float sparsity;
    try {
      sparsity = std::stof(value);
    } catch (std::exception &e) {
      throw std::runtime_error("cannot parse values. check usage");
    }
    return sparsity;
  };

  if (argc == 6) {
    m = check_digit(argv[1]);
    n = check_digit(argv[2]);
    k = check_digit(argv[3]);
    iterations = check_digit(argv[4]);
    mode = check_digit(argv[5]);
    printf(
        "perf invoked with args: M=%ld, N=%ld, K=%ld, iterations=%ld, "
        "mode=%ld\n",
        m, n, k, iterations, mode);
  } else if (argc == 7) {
    m = check_digit(argv[1]);
    n = check_digit(argv[2]);
    k = check_digit(argv[3]);
    iterations = check_digit(argv[4]);
    mode = check_digit(argv[5]);
    sparsity = check_float(argv[6]);
    printf(
        "perf invoked with args: M=%ld, N=%ld, K=%ld, iterations=%ld, "
        "mode=%ld, sparsity=%.2f\n",
        m, n, k, iterations, mode, sparsity);
  } else {
    help();
  }

  float *A_ROW_MAJOR =
      static_cast<float *>(_mm_malloc(m * k * sizeof(float), ALIGN_BYTE_SIZE));
  float *A_COL_MAJOR =
      static_cast<float *>(_mm_malloc(m * k * sizeof(float), ALIGN_BYTE_SIZE));
  float *B_ROW_MAJOR =
      static_cast<float *>(_mm_malloc(k * n * sizeof(float), ALIGN_BYTE_SIZE));
  float *B_COL_MAJOR =
      static_cast<float *>(_mm_malloc(k * n * sizeof(float), ALIGN_BYTE_SIZE));
  float *C =
      static_cast<float *>(_mm_malloc(m * n * sizeof(float), ALIGN_BYTE_SIZE));
  for (index_t h = 0; h < m; ++h) {
    for (index_t w = 0; w < k; ++w) {
      index_t idx = h * k + w;
      A_COL_MAJOR[idx] = idx + 1;
      A_ROW_MAJOR[w * m + h] = idx + 1;
    }
  }
  for (index_t h = 0; h < k; ++h) {
    for (index_t w = 0; w < n; ++w) {
      index_t idx = h * n + w;
      B_ROW_MAJOR[idx] = sparsity_adjustment(sparsity);
      B_COL_MAJOR[w * k + h] = B_ROW_MAJOR[idx];
    }
  }

  if (mode == 0) {
    // execute dynamic matmul
    engine eng(engine::kind::cpu, 0);  // engine
    auto dynamic_matmul = dynamic_matmul_create(eng, beta);
    for (index_t i = 0; i < iterations; ++i) {
      dynamic_matmul_execute(dynamic_matmul, eng, 'N', 'N', m, n, k, alpha,
                             A_ROW_MAJOR, k, B_ROW_MAJOR, n, beta, C, n);
    }
  } else if (mode == 1) {
    engine eng(engine::kind::cpu, 0);  // engine
    auto dynamic_matmul = dynamic_matmul_create(eng, beta);
    for (index_t i = 0; i < iterations; ++i) {
      static_matmul_create_and_execute(eng, 'N', 'N', m, n, k, alpha,
                                       A_ROW_MAJOR, k, B_ROW_MAJOR, n, beta, C,
                                       n);
    }
  } else if (mode == 2) {
    for (index_t i = 0; i < iterations; ++i) {
      dnnl_sgemm('N', 'N', m, n, k, alpha, A_ROW_MAJOR, k, B_ROW_MAJOR, n, beta,
                 C, n);
    }
  } else if (mode == 3) {
#ifdef ENABLE_JIT
    std::shared_ptr<Jitter<float>> jit_ = std::make_shared<Jitter<float>>();
    jit_->generate_code(B_ROW_MAJOR, m, k, n);
#endif
    for (index_t i = 0; i < iterations; ++i) {
#ifdef ENABLE_JIT
      MARLIN::sgemm('N', 'N', m, n, k, 1.0, A_COL_MAJOR, k, B_ROW_MAJOR, n, 0,
                    C, n, jit_);
#else
      MARLIN::sgemm('N', 'N', m, n, k, 1.0, A_COL_MAJOR, k, B_ROW_MAJOR, n, 0,
                    C, n);
#endif
    }
  } else if (mode == 4) {
    void *jitter;
    mkl_jit_status_t status =
        mkl_jit_create_sgemm(&jitter, MKL_COL_MAJOR, MKL_NOTRANS, MKL_NOTRANS,
                             m, n, k, alpha, m, k, beta, m);
    if (MKL_JIT_ERROR == status) {
      throw std::runtime_error(
          "insufficient memory to JIT and store the DGEMM kernel");
    }
    // retrieve the function pointer to the SGEMM kernel
    sgemm_jit_kernel_t mkl_sgemm = mkl_jit_get_sgemm_ptr(jitter);
    for (index_t i = 0; i < iterations; ++i) {
      mkl_sgemm(jitter, A_COL_MAJOR, B_COL_MAJOR, C);
    }
  } else if (mode == 5) {
    libxsmm_mmfunction<float> xsmm_kernel(LIBXSMM_GEMM_FLAG_NONE, m, n, k,
                                          alpha, beta);
    for (index_t i = 0; i < iterations; ++i) {
      xsmm_kernel(A_COL_MAJOR, B_COL_MAJOR, C);
    }
  } else if (mode == 6) {
    Map<MatrixXf> eigen_A(A_COL_MAJOR, m, k);
    Map<MatrixXf> eigen_B(B_COL_MAJOR, k, n);
    Map<MatrixXf> eigen_C(C, m, n);

    // eigen
    for (index_t i = 0; i < iterations; ++i) {
      eigen_C = eigen_A * eigen_B;
    }
  } else if (mode == 7) {
    for (index_t i = 0; i < iterations; ++i) {
      cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1,
                  A_ROW_MAJOR, k, B_ROW_MAJOR, n, 0, C, n);
    }
  } else {
    printf("WARN: exiting perf without profiled execution!\n");
  }
  end = std::chrono::steady_clock::now();
  duration = std::chrono::duration_cast<std::chrono::microseconds>(end - begin);
  printf("perf execution time: %ld microseconds\n", duration.count());
  _mm_free(A_ROW_MAJOR);
  _mm_free(A_COL_MAJOR);
  _mm_free(B_ROW_MAJOR);
  _mm_free(B_COL_MAJOR);
  _mm_free(C);
  return 0;
}