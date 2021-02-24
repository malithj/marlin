#ifndef __WINO_TRANSFORM_H__
#define __WINO_TRANSFORM_H__

#include <immintrin.h>

#include <memory>

#include "mem/memory.h"
#include "types/types.h"

using namespace std;

template <typename T>
void wino_transform_input_3x3_2x2(const T* input, const index_t batch,
                                  const index_t in_height,
                                  const index_t in_width,
                                  const index_t in_channels,
                                  const index_t tile_count, T* output) {
  const index_t stride = in_channels * tile_count;
  const index_t in_height_width = in_height * in_width;
  const index_t input_batch_size = in_height_width * in_channels;
  const index_t output_batch_size = 16 * in_channels * tile_count;

  T* d = static_cast<T*>(aligned_alloc(16, sizeof(float)));

  for (index_t n = 0; n < batch; ++n) {
    for (index_t c = 0; c < in_channels; ++c) {
      index_t tile_index = 0;
      for (index_t h = 0; h < in_height - 2; h += 2) {
        for (index_t w = 0; w < in_width - 2; w += 2) {
          // load tile data
          const float* input_ptr = input + n * input_batch_size +
                                   c * in_height_width + h * in_width + w;

          for (index_t i = 0; i < 16; ++i) {
            d[i] = input_ptr[(i / 4) * in_width + (i % 4)];
          }

          __m512 reg = _mm512_loadu_ps(d);
          __m128 lower = _mm_loadu_ps(d + 4);
          __m512 f0 = _mm512_insertf32x4(reg, lower, 2);
          f0 = _mm512_insertf32x4(f0, lower, 3);

          __m512 d00 = _mm512_permute_ps(f0, 0x54);
          __m512 d01 = _mm512_permute_ps(f0, 0xea);

          __m128 upper = _mm_loadu_ps(d + 8);
          __m512 f1 = _mm512_insertf32x4(reg, upper, 0);
          f1 = _mm512_insertf32x4(f1, upper, 1);

          __m512 d10 = _mm512_permute_ps(f1, 0x54);
          __m512 d11 = _mm512_permute_ps(f1, 0xea);

          __m512 zeros = _mm512_setzero_ps();
          d00 = _mm512_mask_sub_ps(d00, 0x4b44, zeros, d00);
          d01 = _mm512_mask_sub_ps(d01, 0xf0ff, zeros, d01);
          d10 = _mm512_mask_sub_ps(d10, 0xbbbb, zeros, d10);
          __m512 s00;

          s00 = _mm512_add_ps(d00, d01);
          s00 = _mm512_add_ps(s00, d10);
          s00 = _mm512_add_ps(s00, d11);

          int index[16];
          for (index_t i = 0; i < 16; ++i) {
            index[i] = i * stride;
          }

          // store output
          float* output_ptr =
              output + n * output_batch_size + c * tile_count + tile_index;
          __m512i vindex = _mm512_loadu_si512(&index);
          _mm512_i32scatter_ps(output_ptr, vindex, s00, 4);
          ++tile_index;
        }
      }
    }
  }
  aligned_free(d);
}

template <typename T>
void wino_transform_kernel_3x3_2x2(const T* filter, const index_t num_filters,
                                   const index_t channels, T* output) {
  const index_t stride = num_filters * channels;

  for (index_t m = 0; m < num_filters; ++m) {
    for (index_t c = 0; c < channels; ++c) {
      const index_t filter_offset = (m * channels + c) * 9;
      const T* g = filter + filter_offset;

      T s[16];
      s[0] = g[0];
      s[1] = (-g[0] + g[1] - g[2]) * 0.5;
      s[2] = (-g[0] - g[1] - g[2]) * 0.5;
      s[3] = -g[2];
      s[4] = (-g[0] + g[3] - g[6]) * 0.5;
      s[5] =
          (g[0] - g[1] + g[2] - g[3] + g[4] - g[5] + g[6] - g[7] + g[8]) * 0.25;
      s[6] =
          (g[0] + g[1] + g[2] - g[3] - g[4] - g[5] + g[6] + g[7] + g[8]) * 0.25;
      s[7] = (g[2] - g[5] + g[8]) * 0.5;
      s[8] = (-g[0] - g[3] - g[6]) * 0.5;
      s[9] = (g[0] + -g[1] + g[2] + g[3] + -g[4] + g[5] + g[6] + -g[7] + g[8]) *
             0.25;
      s[10] =
          (g[0] + g[1] + g[2] + g[3] + g[4] + g[5] + g[6] + g[7] + g[8]) * 0.25;
      s[11] = (g[2] + g[5] + g[8]) * 0.5;
      s[12] = -g[6];
      s[13] = (g[6] + -g[7] + g[8]) * 0.5;
      s[14] = (g[6] + g[7] + g[8]) * 0.5;
      s[15] = g[8];

      // store output
      index_t output_offset = m * channels + c;

      for (index_t i = 0; i < 16; ++i)
        output[output_offset + i * stride] = s[i];
    }
  }
}

template <typename T>
void wino_transform_output_3x3_2x2(const T* input, const index_t batch,
                                   const index_t out_height,
                                   const index_t out_width,
                                   const index_t out_channels,
                                   const index_t tile_count, T* output) {
  const index_t stride = out_channels * tile_count;
  const index_t input_batch_size = 16 * stride;
  const index_t out_image_size = out_height * out_width;
  const index_t output_batch_size = out_channels * out_image_size;

  for (index_t n = 0; n < batch; ++n) {
    for (index_t m = 0; m < out_channels; m += 1) {
      index_t tile_offset = 0;
      for (index_t h = 0; h < out_height; h += 2) {
        for (index_t w = 0; w < out_width; w += 2) {
          const T* input_ptr =
              input + n * input_batch_size + m * tile_count + tile_offset;
          T s[16];

          for (index_t i = 0; i < 16; ++i) {
            s[i] = input_ptr[i * stride];
          }

          T mo[4];
          mo[0] = s[0] + s[1] + s[2] + s[4] + s[5] + s[6] + s[8] + s[9] + s[10];
          mo[1] =
              -s[1] + s[2] + s[3] - s[5] + s[6] + s[7] - s[9] + s[10] + s[11];
          mo[2] = -(s[4] + s[5] + s[6]) + s[8] + s[9] + s[10] + s[12] + s[13] +
                  s[14];
          mo[3] =
              s[5] - s[6] - s[7] - s[9] + s[10] + s[11] - s[13] + s[14] + s[15];

          float* output_ptr = output + n * output_batch_size +
                              m * out_image_size + h * out_width + w;
          output_ptr[0] = mo[0];
          output_ptr[1] = mo[1];
          output_ptr[out_width] = mo[2];
          output_ptr[out_width + 1] = mo[3];

          ++tile_offset;
        }
      }
    }
  }
}

#endif