/*******************************************************************************
 * Copyright (c) Malith Jayaweera - All rights reserved.                       *
 * This file is part of the MARLIN library.                                    *
 *                                                                             *
 * For information on the license, see the LICENSE file.                       *
 * Further information: https://github.com/malithj/marlin/                     *
 * SPDX-License-Identifier: BSD-3-Clause                                       *
 ******************************************************************************/
/* Malith Jayaweera
*******************************************************************************/
#ifndef __WINO_INTERFACE_H__
#define __WINO_INTERFACE_H__

#include "../../types/types.h"

template <typename T, wino_k_t W, wino_o_t O>
class IWinograd {
 private:
 public:
  virtual void transform_input(const float* input, const index_t batch,
                               const index_t in_height, const index_t in_width,
                               const index_t in_channels,
                               const index_t tile_count, float* output) = 0;
  virtual void transform_kernel(const T* filter, index_t num_filters,
                                index_t channels, T* output) = 0;
  virtual void transform_output(const T* input, index_t batch,
                                index_t out_height, index_t out_width,
                                index_t out_channels, index_t tile_count,
                                T* output) = 0;
  virtual void perform_gemm();
};

template <typename T, wino_k_t W, wino_o_t O>
void IWinograd<T, W, O>::perform_gemm() {}

#endif