#include "conv/winograd/asm_wino.h"
#include "gtest/gtest.h"
#include "jit/wino_jitter.h"
#include "jit/wino_store.h"

TEST(JIT, WinogradKernel) {
  const index_t in_tile_area = 16;
  const index_t elements_per_tile = 8;
  const index_t reg_width = 16;
  const index_t in_channels = 3;
  const index_t out_channels = 2;
  const index_t b_stride = in_channels * out_channels;

  float *b = static_cast<float *>(
      aligned_alloc(in_tile_area * in_channels * out_channels, sizeof(float)));

  for (index_t i = 0; i < in_tile_area * in_channels * out_channels; ++i)
    b[i] = i;

  float *buffer_out = static_cast<float *>(
      aligned_alloc(elements_per_tile * reg_width, sizeof(float)));

  WinoJitter<float> jitter;
  jitter.generate_code(b, in_tile_area, in_channels, out_channels);

  index_t idx = 0;

  for (index_t m = 0; m < out_channels; ++m) {
    for (index_t tidx = 0; tidx < in_tile_area; tidx += elements_per_tile) {
      for (index_t c = 0; c < in_channels; ++c) {
        jitter.execute(idx);

        // Copy results to the modified array from the original array
        // using inline assembly.
        // Do not touch, if you don't absolutely know what you are doing.
        //
        __asm__ __volatile__(
            "movq	%[reg], %%rax\n\t"
            "vmovaps %%zmm31, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm30, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm29, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm28, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm27, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm26, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm25, (%%rax)\n\t"
            "addq	$64, %%rax\n\t"
            "vmovaps %%zmm24, (%%rax)\n\t"
            :
            : [ reg ] "m"(buffer_out)
            :);

        const float *b_ptr = b + tidx * b_stride + m * in_channels + c;
        for (index_t h = 0; h < elements_per_tile; ++h) {
          for (index_t w = 0; w < reg_width; ++w) {
            float value = b_ptr[h * b_stride];
            EXPECT_EQ(value, buffer_out[h * reg_width + w]);
          }
        }
        ++idx;
      }
    }
  }
  aligned_free(buffer_out);
  aligned_free(b);
}