#include <marlin>

#include "../utils/test_utils.h"
#include "conv/direct/direct_convolver.h"
#include "gtest/gtest.h"

TEST(JIT, Winograd) {
  Winograd<float, WINO_K_3x3, WINO_O_2x2> winograd;
  std::shared_ptr<Tensor<float>> input = std::make_shared<Tensor<float>>();
  std::shared_ptr<Tensor<float>> filter = std::make_shared<Tensor<float>>(true);
  std::shared_ptr<Tensor<float>> output = std::make_shared<Tensor<float>>();

  const index_t batch = 2;
  const index_t in_channels = 3;
  const index_t in_height = 20;
  const index_t in_width = 20;
  const index_t out_channels = 10;
  const index_t filter_height = 3;
  const index_t filter_width = 3;

  input->resize({batch, in_channels, in_height, in_width});
  filter->resize({out_channels, in_channels, filter_height, filter_width});
  initialize_tensor(input);
  initialize_tensor(filter);

#ifdef ENABLE_JIT
  const index_t in_tile_area = 16;
  std::shared_ptr<Tensor<float>> transformed_filter =
      std::make_shared<Tensor<float>>();
  transformed_filter->resize({out_channels, in_channels, in_tile_area});
  float *transformed_filter_data = transformed_filter->mutable_data();
  const float *filter_data = filter->data();

  winograd.transform_kernel(filter_data, out_channels, in_channels,
                            transformed_filter_data);

  std::shared_ptr<WinoJitter<float>> jitter =
      std::make_shared<WinoJitter<float>>();
  jitter->generate_code(transformed_filter_data, in_tile_area, in_channels,
                        out_channels);
#endif

#ifdef ENABLE_JIT
  winograd.run(input, filter, output, jitter);
#else
  winograd.run(input, filter, output);
#endif

  std::shared_ptr<Tensor<float>> output_d = std::make_shared<Tensor<float>>();
  std::unique_ptr<conv2d::DirectConvolver<float>> direct_convolver =
      std::make_unique<conv2d::DirectConvolver<float>>();
  std::vector<index_t> p = {0, 0, 0, 0};
  std::vector<index_t> s = {1, 1};
  direct_convolver->set_padding(p);
  direct_convolver->set_stride(s);
  direct_convolver->run(filter.get(), input.get(), output_d.get());

  verify_execution(output_d.get(), output.get());
}