#ifndef __ASM_KERNELS_H_
#define __ASM_KERNELS_H_

#include "../types/types.h"

extern "C" index_t asm_gemm_f32_j1(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j2(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j3(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j4(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j5(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j6(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j7(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j8(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j9(index_t k, float *a, float *c, void *p_addr,
                                   index_t *offset_data, uint32_t *arr_a,
                                   uint32_t *arr_c, uint16_t mask, index_t idx);

extern "C" index_t asm_gemm_f32_j10(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

extern "C" index_t asm_gemm_f32_j11(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

extern "C" index_t asm_gemm_f32_j12(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

extern "C" index_t asm_gemm_f32_j13(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

extern "C" index_t asm_gemm_f32_j14(index_t k, float *a, float *c, void *p_addr,
                                    index_t *offset_data, uint32_t *arr_a,
                                    uint32_t *arr_c, uint16_t mask,
                                    index_t idx);

extern "C" index_t asm_gemm(index_t k, float *a, float *c, void *p_addr,
                            index_t *offset_data, uint32_t *arr_a,
                            uint32_t *arr_c, uint16_t mask, index_t idx);

#endif