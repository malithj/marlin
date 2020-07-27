#include <mkl.h>

#include <chrono>
#include <cstring>
#include <iostream>
#include <memory>

#ifdef ENABLE_JIT_PROFILE
#include "jitprofiling.h"
#endif

typedef uint64_t index_t;

void TEST() {
  // define constants
  const float alpha = 1.0f;
  const float beta = 0.f;

  index_t m, n, k;

  // warm up libraries
  m = 4;
  n = 4;
  k = 4;
  // define warm up matrices
  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(k * n * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  // set warm up matrices
  for (index_t i = 0; i < m * k; ++i) {
    A[i] = i;
  }
  for (index_t i = 0; i < k * n; ++i) {
    B[i] = i;
  }
  std::memset(C, 0, m * n * sizeof(float));

  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::nanoseconds duration;

  void *jitter;
  mkl_jit_status_t status =
      mkl_jit_create_sgemm(&jitter, MKL_ROW_MAJOR, MKL_NOTRANS, MKL_NOTRANS, m,
                           n, k, alpha, k, n, beta, n);
  if (MKL_JIT_ERROR == status) {
    throw std::runtime_error(
        "insufficient memory to JIT and store the SGEMM kernel");
  }

#ifdef ENABLE_JIT_PROFILE
  std::string name = "mkl_sgemm";
  iJIT_Method_Load ml;
  ml.method_id = iJIT_GetNewMethodID();
  ml.method_name = (char *)name.c_str();
  ml.method_load_address = reinterpret_cast<void *>(jitter);
  iJIT_NotifyEvent(iJVM_EVENT_TYPE_METHOD_LOAD_FINISHED, &ml);
#endif

  sgemm_jit_kernel_t mkl_sgemm = mkl_jit_get_sgemm_ptr(jitter);
  // rounds of warming up
  for (index_t i = 0; i < 10; ++i) {
    begin = std::chrono::steady_clock::now();
    mkl_sgemm(jitter, A, B, C);
    end = std::chrono::steady_clock::now();
    duration =
        std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
    std::cout << "duration: " << duration.count() << std::endl;
  }
  // destroy jitter
  status = mkl_jit_destroy(jitter);
  if (MKL_JIT_ERROR == status) {
    throw std::runtime_error("failed releasing JIT memory");
  }
  // warming up libraries end here
  std::free(A);
  std::free(B);
  std::free(C);
}

int main(int argc, char **argv) {
  TEST();
  return 0;
}
