#ifndef __TEST_UTILS_H_
#define __TEST_UTILS_H_

#include "gtest/gtest.h"
#include "tensor/tensor.h"

template <typename T>
void initialize_tensor(std::shared_ptr<Tensor<T>> tensor) {
  index_t dim0 = tensor->dim(0);
  index_t dim1 = tensor->dim(1);
  index_t dim2 = tensor->dim(2);
  index_t dim3 = tensor->dim(3);

  T* data = tensor->mutable_data();

  index_t dim1_offset = dim2 * dim3;
  index_t dim0_offset = dim1 * dim1_offset;

  for (index_t b = 0; b < dim0; ++b) {
    for (index_t m = 0; m < dim1; ++m) {
      for (index_t i = 0; i < dim2; ++i) {
        for (index_t j = 0; j < dim3; ++j) {
          index_t idx = dim0_offset * b + dim1_offset * m + i * dim3 + j;
          data[idx] = (static_cast<T>(rand()) / RAND_MAX);
        }
      }
    }
  }
}

template <typename T>
void verify_execution(const Tensor<T>* expected, const Tensor<T>* actual) {
  index_t output_batch = expected->dim(0);
  index_t output_channel = expected->dim(1);
  index_t output_height = expected->dim(2);
  index_t output_width = expected->dim(3);
  index_t out_img_size = output_height * output_width;
  index_t batch_offset = output_channel * out_img_size;

  for (index_t b = 0; b < output_batch; ++b) {
    for (index_t c = 0; c < output_channel; ++c) {
      for (index_t h = 0; h < output_height; ++h) {
        for (index_t w = 0; w < output_width; ++w) {
          index_t offset =
              batch_offset * b + out_img_size * c + output_width * h;
          float actual_ = actual->data()[offset + w];
          float expected_ = expected->data()[offset + w];
          EXPECT_NEAR(actual_, expected_, 1e-2);
        }
      }
    }
  }
}
#endif