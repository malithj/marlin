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
#ifndef __CONVOLVER_H_
#define __CONVOLVER_H_

#include <math.h>

#include <memory>
#include <vector>

#include "tensor/tensor.h"
#include "types/types.h"

namespace conv2d {
template <typename T>
class Convolver {
 protected:
  std::unique_ptr<std::vector<index_t>> __padding;
  std::unique_ptr<std::vector<index_t>> __stride;
  index_t __dilations;
  index_t compute_output_dim(index_t in_dim, index_t filter_dim, index_t pad_1,
                             index_t pad_2, index_t stride);

 public:
  Convolver();
  virtual void run(const Tensor<T> *filter, const Tensor<T> *input,
                   Tensor<T> *output);
  index_t compute_output_width(index_t in_width, index_t filter_width);
  index_t compute_output_height(index_t in_height, index_t filter_height);
  void set_padding(std::vector<index_t> padding);
  void set_stride(std::vector<index_t> stride);
  void pad_input(const Tensor<T> *input, Tensor<T> *padded_input);
  bool need_padding();
  std::vector<index_t> *get_padding();
  std::vector<index_t> *get_stride();
  virtual ~Convolver();
};

template <typename T>
Convolver<T>::Convolver() {}

template <typename T>
Convolver<T>::~Convolver() {}

template <typename T>
void Convolver<T>::run(const Tensor<T> *filter, const Tensor<T> *input,
                       Tensor<T> *output) {}

template <typename T>
index_t Convolver<T>::compute_output_dim(index_t in_dim, index_t filter_dim,
                                         index_t pad_1, index_t pad_2,
                                         index_t stride) {
  return floor((in_dim + pad_1 + pad_2 - filter_dim) / stride) + 1;
}

template <typename T>
index_t Convolver<T>::compute_output_width(index_t in_width,
                                           index_t filter_width) {
  index_t left_pad = this->__padding.get()->at(2);
  index_t right_pad = this->__padding.get()->at(3);
  index_t horizon_stride = this->__stride.get()->at(1);
  return this->compute_output_dim(in_width, filter_width, left_pad, right_pad,
                                  horizon_stride);
}

template <typename T>
index_t Convolver<T>::compute_output_height(index_t in_height,
                                            index_t filter_height) {
  index_t top_pad = this->__padding.get()->at(0);
  index_t bottom_pad = this->__padding.get()->at(1);
  index_t vert_stride = this->__stride.get()->at(0);
  return this->compute_output_dim(in_height, filter_height, top_pad, bottom_pad,
                                  vert_stride);
}

template <typename T>
void Convolver<T>::set_padding(std::vector<index_t> padding) {
  this->__padding = std::make_unique<std::vector<index_t>>(padding);
}

template <typename T>
void Convolver<T>::set_stride(std::vector<index_t> stride) {
  this->__stride = std::make_unique<std::vector<index_t>>(stride);
}

template <typename T>
std::vector<index_t> *Convolver<T>::get_padding() {
  return this->__padding.get();
}

template <typename T>
std::vector<index_t> *Convolver<T>::get_stride() {
  return this->__stride.get();
}

template <typename T>
bool Convolver<T>::need_padding() {
  bool state = false;
  for (index_t i = 0; i < 4; ++i) {
    state = state || (this->__padding->at(i) > 0);
  }
  return state;
}

template <typename T>
void Convolver<T>::pad_input(const Tensor<T> *input, Tensor<T> *padded_input) {
  const T *in_data = input->data();
  T *padded_in_data = padded_input->mutable_data();

  index_t batches = input->dim(0);
  index_t channels = input->dim(1);
  index_t in_height = input->dim(2);
  index_t in_width = input->dim(3);
  index_t in_area = in_height * in_width;
  index_t in_batch_size = in_area * channels;

  index_t pad_top = this->__padding->at(0);
  index_t pad_bottom = this->__padding->at(1);
  index_t pad_left = this->__padding->at(2);
  index_t pad_right = this->__padding->at(3);
  index_t padded_in_height = in_height + pad_top + pad_bottom;
  index_t padded_in_width = in_width + pad_left + pad_right;
  index_t padded_in_area = padded_in_height * padded_in_width;
  index_t padded_in_batch_size = padded_in_area * channels;
  padded_input->resize({batches, channels, padded_in_height, padded_in_width});

  for (index_t m = 0; m < batches; ++m) {
    const T *in_batch_ptr = in_data + m * in_batch_size;
    T *pad_in_batch_ptr = padded_in_data + m * padded_in_batch_size;
    for (index_t c = 0; c < channels; ++c) {
      const T *in_channel_ptr = in_batch_ptr + c * in_area;
      T *padded_in_channel_ptr = pad_in_batch_ptr + c * padded_in_area;
      for (index_t h = 0; h < in_height; ++h) {
        const T *in_ptr = in_channel_ptr + h * in_width;
        T *pad_in_ptr = padded_in_channel_ptr + (h + pad_top) * padded_in_width;
        memcpy(pad_in_ptr + pad_left, in_ptr, sizeof(T) * in_width);
      }
    }
  }
}

}  // namespace conv2d

#endif