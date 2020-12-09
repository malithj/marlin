#ifndef __TYPES_H_
#define __TYPES_H_
#include <stdint.h>

typedef uint64_t index_t;
typedef enum { WINO_K_3x3, WINO_K_5x5, WINO_K_7x7 } wino_k_t;
typedef enum { WINO_O_2x2, WINO_O_4x4, WINO_O_6x6, WINO_O_8x8 } wino_o_t;
typedef enum { LIBMKL, LIBONEDNN, LIBMARLIN, LIBAVX_512 } gemm_library;

#endif