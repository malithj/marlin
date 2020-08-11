
#include "benchmark.h"

#include "onednn_matmul.h"

TEST(Benchmark, Jitters) {
  // lambda func defined to benchmark
  auto perf_bench = [=](const index_t mat_strt, const index_t mat_end,
                        const index_t mat_inc, const float sparsity,
                        const index_t iterations) {
    // define constants
    const float alpha = 1.0f;
    const float beta = 0.f;
    const index_t num_mat = (mat_end - mat_strt) / mat_inc;
    // vars in line: mat_size, dyn, stat, sgemm, ..., asm-conv, ...
    const index_t width = 9;
    const index_t height = num_mat;

    double *results =
        static_cast<double *>(aligned_alloc(height * width, sizeof(double)));
    memset(results, 0, sizeof(double) * height * width);

    index_t m, n, k;
    std::chrono::steady_clock::time_point begin;
    std::chrono::steady_clock::time_point end;
    std::chrono::nanoseconds duration;

    // warm up libraries
    m = 100;
    n = 100;
    k = 100;
    // define warm up matrices
    float *A = static_cast<float *>(aligned_alloc(m * k, sizeof(float)));
    float *B = static_cast<float *>(aligned_alloc(k * n, sizeof(float)));
    float *C = static_cast<float *>(aligned_alloc(m * n, sizeof(float)));
    // set warm up matrices to zero
    memset(A, 0, m * k * sizeof(float));
    memset(B, 0, k * n * sizeof(float));
    memset(C, 0, m * n * sizeof(float));
    void *jitter;
    mkl_jit_status_t status =
        mkl_jit_create_sgemm(&jitter, MKL_ROW_MAJOR, MKL_NOTRANS, MKL_NOTRANS,
                             m, n, k, alpha, k, n, beta, n);
    if (MKL_JIT_ERROR == status) {
      throw std::runtime_error(
          "insufficient memory to JIT and store the SGEMM kernel");
    }
    sgemm_jit_kernel_t mkl_sgemm = mkl_jit_get_sgemm_ptr(jitter);
    engine eng(engine::kind::cpu, 0);  // engine
    auto dynamic_matmul = dynamic_matmul_create(eng, beta);

    libxsmm_mmfunction<float> xsmm_wm_kernel(LIBXSMM_GEMM_FLAG_NONE, m, n, k,
                                             alpha, beta);

    // rounds of warming up
    for (index_t i = 0; i < 10; ++i) {
      mkl_sgemm(jitter, A, B, C);
      dynamic_matmul_execute(dynamic_matmul, eng, 'N', 'N', m, n, k, alpha, A,
                             k, B, n, beta, C, n);
      static_matmul_create_and_execute(eng, 'N', 'N', m, n, k, alpha, A, k, B,
                                       n, beta, C, n);
      xsmm_wm_kernel(A, B, C);
    }
    status = mkl_jit_destroy(jitter);
    if (MKL_JIT_ERROR == status) {
      throw std::runtime_error("failed releasing JIT memory");
    }
    aligned_free(A);
    aligned_free(B);
    aligned_free(C);
    // warming up libraries end here

    for (index_t mat_size = mat_strt; mat_size < mat_end; mat_size += mat_inc) {
      m = k = n = mat_size;
      float *A_ROW_MAJOR = static_cast<float *>(
          _mm_malloc(m * k * sizeof(float), ALIGN_BYTE_SIZE));
      float *A_COL_MAJOR = static_cast<float *>(
          _mm_malloc(m * k * sizeof(float), ALIGN_BYTE_SIZE));
      float *B_ROW_MAJOR = static_cast<float *>(
          _mm_malloc(k * n * sizeof(float), ALIGN_BYTE_SIZE));
      float *B_COL_MAJOR = static_cast<float *>(
          _mm_malloc(k * n * sizeof(float), ALIGN_BYTE_SIZE));
      float *C = static_cast<float *>(
          _mm_malloc(m * n * sizeof(float), ALIGN_BYTE_SIZE));
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

      const index_t offset = ((mat_size - mat_strt) / mat_inc) * width;
      results[offset] = mat_size;

      // ASM Jitter
      begin = std::chrono::steady_clock::now();
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
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      const index_t itr_strt = offset + 0;
      results[itr_strt + 4] = duration.count() / (iterations * 1000.0f);

      // MKL JIT
      begin = std::chrono::steady_clock::now();
      void *jitter;
      mkl_jit_status_t status =
          mkl_jit_create_sgemm(&jitter, MKL_COL_MAJOR, MKL_NOTRANS, MKL_NOTRANS,
                               m, n, k, alpha, k, n, beta, n);
      if (MKL_JIT_ERROR == status) {
        throw std::runtime_error(
            "insufficient memory to JIT and store the DGEMM kernel");
      }
      // retrieve the function pointer to the SGEMM kernel
      sgemm_jit_kernel_t mkl_sgemm = mkl_jit_get_sgemm_ptr(jitter);
      for (index_t i = 0; i < iterations; ++i) {
        mkl_sgemm(jitter, A_COL_MAJOR, B_COL_MAJOR, C);
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 5] = duration.count() / (iterations * 1000.0f);

      // LIBXSMM
      begin = std::chrono::steady_clock::now();
      libxsmm_mmfunction<float> xsmm_kernel(LIBXSMM_GEMM_FLAG_NONE, m, n, k,
                                            alpha, beta);
      for (index_t i = 0; i < iterations; ++i) {
        xsmm_kernel(A_COL_MAJOR, B_COL_MAJOR, C);
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 6] = duration.count() / (iterations * 1000.0f);

      // execute dynamic matmul
      begin = std::chrono::steady_clock::now();
      engine eng(engine::kind::cpu, 0);  // engine
      auto dynamic_matmul = dynamic_matmul_create(eng, beta);
      for (index_t i = 0; i < iterations; ++i) {
        dynamic_matmul_execute(dynamic_matmul, eng, 'N', 'N', m, n, k, alpha,
                               A_ROW_MAJOR, k, B_ROW_MAJOR, n, beta, C, n);
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 1] = duration.count() / (iterations * 1000.0f);

      // execute static matmul
      begin = std::chrono::steady_clock::now();
      for (index_t i = 0; i < iterations; ++i) {
        static_matmul_create_and_execute(eng, 'N', 'N', m, n, k, alpha,
                                         A_ROW_MAJOR, k, B_ROW_MAJOR, n, beta,
                                         C, n);
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 2] = duration.count() / (iterations * 1000.0f);

      // dnnl sgemm
      begin = std::chrono::steady_clock::now();
      for (index_t i = 0; i < iterations; ++i) {
        dnnl_sgemm('N', 'N', m, n, k, alpha, A_ROW_MAJOR, k, B_ROW_MAJOR, n,
                   beta, C, n);
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 3] = duration.count() / (iterations * 1000.0f);

      Map<MatrixXf> eigen_A(A_COL_MAJOR, m, k);
      Map<MatrixXf> eigen_B(B_COL_MAJOR, k, n);
      Map<MatrixXf> eigen_C(C, m, n);

      // eigen
      begin = std::chrono::steady_clock::now();
      for (index_t i = 0; i < iterations; ++i) {
        eigen_C = eigen_A * eigen_B;
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 7] = duration.count() / (iterations * 1000.0f);

      // OpenBLAS
      begin = std::chrono::steady_clock::now();
      for (index_t i = 0; i < iterations; ++i) {
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1,
                    A_ROW_MAJOR, k, B_ROW_MAJOR, n, 0, C, n);
      }
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 8] = duration.count() / (iterations * 1000.0f);

      status = mkl_jit_destroy(jitter);
      if (MKL_JIT_ERROR == status) {
        throw std::runtime_error("failed releasing JIT memory");
      }
      _mm_free(A_ROW_MAJOR);
      _mm_free(A_COL_MAJOR);
      _mm_free(B_ROW_MAJOR);
      _mm_free(B_COL_MAJOR);
      _mm_free(C);
    }

    std::stringstream stream;
    stream << mat_strt << "_" << (mat_end - mat_inc) << "_" << mat_inc << "_"
           << std::fixed << std::setprecision(2) << sparsity << "_"
           << iterations << "_"
           << std::chrono::duration_cast<std::chrono::seconds>(
                  std::chrono::system_clock::now().time_since_epoch())
                  .count();
    std::string s = stream.str();
    std::string filename;
    filename = "build/results/benchmark_results_" + s + ".csv";
    std::string header =
        "IDX,MAT_SIZE,ONEDNN_DYNAMIC,ONEDNN_STATIC,ONEDNN_SGEMM,"
        "MARLIN,MKL_JIT,LIBXSMM,EIGEN,OPENBLAS";
    tofile(filename, results, height, width, header);
    aligned_free(results);
  };

  perf_bench(1, 33, 1, 0, 100);
  perf_bench(1, 33, 1, 0, 1000);
}
