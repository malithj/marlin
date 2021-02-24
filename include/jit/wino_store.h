#ifndef __WINO_STORE_H__
#define __WINO_STORE_H__

#include "jit/code_store.h"
#include "log/logging.h"
#include "mem/memory.h"
#include "types/types.h"

using namespace Logging::LoggingInternals;

// CodeStore allocates virtual pages and creates Codelet containers that
// relay execution commands to the underlying page.
template <typename T>
class WinoStore : public CodeStore<T> {
 public:
  WinoStore<T>();
  ~WinoStore<T>() = default;
  const size_t get_code_size_b_tensor(const T*, const size_t, const size_t,
                                      const size_t);
  void generate_b_tensor(const T*, const size_t, const size_t, const size_t,
                         std::shared_ptr<ByteCode> bytecode);

 private:
  std::unique_ptr<Logger> logger;
};

template <typename T>
WinoStore<T>::WinoStore() {
  this->logger = std::make_unique<Logger>(__FILE__);
}

template <typename T>
const size_t WinoStore<T>::get_code_size_b_tensor(const T* b_tensor,
                                                  const size_t in_tile_area,
                                                  const size_t in_channels,
                                                  const size_t out_channels) {
  const size_t sc_size = this->sub_codelet_broadcast_b->size();
  const size_t sc_z_size = this->sub_codelet_broadcast_bz->size();

  size_t num_zeros = 0;
  for (index_t i = 0; i < 16 * in_channels * out_channels; ++i) {
    if (b_tensor[i] == 0) num_zeros++;
  }

  LOG_DEBUG("sub codelet b size: " + std::to_string(sc_size));
  LOG_DEBUG("sub codelet bz size: " + std::to_string(sc_z_size));
  LOG_DEBUG("number of zeros in B: " + std::to_string(num_zeros));

  const index_t num_rounds = 2;
  const index_t elements_per_tile = in_tile_area / num_rounds;
  const index_t num_tiles = num_rounds * in_channels * out_channels;
  const index_t tile_code = (elements_per_tile * sc_size + 1) * num_tiles;

  const index_t zero_optimized_code = num_zeros * (sc_size - sc_z_size);

  const index_t total_code_size = tile_code - zero_optimized_code;
  return total_code_size;
}

template <typename T>
void WinoStore<T>::generate_b_tensor(const T* b_tensor,
                                     const size_t in_tile_area,
                                     const size_t in_channels,
                                     const size_t out_channels,
                                     std::shared_ptr<ByteCode> bytecode) {
  size_t num_zeros = 0;
  for (index_t i = 0; i < in_channels * out_channels; ++i) {
    if (b_tensor[i] == 0) num_zeros++;
  }

  const index_t num_rounds = 2;
  const index_t elements_per_tile = in_tile_area / num_rounds;
  const index_t b_stride = in_channels * out_channels;
  const index_t total_code_size =
      get_code_size_b_tensor(b_tensor, in_tile_area, in_channels, out_channels);
  const index_t total_iterations = in_channels * out_channels * num_rounds;

  // define a vector to store generated B matrix code until transferred
  // to page memory
  bytecode->get_code_buffer()->resize(total_code_size);
  unsigned char* dest_ptr = bytecode->get_code_buffer()->mutable_data();

  bytecode->get_offset_buffer()->resize(total_iterations);
  index_t* track = bytecode->get_offset_buffer()->mutable_data();

  T* buffer = static_cast<T*>(aligned_alloc(elements_per_tile, sizeof(T)));
  index_t tally_code_size = 0;
  index_t idx = 0;
  track[idx++] = 0;
  // generate b tensor code
  for (index_t m = 0; m < out_channels; ++m) {
    for (index_t tidx = 0; tidx < in_tile_area; tidx += elements_per_tile) {
      for (index_t c = 0; c < in_channels; ++c) {
        memset(buffer, 0, sizeof(T) * elements_per_tile);
        const T* b_ptr = b_tensor + tidx * b_stride + m * in_channels + c;
        for (index_t i = 0; i < elements_per_tile; ++i)
          buffer[i] = b_ptr[i * b_stride];
        this->set_broadcast_b_matrix(dest_ptr + tally_code_size, buffer,
                                     elements_per_tile);
        tally_code_size +=
            this->get_code_size_broadcast_b_matrix(buffer, elements_per_tile);
        track[idx++] = tally_code_size;
      }
    }
  }

  if (tally_code_size != total_code_size) {
    throw std::runtime_error(
        "fatal error: expected code size different from the computed code "
        "size. expected: " +
        std::to_string(total_code_size) +
        " actual: " + std::to_string(tally_code_size));
  }
  aligned_free(buffer);
}
#endif