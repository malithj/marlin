#ifndef __WINO_IMPL_H__
#define __WINO_IMPL_H__

#include <omp.h>
#include <stdio.h>

#include "gemm/gemm.h"
#include "mem/allocator.h"
#include "mem/buffer.h"
#include "tensor/tensor.h"
#include "types/types.h"
#include "utils/utils.h"
#include "wino_3x3.h"
#include "wino_interface.h"
#include "wino_multiply.h"

template <typename T, wino_k_t W, wino_o_t O>
class Winograd : public IWinograd<T, W, O> {
 private:
  std::shared_ptr<Buffer<T>> scratch;

 public:
  Winograd();
  void run(const std::shared_ptr<Tensor<float>> input,
           const std::shared_ptr<Tensor<float>> filter,
           std::shared_ptr<Tensor<float>> output);
  void transform_input(const T* input, const index_t batch,
                       const index_t in_height, const index_t in_width,
                       const index_t in_channels, const index_t tile_count,
                       float* output);
  void transform_kernel(const T* filter, const index_t num_filters,
                        const index_t channels, T* output);
  void transform_output(const T* input, const index_t batch,
                        const index_t out_height, index_t out_width,
                        const index_t out_channels, const index_t tile_count,
                        T* output);
  void calculate_output_shape_pad_size(const std::shared_ptr<Tensor<T>> input,
                                       const std::shared_ptr<Tensor<T>> filter,
                                       const index_t out_tile_height,
                                       const index_t out_tile_width,
                                       std::vector<index_t>* output_shape,
                                       std::vector<index_t>* in_pad_size,
                                       std::vector<index_t>* out_pad_size);
  void pad_input(const std::shared_ptr<Tensor<T>> input, const index_t pad_top,
                 const index_t pad_left,
                 std::shared_ptr<Tensor<T>> padded_input);
  void unpad_output(std::shared_ptr<Tensor<T>> output, const T* padded_output,
                    const index_t padded_height, const index_t padded_width);
};

