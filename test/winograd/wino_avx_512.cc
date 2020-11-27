
#include <marlin>

#include "../utils/test_utils.h"
#include "conv/direct/direct_convolver.h"
#include "gtest/gtest.h"

TEST(Winograd, InputLoad) {
  Winograd<float, WINO_K_3x3, WINO_O_2x2> winograd;
  std::shared_ptr<Tensor<float>> input = std::make_shared<Tensor<float>>();
  std::shared_ptr<Tensor<float>> filter = std::make_shared<Tensor<float>>(true);
  std::shared_ptr<Tensor<float>> output = std::make_shared<Tensor<float>>();

  const index_t batch = 2;
  const index_t channels = 3;
  const index_t in_height = 8;
  const index_t in_width = 8;
  const index_t num_filters = 10;
  const index_t filter_height = 3;
  const index_t filter_width = 3;

  input->resize({batch, channels, in_height, in_width});
  filter->resize({num_filters, channels, filter_height, filter_width});
  initialize_tensor(input);
  initialize_tensor(filter);
  winograd.run(input, filter, output);

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
