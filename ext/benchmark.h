#ifndef __BENCHMARK_H__
#define __BENCHMARK_H__

#include <libxsmm.h>
#include <mkl.h>
#include <stdlib.h>

#include <Eigen/Dense>
#include <chrono>
#include <fstream>
#include <marlin>

#include "gtest/gtest.h"

using namespace testing;
using namespace Eigen;

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

/* initialize tensor */
template <typename T>
void initialize_tensor(std::shared_ptr<Tensor<T>> tensor) {
  index_t dim0 = tensor->dim(0);
  index_t dim1 = tensor->dim(1);
  index_t dim2 = tensor->dim(2);
  index_t dim3 = tensor->dim(3);

  T *data = tensor->mutable_data();

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
#endif