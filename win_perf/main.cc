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
#include "../ext/benchmark.h"
#include "../ext/onednn_matmul.h"
#include "conv/direct/direct_convolver.h"

int main(int argc, char *argv[]) {
  std::chrono::steady_clock::time_point begin;
  std::chrono::steady_clock::time_point end;
  std::chrono::microseconds duration;
  begin = std::chrono::steady_clock::now();
  index_t b = 1;
  index_t c = 10;
  index_t m = 10;
  index_t iterations = 100;
  index_t mode = -1;
  float sparsity = 0;

  auto help = [] {
    printf("asmGEMM Winograd. Distributed as part of profiling.\n");
#ifdef ENABLE_JIT
    printf("Built only for MARLIN Just-In-Time Compilation.\n");
#else
    printf("Built only for multiple library backends.\n");
#endif
    printf("\nusage: perf B C M ITERATIONS MODE [SPARSITY]\n");
    printf("\nThe modes supported by perf are:\n");
#ifdef ENABLE_JIT
    printf("  0\tMARLIN\n");
#else
    printf("  0\tMARLIN\n");
    printf("  1\tIntel MKL\n");
    printf("  2\tONEDNN\n");
    printf("  3\tJIT MKL\n");
    printf("  4\tJIT LIBXSMM\n");
#endif
    printf("\nThe arguments list:\n");
    printf("  B\tnumber of batches\n");
    printf("  C\tnumber of input channels\n");
    printf("  M\tnumber of output channels\n");
    printf("\nSee 'perf help for more tool help'\n");
    exit(0);
  };

  auto check_digit = [](char *value) {
    if (!isdigit(*value)) {
      throw std::runtime_error("cannot parse values. check usage");
    }
    return atoi(value);
  };

  auto check_float = [](char *value) {
    float sparsity;
    try {
      sparsity = std::stof(value);
    } catch (std::exception &e) {
      throw std::runtime_error("cannot parse values. check usage");
    }
    return sparsity;
  };

  if (argc == 6) {
    b = check_digit(argv[1]);
    c = check_digit(argv[2]);
    m = check_digit(argv[3]);
    iterations = check_digit(argv[4]);
    mode = check_digit(argv[5]);
    printf(
        "perf invoked with args: B=%ld, C=%ld, M=%ld, iterations=%ld, "
        "mode=%ld\n",
        b, c, m, iterations, mode);
  } else if (argc == 7) {
    b = check_digit(argv[1]);
    c = check_digit(argv[2]);
    m = check_digit(argv[3]);
    iterations = check_digit(argv[4]);
    mode = check_digit(argv[5]);
    sparsity = check_float(argv[6]);
    printf(
        "perf invoked with args: B=%ld, C=%ld, M=%ld, iterations=%ld, "
        "mode=%ld, sparsity=%.2f\n",
        b, c, m, iterations, mode, sparsity);
  } else {
    help();
  }

  Winograd<float, WINO_K_3x3, WINO_O_2x2> winograd;
  std::shared_ptr<Tensor<float>> input = std::make_shared<Tensor<float>>();
  std::shared_ptr<Tensor<float>> filter = std::make_shared<Tensor<float>>(true);
  std::shared_ptr<Tensor<float>> output = std::make_shared<Tensor<float>>();

  const index_t batch = b;
  const index_t in_channels = c;
  const index_t in_height = 32;
  const index_t in_width = 32;
  const index_t out_channels = m;
  const index_t filter_height = 3;
  const index_t filter_width = 3;

  input->resize({batch, in_channels, in_height, in_width});
  filter->resize({out_channels, in_channels, filter_height, filter_width});
  initialize_tensor(input);
  initialize_tensor(filter);

#ifdef ENABLE_JIT
  if (mode == 0) {
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
    for (index_t i = 0; i < iterations; ++i) {
      winograd.run(input, filter, output, jitter);
    }
  } else {
    printf("WARN: exiting perf without profiled execution!\n");
    return 0;
  }
#else
  if (mode == 0) {
    winograd.set_switch(LIBMARLIN);
    for (index_t i = 0; i < iterations; ++i) {
      winograd.run(input, filter, output);
    }
  } else if (mode == 1) {
    winograd.set_switch(LIBMKL);
    for (index_t i = 0; i < iterations; ++i) {
      winograd.run(input, filter, output);
    }
  } else if (mode == 2) {
    winograd.set_switch(LIBONEDNN);
    for (index_t i = 0; i < iterations; ++i) {
      winograd.run(input, filter, output);
    }
  } else if (mode == 3) {
    winograd.set_switch(JITMKL);
    for (index_t i = 0; i < iterations; ++i) {
      winograd.run(input, filter, output);
    }
  } else if (mode == 4) {
    winograd.set_switch(JITLIBXSMM);
    for (index_t i = 0; i < iterations; ++i) {
      winograd.run(input, filter, output);
    }
  } else {
    printf("WARN: exiting perf without profiled execution!\n");
  }
#endif  // 675611 microseconds
  end = std::chrono::steady_clock::now();
  duration = std::chrono::duration_cast<std::chrono::microseconds>(end - begin);
  printf("perf execution time: %ld microseconds\n", duration.count());
  return 0;
}