#ifndef __WINO_MULTIPLY_H__
#define __WINO_MULTIPLY_H__

#include <immintrin.h>

#include "asm_wino.h"
#include "types/types.h"

#define ASM 1

template <typename T>
void compute(const T* transformed_filter_data, const T* transform_in,
             const index_t in_tile_area, const index_t out_channels,
             const index_t tile_count, const index_t in_channels,
             T* transform_out) {
  for (index_t m = 0; m < out_channels; ++m) {
    for (index_t tile = 0; tile < tile_count; tile += 16) {
      const uint16_t mask =
          tile + 16 <= tile_count ? 0xffff : ~(0xffff << (tile_count - tile));

      for (index_t tidx = 0; tidx < in_tile_area; tidx += 8) {
        const T* a_ptr =
            transform_in + tile + (tidx * tile_count) * in_channels;
        const index_t a_stride = tile_count * in_channels;

        const index_t b_stride = in_channels * out_channels;
        const T* b_ptr =
            transformed_filter_data + tidx * b_stride + m * in_channels;

        const index_t c_stride = tile_count * out_channels;
        T* c_ptr = transform_out + m * tile_count + tile + tidx * c_stride;

#ifndef ASM
        __m512 c0 = _mm512_setzero_ps();
        __m512 c1 = _mm512_setzero_ps();
        __m512 c2 = _mm512_setzero_ps();
        __m512 c3 = _mm512_setzero_ps();
        __m512 c4 = _mm512_setzero_ps();
        __m512 c5 = _mm512_setzero_ps();
        __m512 c6 = _mm512_setzero_ps();
        __m512 c7 = _mm512_setzero_ps();

        for (index_t c = 0; c < in_channels; ++c) {
          const T* a_ptr_ = a_ptr + tile_count * c;
          const T* b_ptr_ = b_ptr + c;

          __m512 a0 = _mm512_maskz_loadu_ps(mask, a_ptr_);
          __m512 a1 = _mm512_maskz_loadu_ps(mask, a_ptr_ + a_stride);
          __m512 a2 = _mm512_maskz_loadu_ps(mask, a_ptr_ + 2 * a_stride);
          __m512 a3 = _mm512_maskz_loadu_ps(mask, a_ptr_ + 3 * a_stride);
          __m512 a4 = _mm512_maskz_loadu_ps(mask, a_ptr_ + 4 * a_stride);
          __m512 a5 = _mm512_maskz_loadu_ps(mask, a_ptr_ + 5 * a_stride);
          __m512 a6 = _mm512_maskz_loadu_ps(mask, a_ptr_ + 6 * a_stride);
          __m512 a7 = _mm512_maskz_loadu_ps(mask, a_ptr_ + 7 * a_stride);

          __m128 b_reg;
          b_reg = _mm_set1_ps(*b_ptr_);
          __m512 b0 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + b_stride));
          __m512 b1 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + 2 * b_stride));
          __m512 b2 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + 3 * b_stride));
          __m512 b3 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + 4 * b_stride));
          __m512 b4 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + 5 * b_stride));
          __m512 b5 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + 6 * b_stride));
          __m512 b6 = _mm512_broadcastss_ps(b_reg);
          b_reg = _mm_set1_ps(*(b_ptr_ + 7 * b_stride));
          __m512 b7 = _mm512_broadcastss_ps(b_reg);

          c0 = _mm512_fmadd_ps(a0, b0, c0);
          c1 = _mm512_fmadd_ps(a1, b1, c1);
          c2 = _mm512_fmadd_ps(a2, b2, c2);
          c3 = _mm512_fmadd_ps(a3, b3, c3);
          c4 = _mm512_fmadd_ps(a4, b4, c4);
          c5 = _mm512_fmadd_ps(a5, b5, c5);
          c6 = _mm512_fmadd_ps(a6, b6, c6);
          c7 = _mm512_fmadd_ps(a7, b7, c7);
        }
        _mm512_mask_storeu_ps(c_ptr, mask, c0);
        _mm512_mask_storeu_ps(c_ptr + c_stride, mask, c1);
        _mm512_mask_storeu_ps(c_ptr + 2 * c_stride, mask, c2);
        _mm512_mask_storeu_ps(c_ptr + 3 * c_stride, mask, c3);
        _mm512_mask_storeu_ps(c_ptr + 4 * c_stride, mask, c4);
        _mm512_mask_storeu_ps(c_ptr + 5 * c_stride, mask, c5);
        _mm512_mask_storeu_ps(c_ptr + 6 * c_stride, mask, c6);
        _mm512_mask_storeu_ps(c_ptr + 7 * c_stride, mask, c7);
#else
        asm_wino_multiply(a_stride, b_stride, c_stride, tile_count, in_channels,
                          mask, a_ptr, b_ptr, c_ptr);
#endif
      }
    }
  }
}
#endif
