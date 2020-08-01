#include "gtest/gtest.h"
#include "jit/jitter.h"

TEST(JIT, Code) {
  const index_t m = 32;
  const index_t k = 32;
  const index_t n = 32;
  float* b_matrix = static_cast<float*>(aligned_alloc(k * n, sizeof(float)));

  // initialize b matrix
  for (index_t i = 0; i < k; ++i) {
    for (index_t j = 0; j < n; ++j) {
      b_matrix[i * n + j] = i * n + j;
    }
  }

  Jitter<float> jitter;
  jitter.generate_code(b_matrix, m, k, n);
  float* buffer_out =
      static_cast<float*>(aligned_alloc(15 * 16, sizeof(float)));
  index_t idx = 0;
  index_t ftile_j_lim = (n / 15) * 15;
  index_t ptile_j_remain = n - ftile_j_lim;
  for (index_t j = 0; j < ftile_j_lim; j += 15) {
    for (index_t i = 0; i < k; ++i) {
      memset(buffer_out, 0, sizeof(float) * 15 * 16);
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
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm23, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm22, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm21, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm20, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm19, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm18, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm17, (%%rax)\n\t"
          :
          : [ reg ] "m"(buffer_out)
          :);
      for (index_t h = 0; h < 15; ++h) {
        index_t idx = i * n + j + h;
        for (index_t w = 0; w < 16; ++w) {
          float value = j + h < n ? b_matrix[idx] : 0;
          EXPECT_EQ(value, buffer_out[h * 16 + w]);
        }
      }
      idx += 1;
    }
  }

  if (ptile_j_remain) {
    for (index_t i = 0; i < k; ++i) {
      memset(buffer_out, 0, sizeof(float) * ptile_j_remain * 16);
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
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm23, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm22, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm21, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm20, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm19, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm18, (%%rax)\n\t"
          "addq	$64, %%rax\n\t"
          "vmovaps %%zmm17, (%%rax)\n\t"
          :
          : [ reg ] "m"(buffer_out)
          :);
      for (index_t h = 0; h < ptile_j_remain; ++h) {
        index_t idx = i * n + ftile_j_lim + h;
        for (index_t w = 0; w < 16; ++w) {
          float value = ftile_j_lim + h < n ? b_matrix[idx] : 0;
          EXPECT_EQ(value, buffer_out[h * 16 + w]);
        }
      }
      idx += 1;
    }
  }
  aligned_free(buffer_out);
  aligned_free(b_matrix);
}