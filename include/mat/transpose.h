#ifndef __TRANSPOSE_H_
#define __TRANSPOSE_H_

#include <immintrin.h>

#include "../types/types.h"

template <typename T>
void transpose4x4(T* src, T* dst, index_t height, index_t width) {
  // load 4 rows
  __m128 m0 = _mm_load_ps(src);
  __m128 m1 = _mm_load_ps(src + 0x4);
  __m128 m2 = _mm_load_ps(src + 0x8);
  __m128 m3 = _mm_load_ps(src + 0xc);

  __m128 r0 = _mm_unpacklo_ps(m0, m1);
  __m128 r1 = _mm_unpackhi_ps(m0, m1);
  __m128 r2 = _mm_unpacklo_ps(m2, m3);
  __m128 r3 = _mm_unpackhi_ps(m2, m3);

  m0 = _mm_unpacklo_ps(r0, r2);
  m1 = _mm_unpackhi_ps(r0, r2);
  m2 = _mm_unpacklo_ps(r1, r3);
  m3 = _mm_unpackhi_ps(r1, r3);

  _mm_store_ps(dst, m0);
  _mm_store_ps(dst + 0x4, m1);
  _mm_store_ps(dst + 0x8, m2);
  _mm_store_ps(dst + 0xc, m3);
}

#endif
