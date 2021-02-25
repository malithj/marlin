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
#ifndef __DIRECT_CONVOLVER_H_
#define __DIRECT_CONVOLVER_H_

#include "conv/conv_base/convolver.h"

namespace conv2d {
template <typename T>
class DirectConvolver : public Convolver<T> {
 public:
  DirectConvolver();
  void run(const Tensor<T> *filter, const Tensor<T> *input, Tensor<T> *output);
  ~DirectConvolver();
};

template <typename T>
DirectConvolver<T>::DirectConvolver() {}

template <typename T>
DirectConvolver<T>::~DirectConvolver() {}

template <typename T>
void conv2d::DirectConvolver<T>::run(const Tensor<T> *filter,
                                     const Tensor<T> *input,
                                     Tensor<T> *output) {
  const T *filter_data = filter->data();
  const T *input_data = input->data();

  std::unique_ptr<Tensor<T>> padded_input = std::make_unique<Tensor<T>>();
  if (this->need_padding()) {
    this->pad_input(input, padded_input.get());
  }

  const index_t batches = input->dim(0);
  const index_t channels = input->dim(1);
  index_t in_height = input->dim(2);
  index_t in_width = input->dim(3);
  index_t batch_size = channels * in_height * in_width;
  index_t in_area = in_height * in_width;

  const index_t num_filters = filter->dim(0);
  const index_t f_channels = filter->dim(1);
  const index_t filter_height = filter->dim(2);
  const index_t filter_width = filter->dim(3);
  const index_t filter_size = channels * filter_height * filter_width;
  const index_t filter_area = filter_height * filter_width;

  std::vector<index_t> *stride_ptr = this->get_stride();
  const index_t vertical_stride = stride_ptr->at(0);
  const index_t horizontal_stride = stride_ptr->at(1);

  if (f_channels != channels) {
    throw std::invalid_argument(
        "number of filters in the input and filter are not the same. input "
        "channels: " +
        std::to_string(channels) +
        " filter channels: " + std::to_string(f_channels));
  }

  const index_t output_height =
      this->compute_output_height(in_height, filter_height);
  const index_t output_width =
      this->compute_output_width(in_width, filter_width);
  const index_t out_batch_size = num_filters * output_height * output_width;
  const index_t out_area = output_height * output_width;
  output->resize({batches, num_filters, output_height, output_width});
  output->clear();
  T *output_data = output->mutable_data();

  // swap padded input and input if necessary
  if (this->need_padding()) {
    index_t padded_height = padded_input->dim(2);
    index_t padded_width = padded_input->dim(3);
    in_height = padded_height;
    in_width = padded_width;
    batch_size = channels * in_height * in_width;
    in_area = in_height * in_width;
    input_data = padded_input->data();
  }

  for (index_t m = 0; m < batches; ++m) {
    const T *input_batch_ptr = input_data + m * batch_size;
    T *output_batch_ptr = output_data + m * out_batch_size;
    for (index_t n = 0; n < num_filters; ++n) {
      const T *filter_idx_ptr = filter_data + n * filter_size;
      T *output_ptr = output_batch_ptr + n * out_area;
      for (index_t c = 0; c < channels; ++c) {
        const T *filter_ptr = filter_idx_ptr + c * filter_area;
        const T *input_ch_ptr = input_batch_ptr + c * in_area;
        for (index_t i = 0; i <= in_height - filter_height;
             i += vertical_stride) {
          for (index_t j = 0; j <= in_width - filter_width;
               j += horizontal_stride) {
            index_t out_idx =
                (i / vertical_stride) * output_width + (j / horizontal_stride);
            const T *input_ptr = input_ch_ptr + i * in_width + j;
            for (index_t x = 0; x < filter_height; ++x) {
              for (index_t y = 0; y < filter_width; ++y) {
                output_ptr[out_idx] += input_ptr[x * in_width + y] *
                                       filter_ptr[x * filter_width + y];
              }
            }
          }
        }
      }
    }
  }
}

}  // namespace conv2d

#endif