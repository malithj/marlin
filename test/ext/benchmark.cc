
#include "benchmark.h"

#include "onednn_matmul.h"

TEST(Benchmark, Jitters) {
  // lambda func defined to benchmark
  auto perf_bench = [=](index_t mat_strt, index_t mat_end, index_t mat_inc,
                        float sparsity) {
    // define constants
    const float alpha = 1.0f;
    const float beta = 0.f;
    const index_t iterations = 100;
    const index_t num_mat = (mat_end - mat_strt) / mat_inc;
    // vars in line: mat_size, dyn, stat, sgemm, ..., asm-conv, ...
    const index_t width = 7;
    const index_t height = iterations * num_mat;

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
                                             1.0 /*alpha*/, 1.0 /*beta*/);

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
      float *A = static_cast<float *>(aligned_alloc(m * k, sizeof(float)));
      float *B = static_cast<float *>(aligned_alloc(k * n, sizeof(float)));
      float *C = static_cast<float *>(aligned_alloc(m * n, sizeof(float)));
      for (index_t h = 0; h < m; ++h) {
        for (index_t w = 0; w < k; ++w) {
          index_t idx = h * k + w;
          A[idx] = idx + 1;
        }
      }
      for (index_t h = 0; h < k; ++h) {
        for (index_t w = 0; w < n; ++w) {
          index_t idx = h * n + w;
          B[idx] = sparsity_adjustment(sparsity);
        }
      }

      const index_t offset =
          ((mat_size - mat_strt) / mat_inc) * iterations * width;

      // ASM Jitter
      begin = std::chrono::steady_clock::now();
      std::shared_ptr<Jitter<float>> jit_ = std::make_shared<Jitter<float>>();
      jit_->generate_code(B, m, k, n);
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      const index_t itr_strt = offset + 0;
      results[itr_strt + 4] = duration.count() / 1000.0f;

      void *jitter;
      begin = std::chrono::steady_clock::now();
      mkl_jit_status_t status =
          mkl_jit_create_sgemm(&jitter, MKL_ROW_MAJOR, MKL_NOTRANS, MKL_NOTRANS,
                               m, n, k, alpha, k, n, beta, n);
      end = std::chrono::steady_clock::now();
      if (MKL_JIT_ERROR == status) {
        throw std::runtime_error(
            "insufficient memory to JIT and store the DGEMM kernel");
      }
      // retrieve the function pointer to the SGEMM kernel
      sgemm_jit_kernel_t mkl_sgemm = mkl_jit_get_sgemm_ptr(jitter);
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 5] = duration.count() / 1000.0f;

      begin = std::chrono::steady_clock::now();
      libxsmm_mmfunction<float> xsmm_kernel(LIBXSMM_GEMM_FLAG_NONE, m, n, k,
                                            1.0 /*alpha*/, 1.0 /*beta*/);
      end = std::chrono::steady_clock::now();
      duration =
          std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
      results[itr_strt + 6] = duration.count() / 1000.0f;

      for (index_t i = 0; i < iterations; ++i) {
        const index_t itr_strt = offset + i * width;
        // set mat size
        results[itr_strt] = mat_size;

        // execute dynamic matmul
        engine eng(engine::kind::cpu, 0);  // engine
        auto dynamic_matmul = dynamic_matmul_create(eng, beta);
        begin = std::chrono::steady_clock::now();
        dynamic_matmul_execute(dynamic_matmul, eng, 'N', 'N', m, n, k, alpha, A,
                               k, B, n, beta, C, n);
        end = std::chrono::steady_clock::now();
        duration =
            std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
        results[itr_strt + 1] = duration.count() / 1000.0f;

        begin = std::chrono::steady_clock::now();
        static_matmul_create_and_execute(eng, 'N', 'N', m, n, k, alpha, A, k, B,
                                         n, beta, C, n);
        end = std::chrono::steady_clock::now();
        duration =
            std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
        results[itr_strt + 2] = duration.count() / 1000.0f;

        begin = std::chrono::steady_clock::now();
        dnnl_sgemm('N', 'N', m, n, k, alpha, A, k, B, n, beta, C, n);
        end = std::chrono::steady_clock::now();
        duration =
            std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
        results[itr_strt + 3] = duration.count() / 1000.0f;

        begin = std::chrono::steady_clock::now();
        MARLIN::sgemm('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n, jit_);
        end = std::chrono::steady_clock::now();
        duration =
            std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
        results[itr_strt + 4] += duration.count() / 1000.0f;

        begin = std::chrono::steady_clock::now();
        mkl_sgemm(jitter, A, B, C);
        end = std::chrono::steady_clock::now();
        duration =
            std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
        results[itr_strt + 5] += duration.count() / 1000.0f;

        begin = std::chrono::steady_clock::now();
        xsmm_kernel(A, B, C);
        end = std::chrono::steady_clock::now();
        duration =
            std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
        results[itr_strt + 6] += duration.count() / 1000.0f;
      }
      status = mkl_jit_destroy(jitter);
      if (MKL_JIT_ERROR == status) {
        throw std::runtime_error("failed releasing JIT memory");
      }
      aligned_free(A);
      aligned_free(B);
      aligned_free(C);
    }

    std::stringstream stream;
    stream << mat_strt << "_" << (mat_end - mat_inc) << "_" << mat_inc << "_"
           << std::fixed << std::setprecision(2) << sparsity << "_"
           << std::chrono::duration_cast<std::chrono::seconds>(
                  std::chrono::system_clock::now().time_since_epoch())
                  .count();
    std::string s = stream.str();
    std::string filename;
    filename = "build/results/benchmark_results_" + s + ".csv";
    std::string header =
        "IDX,MAT_SIZE,ONEDNN_DYNAMIC,ONEDNN_STATIC,ONEDNN_SGEMM,"
        "MARLIN,MKL_JIT,LIBXSMM";
    tofile(filename, results, height, width, header);
    aligned_free(results);
  };

  // matrix start: 20
  // matrix end: 105
  // matrix increment: 5
  // sparsity: 0
  perf_bench(20, 105, 5, 0);
  // matrix start: 100
  // matrix end: 2000
  // matrix increment: 100
  // sparsity: 0%
  //   perf_bench(100, 2100, 100, 0);
}