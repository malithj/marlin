# MARLIN

[![License](https://img.shields.io/badge/license-BSD3-blue.svg "BSD 3-Clause License")](LICENSE.md)![Build](https://github.com/malithj/marlin/actions/workflows/c-cpp.yml/badge.svg)

<div align="center">
  <img src="docs/marlin.png" width="150" alt="MARLIN"/>
</div>

MARLIN is a library with JIT (Just-in-time) compilation support to optimize performance of small and medium matrix multiplication as well as convolutions. Currently, <span>Intel&#160;AVX&#8209;512</span> is supported. Compared to existing JIT GEMM libraries, MARLIN aims at converting data accesses to instruction accesses by embedding single precision floats within instructions as immediates. More details about the architecture of MARLIN is available in our paper published in CGO SRC 2021 (International Symposium on Code Generation and Optimization).


<a name="getting-started"></a><a name="hello-libxsmm"></a>**Getting Started**: The following C++ code is an example of how the library can be used. `A`, `B`, `C` are three float matrices and `B` matrix is constant. Thus, matrix `B` can be converted using our JIT API and subsequently the sgemm function can be invoked.

```cpp
#include <cstdlib>
#include <marlin>
#include <memory>

using namespace MARLIN;

int main(/*int argc, char* argv[]*/) {
  index_t m = 3;
  index_t n = 5;
  index_t k = 2;

  float *A = static_cast<float *>(std::malloc(m * k * sizeof(float)));
  float *B = static_cast<float *>(std::malloc(n * k * sizeof(float)));
  float *C = static_cast<float *>(std::malloc(m * n * sizeof(float)));
  
  // initialize input
  for (index_t i = 0; i < m; ++i) {
    for (index_t j = 0; j < k; ++j) {
      index_t idx = i * k + j;
      A[i * k + j] = i * k + j + 1;
    }
  }
  for (index_t i = 0; i < k; ++i) {
    for (index_t j = 0; j < n; ++j) {
      index_t idx = i * n + j;
      B[i * n + j] = idx + 1;
    }
  }
  
  // initiate the jitter and generate code
  std::shared_ptr<Jitter<float>> jitter = std::make_shared<Jitter<float>>();
  jitter->generate_code(B, m, k, n);

  // perform sgemm
  sgemm('N', 'N', m, n, k, 1.0, A, k, B, n, 0, C, n, jitter);
}
```

## Build Instructions

The unit tests depend on Google test framework and is required to build the library. The code for Google test can be updated through a git submodule update.

```bash
git submodule init
git submodule update
```

After the code is available, run the make command to build the library. The binary `libmarlin.so` will be created in the `build` directory. 

```bash
make
```

To verify whether everything's working as expected, build and run the unit tests using the following commands.

```bash
make test
./build/test
```

## External Benchmarks
