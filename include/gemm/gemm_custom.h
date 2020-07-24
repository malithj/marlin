#ifndef __GEMM_CUSTOM_H_
#define __GEMM_CUSTOM_H_

#include "../types/types.h"

template <typename T>
class GEMM {
 public:
  GEMM(){};
  // Performs GEMM (General Matrix Multiplication) using AVX512 assembly
  // block size for all three dimensions is set to the above "N" value by
  // default.
  // The following variables are used to define the functionality (compatible
  // with available BLAS APIs)
  //
  // parameters
  // ----------
  // transa - whether to transpose A ('N|n': use original, 'T|t': transpose)
  // transb - whether to transpose B ('N|n': use original, 'T|t': transpose)
  // m      - number of rows in matrix A (row major)
  // n      - number of columns in matrix B (row major)
  // k      - numer of columns in matrix A and rows in matrix B (row major)
  // alpha  - factor of matrix A (alpha * AB + beta * C) @TODO(malith):
  // a      - pointer of type T of matrix A
  // lda    - leading dimension of matrix A (stride offset) @TODO(malith):
  // b      - pointer of type T of matrix B
  // ldb    - leading dimension of matrix B (stride offset) @TODO(malith):
  // beta   - factor of matrix B (alpha * AB + beta * C) @TODO(malith):
  // c      - pointer of type T of matrix C
  // ldc    - leading dimension of matrix C (stride offset) @TODO(malith):
  // cs     - pointer of code store with instructions of matrix B
  index_t gemm(char transa, char transb, index_t m, index_t n, index_t k,
               T alpha, T* a, index_t lda, T* b, index_t ldb, T beta, T* c);
};

template <typename T>
index_t GEMM<T>::gemm(char transa, char transb, index_t m, index_t n, index_t k,
                      T alpha, T* a, index_t lda, T* b, index_t ldb, T beta,
                      T* c) {}

#endif
