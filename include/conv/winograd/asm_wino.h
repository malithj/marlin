#ifndef __ASM_KERNELS_H_
#define __ASM_KERNELS_H_

#include "types/types.h"

extern "C" index_t asm_wino_multiply(index_t a_stride, index_t b_stride,
                                     index_t c_stride, index_t tile_count,
                                     index_t in_channels, uint16_t mask,
                                     const float *a, const float *b, float *c);

#endif