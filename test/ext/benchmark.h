#ifndef __BENCHMARK_H__
#define __BENCHMARK_H__
#include <libxsmm.h>
#include <mkl.h>
#include <stdlib.h>

#include <chrono>
#include <fstream>

#include "../../include/gemm/gemm_f32.h"
#include "../../include/mem/memory.h"
#include "gtest/gtest.h"
using namespace testing;

/*  write benchmarking results to file */
bool tofile(std::string filename, double *array, index_t height, index_t width,
            std::string header) {
  std::ofstream ofile;
  try {
    ofile.open(filename);
    ofile << header << "\n";
    for (index_t i = 0; i < height; ++i) {
      ofile << i;
      for (index_t j = 0; j < width; ++j) {
        double value = array[i * width + j];
        ofile << ", " << std::fixed << std::setprecision(6) << value;
      }
      ofile << "\n";
    }
    ofile.close();
  } catch (std::exception &e) {
    throw std::runtime_error(e.what());
    return false;
  }
  return true;
}

/*  Generate sparsity distribution according to the given threshold */
float sparsity_adjustment(const float sparsity) {
  index_t t_min = 0;
  index_t t_max = 100;

  index_t threshold = static_cast<index_t>(t_max * (1 - sparsity));
  index_t random_number =
      t_min + (rand() / static_cast<float>(RAND_MAX)) * (t_max - t_min);
  if (threshold < random_number) {
    return 0;
  } else {
    return rand() / static_cast<float>(RAND_MAX);
  }
}

#endif