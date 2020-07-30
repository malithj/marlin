#ifndef __GEMM_H_
#define __GEMM_H_

#include <immintrin.h>
#include <string.h>

#include <memory>

#include "../log/logging.h"
#include "../types/types.h"

// Performs GEMM (General Matrix Multiplication)
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
template <class T>
index_t gemm(char transa, char transb, index_t m, index_t n, index_t k, T alpha,
             T* a, index_t lda, T* b, index_t ldb, T beta, T* c, index_t ldc) {
  index_t a_t = 0;
  index_t b_t = 0;
  if (transa == 'N' || transa == 'n') {
    LOG_DEBUG("matrix A is not being transposed");
  } else if (transa == 'T' || transa == 'T') {
    LOG_DEBUG("matrix A is being transposed");
    a_t = 1;
  } else {
    std::string mode(1, transa);
    throw std::runtime_error("unknown matrix mode provided: " + mode);
  }
  if (transb == 'N' || transb == 'n') {
    LOG_DEBUG("matrix B is not being transposed");
  } else if (transb == 'T' || transb == 'T') {
    LOG_DEBUG("matrix B is being transposed");
    b_t = 1;
  } else {
    std::string mode(1, transb);
    throw std::runtime_error("unknown matrix mode provided: " + mode);
  }

  // init c matrix to zero
  //
  // IEEE 754 standard float zero is compatible with setting four characters of
  // zero. memset should only be used to set bytes (characters) but since zero
  // is an exceptional case, a contiguous block is made zero when decltype(T) is
  // float or double.
  memset(c, 0, sizeof(T) * m * n);

#ifndef __AVX512F__
  /* compute block matrix result */
  for (index_t ii = 0; ii < m; ++ii) {
    for (index_t jj = 0; jj < n; ++jj) {
      for (index_t kk = 0; kk < k; ++kk) {
        c[ii * n + jj] += a[(kk * m + ii) * a_t + (ii * k + kk) * (1 - a_t)] *
                          b[(jj * k + kk) * b_t + (kk * n + jj) * (1 - b_t)];
      }
    }
  }

#else
  // need to transpose b if transpose b mode is not activated.
  // this is to make sure that AVX registers are filled in a
  // contiguous order. Fixing index lookup within the loop can
  // be expensive. Hence the transpose is done here.
  T* b_t_mat;
  if (b_t) {
    b_t_mat = static_cast<T*>(std::malloc(k * n * sizeof(T)));
    // @TODO(malith): fix align alloc
    // matrix using index swap @TODO(malith): add a helper method to swap
    // values using AVX unpacklo, unpackhi, shuffle / permute for larger sizes
    for (index_t h = 0; h < n; ++h) {
      for (index_t w = 0; w < k; ++w) {
        b_t_mat[w * n + h] = b[h * k + w];
      }
    }
  } else {
    b_t_mat = b;
  }

  // need to transpose a if transpose a mode is activated.
  // this is to make sure that AVX registers are filled in a
  // contiguous order. Fixing index lookup within the loop can
  // be expensive. Hence the transpose is done here.
  T* a_t_mat;
  if (!a_t) {
    a_t_mat = static_cast<T*>(std::malloc(m * k * sizeof(T)));
    // @TODO(malith): fix align alloc
    // matrix using index swap @TODO(malith): add a helper method to swap
    // values using AVX unpacklo, unpackhi, shuffle / permute for larger sizes
    for (index_t h = 0; h < m; ++h) {
      for (index_t w = 0; w < k; ++w) {
        a_t_mat[w * m + h] = a[h * k + w];
      }
    }
  } else {
    b_t_mat = b;
  }

  T* c_t_mat = static_cast<T*>(std::malloc(m * n * sizeof(T)));
  memset(c_t_mat, 0, sizeof(T) * m * n);

  for (index_t kk = 0; kk < k; ++kk) {
    for (index_t ii = 0; ii < m; ii += 16) {
      // load 16 rows of column kk of A to one AVX register
      uint16_t iamsk = (m - ii) >= 16 ? 0xffff                  // case 1.
                                      : ~(0xffff << (m - ii));  // case 2.
      __mmask16 amsk = _mm512_int2mask(iamsk);
      __m512 aymm0 = _mm512_maskz_loadu_ps(amsk, a_t_mat + kk * m + ii);

      for (index_t jj = 0; jj < n; jj += 15) {
        // load 15 columns of row kk of B to 15 AVX registers(broadcast)
        // dummy AVX register to handle zero broadcast
        __mmask16 bmsk;
        __mmask16 cmsk;
        __m128 broadcast_value;
        uint16_t ibmsk = (n - jj) >= 15 ? ~(0xffff << 15)         // case 1.
                                        : ~(0xffff << (n - jj));  // case 2.
        bmsk = _mm512_int2mask(ibmsk & 1 ? iamsk : 0);

        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj);
        __m512 bymm2 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 1) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 1);
        __m512 bymm3 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 2) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 2);
        __m512 bymm4 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 3) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 3);
        __m512 bymm5 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 4) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 4);
        __m512 bymm6 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 5) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 5);
        __m512 bymm7 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 6) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 6);
        __m512 bymm8 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 7) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 7);
        __m512 bymm9 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 8) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 8);
        __m512 bymm10 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 9) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 9);
        __m512 bymm11 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 10) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 10);
        __m512 bymm12 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 11) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 11);
        __m512 bymm13 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 12) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 12);
        __m512 bymm14 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 13) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 13);
        __m512 bymm15 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        bmsk = _mm512_int2mask(ibmsk & (1 << 14) ? iamsk : 0);
        broadcast_value = _mm_load_ps1(b_t_mat + kk * n + jj + 14);
        __m512 bymm16 = _mm512_maskz_broadcastss_ps(bmsk, broadcast_value);

        // load c results first
        cmsk = _mm512_int2mask(ibmsk & 1 ? iamsk : 0);
        __m512 cymm17 = _mm512_maskz_loadu_ps(cmsk, c_t_mat + jj * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 1) ? iamsk : 0);
        __m512 cymm18 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 1) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 2) ? iamsk : 0);
        __m512 cymm19 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 2) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 3) ? iamsk : 0);
        __m512 cymm20 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 3) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 4) ? iamsk : 0);
        __m512 cymm21 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 4) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 5) ? iamsk : 0);
        __m512 cymm22 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 5) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 6) ? iamsk : 0);
        __m512 cymm23 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 6) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 7) ? iamsk : 0);
        __m512 cymm24 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 7) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 8) ? iamsk : 0);
        __m512 cymm25 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 8) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 9) ? iamsk : 0);
        __m512 cymm26 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 9) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 10) ? iamsk : 0);
        __m512 cymm27 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 10) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 11) ? iamsk : 0);
        __m512 cymm28 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 11) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 12) ? iamsk : 0);
        __m512 cymm29 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 12) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 13) ? iamsk : 0);
        __m512 cymm30 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 13) * m + ii);
        cmsk = _mm512_int2mask(ibmsk & (1 << 14) ? iamsk : 0);
        __m512 cymm31 =
            _mm512_maskz_loadu_ps(cmsk, c_t_mat + (jj + 14) * m + ii);

        // multiply and accumulate results
        cymm17 = _mm512_fmadd_ps(aymm0, bymm2, cymm17);
        cymm18 = _mm512_fmadd_ps(aymm0, bymm3, cymm18);
        cymm19 = _mm512_fmadd_ps(aymm0, bymm4, cymm19);
        cymm20 = _mm512_fmadd_ps(aymm0, bymm5, cymm20);
        cymm21 = _mm512_fmadd_ps(aymm0, bymm6, cymm21);
        cymm22 = _mm512_fmadd_ps(aymm0, bymm7, cymm22);
        cymm23 = _mm512_fmadd_ps(aymm0, bymm8, cymm23);
        cymm24 = _mm512_fmadd_ps(aymm0, bymm9, cymm24);
        cymm25 = _mm512_fmadd_ps(aymm0, bymm10, cymm25);
        cymm26 = _mm512_fmadd_ps(aymm0, bymm11, cymm26);
        cymm27 = _mm512_fmadd_ps(aymm0, bymm12, cymm27);
        cymm28 = _mm512_fmadd_ps(aymm0, bymm13, cymm28);
        cymm29 = _mm512_fmadd_ps(aymm0, bymm14, cymm29);
        cymm30 = _mm512_fmadd_ps(aymm0, bymm15, cymm30);
        cymm31 = _mm512_fmadd_ps(aymm0, bymm16, cymm31);

        // transfer results from AVX registers to CPU
        cmsk = _mm512_int2mask(ibmsk & 1 ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + jj * m + ii, cmsk, cymm17);
        cmsk = _mm512_int2mask(ibmsk & (1 << 1) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 1) * m + ii, cmsk, cymm18);
        cmsk = _mm512_int2mask(ibmsk & (1 << 2) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 2) * m + ii, cmsk, cymm19);
        cmsk = _mm512_int2mask(ibmsk & (1 << 3) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 3) * m + ii, cmsk, cymm20);
        cmsk = _mm512_int2mask(ibmsk & (1 << 4) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 4) * m + ii, cmsk, cymm21);
        cmsk = _mm512_int2mask(ibmsk & (1 << 5) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 5) * m + ii, cmsk, cymm22);
        cmsk = _mm512_int2mask(ibmsk & (1 << 6) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 6) * m + ii, cmsk, cymm23);
        cmsk = _mm512_int2mask(ibmsk & (1 << 7) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 7) * m + ii, cmsk, cymm24);
        cmsk = _mm512_int2mask(ibmsk & (1 << 8) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 8) * m + ii, cmsk, cymm25);
        cmsk = _mm512_int2mask(ibmsk & (1 << 9) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 9) * m + ii, cmsk, cymm26);
        cmsk = _mm512_int2mask(ibmsk & (1 << 10) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 10) * m + ii, cmsk, cymm27);
        cmsk = _mm512_int2mask(ibmsk & (1 << 11) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 11) * m + ii, cmsk, cymm28);
        cmsk = _mm512_int2mask(ibmsk & (1 << 12) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 12) * m + ii, cmsk, cymm29);
        cmsk = _mm512_int2mask(ibmsk & (1 << 13) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 13) * m + ii, cmsk, cymm30);
        cmsk = _mm512_int2mask(ibmsk & (1 << 14) ? iamsk : 0);
        _mm512_mask_storeu_ps(c_t_mat + (jj + 14) * m + ii, cmsk, cymm31);
      }
    }
  }
  // transpose matrix C
  for (index_t h = 0; h < n; ++h) {
    for (index_t w = 0; w < m; ++w) {
      c[w * n + h] = c_t_mat[h * m + w];
    }
  }

  if (!a_t) {
    std::free(a_t_mat);
  }
  std::free(c_t_mat);
#endif  // __AVX512F__
  return 1;
}

#endif  // __GEMM_H_