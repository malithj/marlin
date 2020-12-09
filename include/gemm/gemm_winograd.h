#ifndef __GEMM_WINOGRAD_H_
#define __GEMM_WINOGRAD_H_

#include <mkl.h>

#include "dnnl.hpp"
#include "types/types.h"

template <typename T>
class GEMMWinograd {
 public:
  GEMMWinograd() { lib_switch = LIBMKL; };
  ~GEMMWinograd() = default;
  void compute(T* A, T* B, index_t batch, index_t m, index_t n, index_t k,
               T* C);
  void sgemm(char transa, char transb, index_t m, index_t n, index_t k, T alpha,
             const T* a, index_t lda, const T* b, index_t ldb, T beta, T* c,
             index_t ldc);
  void set_switch(gemm_library lib_switch) { this->lib_switch = lib_switch; }

 private:
  gemm_library lib_switch;
};

template <typename T>
void GEMMWinograd<T>::compute(T* A, T* B, index_t batch, index_t m, index_t n,
                              index_t k, T* C) {
  if (!std::is_same<T, float>::value) {
    throw std::runtime_error("type mismatch. only floats are supported.");
  }

#pragma omp parallel for
  for (index_t b = 0; b < batch; ++b) {
    T* mat_a = A + (m * k) * b;
    T* mat_b = B + (n * k) * b;
    T* mat_c = C + (m * n) * b;
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, mat_a, k,
                mat_b, n, 0, mat_c, n);
  }
}

template <typename T>
void GEMMWinograd<T>::sgemm(char transa, char transb, index_t m, index_t n,
                            index_t k, T alpha, const T* a, index_t lda,
                            const T* b, index_t ldb, T beta, T* c,
                            index_t ldc) {
  if (lib_switch == LIBMKL) {
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, a, k, b,
                n, 0, c, n);
  } else if (lib_switch == LIBONEDNN) {
    dnnl_sgemm('N', 'N', m, n, k, 1, a, k, b, n, 0, c, n);
  }
}

#endif