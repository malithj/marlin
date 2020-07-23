#include <mkl.h>

#include <chrono>
#include <cstring>
#include <iostream>
#include <memory>

typedef uint64_t index_t;

void TEST() {
  // define constants
  const float alpha = 1.0f;
  const float beta = 0.f;

  index_t m, n, k;

  // warm up libraries
  m = 10;
  n = 10;
  k = 10;
  // define warm up matrices
  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(k * n * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  // set warm up matrices to zero
  std::memset(A, 0, m * k * sizeof(float));
  std::memset(B, 0, k * n * sizeof(float));
  std::memset(C, 0, m * n * sizeof(float));
  void *jitter;
  mkl_jit_status_t status =
      mkl_jit_create_sgemm(&jitter, MKL_ROW_MAJOR, MKL_NOTRANS, MKL_NOTRANS, m,
                           n, k, alpha, k, n, beta, n);
  if (MKL_JIT_ERROR == status) {
    throw std::runtime_error(
        "insufficient memory to JIT and store the SGEMM kernel");
  }
  sgemm_jit_kernel_t mkl_sgemm = mkl_jit_get_sgemm_ptr(jitter);

  // rounds of warming up
  mkl_sgemm(jitter, A, B, C);
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