template <typename T, wino_k_t W, wino_o_t O>
Winograd<T, W, O>::Winograd() {
  this->scratch = std::make_shared<Buffer<T>>(GetCPUAllocator<T>());
  //   this->gemm = std::make_unique<GEMM<T>>();
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::transform_kernel(const T* filter,
                                         const index_t num_filters,
                                         const index_t channels, T* output) {
  if (W == WINO_K_3x3 && O == WINO_O_2x2) {
    wino_transform_kernel_3x3_2x2(filter, num_filters, channels, output);
  }
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::transform_input(const T* input, const index_t batch,
                                        const index_t in_height,
                                        const index_t in_width,
                                        const index_t in_channels,
                                        const index_t tile_count,
                                        float* output) {
  if (W == WINO_K_3x3 && O == WINO_O_2x2) {
    wino_transform_input_3x3_2x2(input, batch, in_height, in_width, in_channels,
                                 tile_count, output);
  }
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::transform_output(const T* input, const index_t batch,
                                         const index_t out_height,
                                         const index_t out_width,
                                         const index_t out_channels,
                                         const index_t tile_count, T* output) {
  if (W == WINO_K_3x3 && O == WINO_O_2x2) {
    wino_transform_output_3x3_2x2(input, batch, out_height, out_width,
                                  out_channels, tile_count, output);
  }
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::run(const std::shared_ptr<Tensor<float>> input,
                            const std::shared_ptr<Tensor<float>> filter,
                            std::shared_ptr<Tensor<float>> output) {
  const index_t batch = input->dim(0);
  const index_t in_channels = input->dim(1);
  const index_t in_height = input->dim(2);
  const index_t in_width = input->dim(3);

  const index_t out_channels = filter->dim(0);

  std::vector<index_t> output_shape;
  std::vector<index_t> in_pad_size;
  std::vector<index_t> out_pad_size;

  index_t out_tile_size;
  switch (O) {
    case WINO_O_2x2:
      out_tile_size = 2;
      break;
    default:
      out_tile_size = 2;
  }
  index_t in_tile_adjustment;
  switch (W) {
    case WINO_K_3x3:
      in_tile_adjustment = 2;
      break;
    default:
      throw std::runtime_error("impossible execution path");
  }

  calculate_output_shape_pad_size(input, filter, out_tile_size, out_tile_size,
                                  &output_shape, &in_pad_size, &out_pad_size);

  // default padding is given below. Winograd padding
  // is added to the right and on the bottom
  const index_t out_height = output_shape[2];
  const index_t out_width = output_shape[3];
  const index_t padded_in_height = in_height + in_pad_size[0] + in_pad_size[1];
  const index_t padded_in_width = in_width + in_pad_size[2] + in_pad_size[3];
  const index_t padded_out_height =
      out_height + out_pad_size[0] + out_pad_size[1];
  const index_t padded_out_width =
      out_width + out_pad_size[2] + out_pad_size[3];
  const index_t pad_top = in_pad_size.data()[0];
  const index_t pad_left = in_pad_size.data()[2];

  const index_t tile_height_count = padded_out_height / out_tile_size;
  const index_t tile_width_count = padded_out_width / out_tile_size;
  const index_t tile_count = tile_height_count * tile_width_count;
  const index_t in_tile_area = (out_tile_size + in_tile_adjustment) *
                               (out_tile_size + in_tile_adjustment);

  const index_t padded_in_size =
      batch * in_channels * padded_in_height * padded_in_width;
  const index_t padded_out_size =
      batch * out_channels * padded_out_height * padded_out_width;

  const index_t transformed_in_size =
      batch * in_tile_area * in_channels * tile_count;
  const index_t transformed_out_size =
      batch * in_tile_area * out_channels * tile_count;
  const index_t transformed_filter_size =
      in_tile_area * out_channels * in_channels;
  const index_t gemm_pack_size =
      transformed_in_size + transformed_filter_size + transformed_filter_size;

  this->scratch->resize(padded_in_size + padded_out_size + transformed_in_size +
                        transformed_out_size + gemm_pack_size);

  std::shared_ptr<Tensor<T>> padded_in_tensor =
      std::make_shared<Tensor<T>>(this->scratch);
  padded_in_tensor->resize(
      {batch, in_channels, padded_in_height, padded_in_width});

  pad_input(input, pad_top, pad_left, padded_in_tensor);

  T* pad_data = padded_in_tensor->mutable_data();
  T* pad_out_data = pad_data + padded_in_size;
  T* transformed_in_data = pad_out_data + padded_out_size;
  T* transformed_out_data = transformed_in_data + transformed_in_size;

  std::shared_ptr<Tensor<T>> transformed_filter = std::make_shared<Tensor<T>>();
  transformed_filter->resize({out_channels, in_channels, in_tile_area});
  T* transformed_filter_data = transformed_filter->mutable_data();
  const T* filter_data = filter->data();

  this->transform_kernel(filter_data, out_channels, in_channels,
                         transformed_filter_data);

  this->transform_input(pad_data, batch, padded_in_height, padded_in_width,
                        in_channels, tile_count, transformed_in_data);

  // perform elementwise multiplication
  const index_t transform_in_size_per_batch =
      in_tile_area * in_channels * tile_count;
  const index_t transform_out_size_per_batch =
      in_tile_area * out_channels * tile_count;

  for (index_t b = 0; b < batch; ++b) {
    T* transform_in = transformed_in_data + b * transform_in_size_per_batch;
    T* transform_out = transformed_out_data + b * transform_out_size_per_batch;
    compute(transformed_filter_data, transform_in, in_tile_area, out_channels,
            tile_count, in_channels, transform_out);
  }
  transform_output(transformed_out_data, batch, padded_out_height,
                   padded_out_width, out_channels, tile_count, pad_out_data);

  output->resize({batch, out_channels, out_height, out_width});
  unpad_output(output, pad_out_data, padded_out_height, padded_out_width);
  return;
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::calculate_output_shape_pad_size(
    const std::shared_ptr<Tensor<T>> input,
    const std::shared_ptr<Tensor<T>> filter, const index_t out_tile_height,
    const index_t out_tile_width, std::vector<index_t>* output_shape,
    std::vector<index_t>* in_pad_size, std::vector<index_t>* out_pad_size) {
  const index_t batches = input->dim(0);
  const index_t output_channels = filter->dim(0);
  const index_t in_height = input->dim(2);
  const index_t in_width = input->dim(3);

  // winograd supports only stride of 1
  const index_t stride_h = 1;
  const index_t stride_w = 1;

  const index_t kernel_height = filter->dim(2);
  const index_t kernel_width = filter->dim(3);

  index_t output_height = 0;
  index_t output_width = 0;

  in_pad_size->resize(4);
  out_pad_size->resize(4);
  output_shape->resize(4);

  output_height = (in_height - kernel_height) / stride_h + 1;
  output_width = (in_width - kernel_width) / stride_w + 1;

  const index_t in_height_pad = std::max<index_t>(
      0, (output_height - 1) * stride_h + kernel_height - in_height);
  const index_t in_width_pad = std::max<index_t>(
      0, (output_width - 1) * stride_w + kernel_width - in_width);

  output_shape->data()[0] = batches;
  output_shape->data()[1] = output_channels;
  output_shape->data()[2] = output_height;
  output_shape->data()[3] = output_width;

  const index_t padded_out_height =
      RoundUp<index_t>(output_height, out_tile_height);
  const index_t padded_out_width =
      RoundUp<index_t>(output_width, out_tile_width);
  const index_t padded_in_height =
      std::max(in_height + in_pad_size->data()[0],
               (padded_out_height - 1) * stride_h + kernel_height);
  const index_t padded_in_width =
      std::max(in_width + in_pad_size->data()[1],
               (padded_out_width - 1) * stride_w + kernel_width);

  in_pad_size->data()[0] = in_height_pad >> 1;
  in_pad_size->data()[1] =
      padded_in_height - in_height - in_pad_size->data()[0];
  in_pad_size->data()[2] = in_width_pad >> 1;
  in_pad_size->data()[3] = padded_in_width - in_width - in_pad_size->data()[2];

  out_pad_size->data()[0] = 0;
  out_pad_size->data()[1] = static_cast<int>(padded_out_height - output_height);
  out_pad_size->data()[2] = 0;
  out_pad_size->data()[3] = static_cast<int>(padded_out_width - output_width);
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::pad_input(const std::shared_ptr<Tensor<T>> input,
                                  const index_t pad_top, const index_t pad_left,
                                  std::shared_ptr<Tensor<T>> padded_input) {
  const index_t batch = input->dim(0);
  const index_t channels = input->dim(1);
  const index_t padded_input_height = padded_input->dim(2);
  const index_t padded_input_width = padded_input->dim(3);
  const index_t input_height = input->dim(2);
  const index_t input_width = input->dim(3);

  const index_t img_size = input_height * input_width;
  const index_t padded_img_size = padded_input_height * padded_input_width;

  const index_t pad_bottom = padded_input_height - input_height - pad_top;
  const index_t pad_right = padded_input_width - input_width - pad_left;

  T* pad_data = padded_input->mutable_data();
  const T* in_data = input->data();

  for (index_t b = 0; b < batch; ++b) {
    for (index_t c = 0; c < channels; ++c) {
      const index_t bc = b * channels + c;
      const float* in_base = in_data + bc * img_size;
      float* padded_in_base = pad_data + bc * padded_img_size;

      memset(padded_in_base, 0, sizeof(float) * pad_top * padded_input_width);
      padded_in_base += pad_top * padded_input_width;
      for (index_t h = 0; h < input_height; ++h) {
        memset(padded_in_base, 0, sizeof(float) * pad_left);
        memcpy(padded_in_base + pad_left, in_base, sizeof(float) * input_width);
        memset(padded_in_base + pad_left + input_width, 0,
               sizeof(float) * pad_right);
        in_base += input_width;
        padded_in_base += padded_input_width;
      }
      memset(padded_in_base, 0,
             sizeof(float) * pad_bottom * padded_input_width);
    }
  }
}

template <typename T, wino_k_t W, wino_o_t O>
void Winograd<T, W, O>::unpad_output(std::shared_ptr<Tensor<T>> output,
                                     const T* padded_output,
                                     const index_t padded_height,
                                     const index_t padded_width) {
  const index_t batch = output->dim(0);
  const index_t channels = output->dim(1);
  const index_t height = output->dim(2);
  const index_t width = output->dim(3);

  const T* padded_out_data = padded_output;
  T* out_data = output->mutable_data();

  const index_t img_size = height * width;
  const index_t padded_img_size = padded_height * padded_width;

  for (index_t b = 0; b < batch; ++b) {
    for (index_t c = 0; c < channels; ++c) {
      const index_t bc = (b * channels + c);
      T* out_base = out_data + bc * img_size;
      const T* padded_out_base = padded_out_data + bc * padded_img_size;

      for (index_t h = 0; h < height; ++h) {
        memcpy(out_base, padded_out_base, sizeof(T) * width);
        out_base += width;
        padded_out_base += padded_width;
      }  // h
    }    // c
  }      // b
}

#endif