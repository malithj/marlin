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
#ifndef __TENSOR_H__
#define __TENSOR_H__

#include <iostream>

#include "mem/allocator.h"
#include "mem/buffer.h"

template <typename T>
class Tensor {
 private:
  // memory managers
  std::shared_ptr<IAllocator<T>> allocator;
  std::shared_ptr<IBuffer<T>> buffer;
  std::vector<index_t> dims;
  bool is_buffer_owner;
  std::string name;
  bool is_weight;
  // quantization parameters
  float scale;
  float min_value;
  float max_value;

 public:
  Tensor(std::shared_ptr<IAllocator<T>> alloc, bool is_weight = false,
         const std::string name = "")
      : allocator(alloc),
        buffer(nullptr),
        is_buffer_owner(true),
        name(name),
        is_weight(is_weight),
        scale(0.f),
        min_value(0.f),
        max_value(0.f) {}
  Tensor(std::shared_ptr<IBuffer<T>> buffer, bool is_weight = false,
         const std::string name = "")
      : buffer(buffer),
        is_buffer_owner(false),
        name(name),
        is_weight(is_weight),
        scale(0.f),
        min_value(0.f),
        max_value(0.f) {}
  explicit Tensor(bool is_weight = false)
      : Tensor(GetCPUAllocator<T>(), is_weight) {}
  index_t size() const;
  index_t raw_size() const;
  index_t dim(index_t axis) const;
  std::vector<index_t> get_dims() const;
  const T* data() const;
  T* mutable_data();
  // reshape an already initialized tensor to
  // different dimensions.
  void reshape(const std::vector<index_t>& dims);
  // resize a new tensor to different dimensions.
  void resize(const std::vector<index_t>& dims);
  void clear();
  // friend access to private variables
  template <typename S>
  friend std::ostream& operator<<(std::ostream& os, const Tensor<S>& t);
  constexpr T* operator()(index_t idx);
  ~Tensor() = default;
};

template <typename T>
index_t Tensor<T>::size() const {
  return std::accumulate(dims.begin(), dims.end(), 1,
                         std::multiplies<int64_t>());
}
template <typename T>
index_t Tensor<T>::raw_size() const {
  return size() * sizeof(T);
}

template <typename T>
index_t Tensor<T>::dim(index_t axis) const {
  return this->dims[axis];
}

template <typename T>
std::vector<index_t> Tensor<T>::get_dims() const {
  return this->dims;
}

template <typename T>
const T* Tensor<T>::data() const {
  return buffer->data();
}

template <typename T>
T* Tensor<T>::mutable_data() {
  return buffer->mutable_data();
}

template <typename T>
std::ostream& operator<<(std::ostream& os, const Tensor<T>& t) {
  os << "Tensor " << t.name << " dimensions: [";
  for (index_t i : t.dims) {
    os << i << ", ";
  }
  os << "]\ncontent:\n";
  for (index_t i = 0; i < t.size(); ++i) {
    if (i != 0 && i % t.dims.back() == 0) {
      os << "\n";
    }
    if (i < t.size() - 1)
      os << t.data()[i] << ", ";
    else
      os << t.data()[i];
  }
  return os;
}

template <typename T>
constexpr T* Tensor<T>::operator()(index_t idx) {
  return this->mutable_data() + idx;
}

template <typename T>
void Tensor<T>::reshape(const std::vector<index_t>& dims) {
  this->dims = dims;
  if (buffer == nullptr) {
    throw std::runtime_error("buffer has not been initialized");
  }
  if (raw_size() > this->buffer->size())
    throw std::invalid_argument(
        "Must satisfy: " + std::to_string(this->raw_size()) +
        " <= " + std::to_string(this->buffer->size()));
}

template <typename T>
void Tensor<T>::resize(const std::vector<index_t>& dims) {
  this->dims = dims;
  if (this->buffer == nullptr) {
    buffer = std::make_shared<Buffer<T>>(this->allocator);
    const index_t modified_size = this->raw_size();
    if (modified_size > this->buffer->size()) {
      this->buffer->resize(modified_size);
    }
  }
  if (raw_size() > this->buffer->size())
    throw std::invalid_argument(
        "expected tensor size: " + std::to_string(this->raw_size()) +
        " <= buffer size: " + std::to_string(this->buffer->size()));
}

template <typename T>
void Tensor<T>::clear() {
  if (this->buffer != nullptr) {
    this->buffer->clear();
  }
}

#endif