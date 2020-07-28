#ifndef __CODE_STORE_H__
#define __CODE_STORE_H__

#include <fcntl.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>

#include <cstring>
#include <fstream>
#include <iostream>
#include <memory>
#include <unordered_map>
#include <vector>

#include "../../log/logging.h"
#include "../ibase/ibase.h"
#include "../mem/memory.h"
#include "codelet.h"
#include "types.h"

using namespace Logging::LoggingInternals;

// CodeStore allocates virtual pages and creates Codelet containers that
// relay execution commands to the underlying page.
template <typename T>
class CodeStore : public IBase<T> {
 private:
  std::unique_ptr<Logger> logger;
  std::unique_ptr<std::vector<unsigned char>> sub_codelet_set_16_sp;
  std::unique_ptr<std::vector<unsigned char>> sub_codelet_broadcast_b;
  std::unique_ptr<std::vector<unsigned char>> sub_codelet_broadcast_bz;
  // fast execute method uses codelet positions
  std::shared_ptr<std::vector<index_t>> codelet_pos;
  size_t page_size_bytes_allocated = 0;
  void* p_addr = nullptr;
  // hashmap support
  bool hashmap_support_on = false;
  // define block params for code generation. !!!Important
  // these parameters must be consistent with GEMM block parameters.
  // Otherwise prefetchers might need to handle extra processing.
  index_t b_matrix_j_block_size = 64;
  index_t b_matrix_k_block_size = 64;
  index_t b_load_elements = 15;
  TILING_SCHEME tiling_scheme = B_COL_15_A_COL_1;

 public:
  CodeStore<T>();
  ~CodeStore<T>();
  // set floating point constants across the full width of the register (16SP)
  std::shared_ptr<std::vector<unsigned char>> set_16sp(T* constant_array,
                                                       size_t size);
  // set and broadcast B matrix
  void set_broadcast_b_matrix(unsigned char* dest, T* constant_array,
                              size_t size);
  size_t get_code_size_broadcast_b_matrix(T* b_matrix, size_t num_elements);
  size_t get_code_size_gemm_b_matrix(T* b_matrix, size_t k, size_t n);
  index_t get_b_load_elements() { return b_load_elements; }
  index_t get_j_block_size() { return b_matrix_j_block_size; }
  index_t get_k_block_size() { return b_matrix_k_block_size; }
  TILING_SCHEME get_tiling_scheme() { return tiling_scheme; }
  // generate instructions for B matrix
  std::tuple<std::shared_ptr<std::vector<unsigned char>>,
             std::shared_ptr<std::vector<index_t>>>
  generate_b_matrix(T* b_matrix, size_t k, size_t n);
  // store code and offset to file
  void tofile(std::string& filename,
              std::tuple<std::shared_ptr<std::vector<unsigned char>>,
                         std::shared_ptr<std::vector<index_t>>>
                  code_obj,
              index_t n, index_t k, index_t mode);
  // read code and offset from file
  void fromfile(std::string& filename, index_t n, index_t k, index_t mode);
  std::shared_ptr<std::vector<index_t>> get_codelet_pos();
  bool verify_instruction_integrity_16sp(
      std::shared_ptr<std::vector<unsigned char>> hex_ins);
  // Copy the code from the provided vector containing unsigned char bytes to
  // a virtual page obtained by the OS. Set the appropriate permissions
  void copy_code_to_execution_space(
      std::shared_ptr<std::vector<unsigned char>> hex_ins,
      std::shared_ptr<std::vector<index_t>> pos);
  // execute the code
  bool execute(T* ptr);
  bool fast_execute(index_t offset);
  // pretty print the code based on formatting predefined
  void pretty_print_16sp(std::shared_ptr<std::vector<unsigned char>> hex_ins);
  void pretty_print_gemm_b(std::shared_ptr<std::vector<unsigned char>> hex_ins);
  // adapt the code to different ZMM registers
  void replace_zmm_b(unsigned char* sub_codelet, unsigned char reg_zmm);
  void replace_zmm_bz(unsigned char* sub_codelet, unsigned char reg_zmm);
  // adapt the code to different B constant values
  void replace_b(unsigned char* sub_codelet, T* array, unsigned char reg_zmm);
  // set internal parameters
  void set_b_load_elements(index_t ble) { this->b_load_elements = ble; };
  void set_tiling_scheme(TILING_SCHEME scheme) {
    this->tiling_scheme = scheme;
  };
};

template <typename T>
CodeStore<T>::CodeStore() {
  this->logger = std::make_unique<Logger>(__FILE__);
  // The following inline assembly has been converted in to code. (Except for
  // rsi -> rdi move required to set the memory location of the array to be
  // overwritten). The following codelet loads 1 - 16 floating point numbers to
  // ZMM0 register and stores the values in the register (16 SPs) to memory.
  //
  unsigned char sub_codelet_16_sp[382] = {
      0x48, 0x83, 0xec, 0x40,                                // 3c
      0x48, 0xc7, 0x44, 0x24, 0xf8, 0x00, 0x00, 0x80, 0x41,  // 40
      0x48, 0xc7, 0x44, 0x24, 0xf0, 0x00, 0x00, 0x70, 0x41,  // 49
      0x48, 0xc7, 0x44, 0x24, 0xe8, 0x00, 0x00, 0x60, 0x41,  // 52
      0x48, 0xc7, 0x44, 0x24, 0xe0, 0x00, 0x00, 0x50, 0x41,  // 5b
      0x48, 0xc7, 0x44, 0x24, 0xd8, 0x00, 0x00, 0x40, 0x41,  // 64
      0x48, 0xc7, 0x44, 0x24, 0xd0, 0x00, 0x00, 0x30, 0x41,  // 6d
      0x48, 0xc7, 0x44, 0x24, 0xc8, 0x00, 0x00, 0x20, 0x41,  // 76
      0x48, 0xc7, 0x44, 0x24, 0xc0, 0x00, 0x00, 0x10, 0x41,  // 7f
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0x00, 0x41,              // 88
      0x66, 0x48, 0x0f, 0x6e, 0xf8,                          // 8f
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0xe0, 0x40,              // 94
      0x66, 0x48, 0x0f, 0x6e, 0xf0,                          // 9b
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0xc0, 0x40,              // a0
      0x66, 0x48, 0x0f, 0x6e, 0xe8,                          // a7
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0xa0, 0x40,              // ac
      0x66, 0x48, 0x0f, 0x6e, 0xe0,                          // b3
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0x80, 0x40,              // b8
      0x66, 0x48, 0x0f, 0x6e, 0xd8,                          // bf
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0x40, 0x40,              // c4
      0x66, 0x48, 0x0f, 0x6e, 0xd0,                          // cb
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0x00, 0x40,              // d0
      0x66, 0x48, 0x0f, 0x6e, 0xc8,                          // d7
      0x48, 0xc7, 0xc0, 0x00, 0x00, 0x80, 0x3f,              // dc
      0x66, 0x48, 0x0f, 0x6e, 0xc0,                          // e3
      0x0f, 0xc6, 0xc0, 0x15,                                // 38
      0x0f, 0xc6, 0xc9, 0x45,                                // ec
      0x0f, 0xc6, 0xd2, 0x51,                                // f0
      0x0f, 0x58, 0xc1,                                      // f4
      0x0f, 0x58, 0xc2,                                      // f7
      0x0f, 0x58, 0xc3,                                      // fa
      0xc4, 0xe3, 0x7d, 0x18, 0xc0, 0x01,                    // fd
      0x0f, 0x28, 0xc4,                                      // 103
      0x0f, 0x28, 0xcd,                                      // 106
      0x0f, 0x28, 0xd6,                                      // 109
      0x0f, 0x28, 0xdf,                                      // 10c
      0x0f, 0xc6, 0xc0, 0x15,                                // 10f
      0x0f, 0xc6, 0xc9, 0x45,                                // 113
      0x0f, 0xc6, 0xd2, 0x51,                                // 117
      0x0f, 0x58, 0xc1,                                      // 11b
      0x0f, 0x58, 0xc2,                                      // 11e
      0x0f, 0x58, 0xc3,                                      // 121
      0x62, 0xf1, 0x74, 0x48, 0x57, 0xc9,                    // 124
      0x62, 0xf3, 0xf5, 0x48, 0x1a, 0xc8, 0x01,              // 12a
      0x62, 0xf1, 0x54, 0x48, 0x57, 0xed,                    // 131
      0x62, 0xf1, 0x7c, 0x48, 0x28, 0xe9,                    // 137
      0x66, 0x0f, 0x6e, 0x44, 0x24, 0xc0,                    // 13d
      0x66, 0x0f, 0x6e, 0x4c, 0x24, 0xc8,                    // 143
      0x66, 0x0f, 0x6e, 0x54, 0x24, 0xd0,                    // 149
      0x66, 0x0f, 0x6e, 0x5c, 0x24, 0xd8,                    // 14f
      0x0f, 0xc6, 0xc0, 0x15,                                // 155
      0x0f, 0xc6, 0xc9, 0x45,                                // 159
      0x0f, 0xc6, 0xd2, 0x51,                                // 15d
      0x0f, 0x58, 0xc1,                                      // 161
      0x0f, 0x58, 0xc2,                                      // 164
      0x0f, 0x58, 0xc3,                                      // 167
      0xc4, 0xe3, 0x7d, 0x18, 0xc0, 0x01,                    // 16a
      0x66, 0x0f, 0x6e, 0x44, 0x24, 0xe0,                    // 170
      0x66, 0x0f, 0x6e, 0x4c, 0x24, 0xe8,                    // 176
      0x66, 0x0f, 0x6e, 0x54, 0x24, 0xf0,                    // 17c
      0x66, 0x0f, 0x6e, 0x5c, 0x24, 0xf8,                    // 182
      0x0f, 0xc6, 0xc0, 0x15,                                // 188
      0x0f, 0xc6, 0xc9, 0x45,                                // 18c
      0x0f, 0xc6, 0xd2, 0x51,                                // 190
      0x0f, 0x58, 0xc1,                                      // 194
      0x0f, 0x58, 0xc2,                                      // 197
      0x0f, 0x58, 0xc3,                                      // 19a
      0x62, 0xf1, 0x7c, 0x48, 0x58, 0xc5,                    // 19d
      0x62, 0x71, 0x7c, 0x48, 0x28, 0xc0,                    // 1a3
      0x48, 0x83, 0xc4, 0x40,                                // 1a9
      0x62, 0xd1, 0x7c, 0x48, 0x28, 0xc0,                    // 1ad
      0x62, 0xf1, 0x7c, 0x48, 0x29, 0x07,                    // 1b
      0xc3};                                                 // return}
  unsigned char sub_codelet_b[11] = {
      0xb8, 0x00, 0x00, 0x00, 0x41,       // mov     eax, 0x41000000
      0x62, 0xf2, 0x7d, 0x48, 0x7c, 0xc0  // vpbroadcastd zmm0, eax
  };
  unsigned char sub_codelet_bz[6] = {
      0x62, 0xf1, 0x7c, 0x48, 0x57, 0xc0  // vxorps zmm0, zmm0, zmm0
  };

  this->sub_codelet_set_16_sp = std::make_unique<std::vector<unsigned char>>(
      sub_codelet_16_sp, sub_codelet_16_sp + sizeof(sub_codelet_16_sp));
  this->sub_codelet_broadcast_b = std::make_unique<std::vector<unsigned char>>(
      sub_codelet_b, sub_codelet_b + sizeof(sub_codelet_b));
  this->sub_codelet_broadcast_bz = std::make_unique<std::vector<unsigned char>>(
      sub_codelet_bz, sub_codelet_bz + sizeof(sub_codelet_bz));
}

template <typename T>
CodeStore<T>::~CodeStore() {
  munmap(this->p_addr, this->page_size_bytes_allocated);
}

// verification of instructions only performed for constant setting
template <typename T>
bool CodeStore<T>::verify_instruction_integrity_16sp(
    std::shared_ptr<std::vector<unsigned char>> hex_ins) {
  uint8_t locations_modified[hex_ins->size()];
  memset(&locations_modified, 0, hex_ins->size());

  /* identify locations modified */
  for (index_t i = 0; i < 16; ++i) {
    const index_t idx = 9 + (i < 8 ? 9 * i : 70 + (i - 8) * 12);
    for (index_t j = 0; j < 4; ++j) {
      locations_modified[idx + j] = 1;
    }
  }
  /* verify other instructions */
  for (index_t i = 0; i < hex_ins->size(); ++i) {
    if (locations_modified[i] == 0 &&
        hex_ins->at(i) != this->sub_codelet_set_16_sp->at(i)) {
      throw std::domain_error(
          "Integrity of instructions compromised. Cannot recover state.");
    }
  }
  return true;
}

template <typename T>
std::shared_ptr<std::vector<unsigned char>> CodeStore<T>::set_16sp(
    T* constant_array, size_t size) {
  size_t byte_size = this->sub_codelet_set_16_sp->size();

  // create a copy of the vector as shared
  std::shared_ptr<std::vector<unsigned char>> __sub_codelet =
      std::make_shared<std::vector<unsigned char>>(byte_size);
  std::memcpy(__sub_codelet->data(), this->sub_codelet_set_16_sp->data(),
              byte_size);

  // create a buffer to separate out the bytes of a given floating point number
  unsigned char buffer[4];

  for (index_t i = 0; i < size; ++i) {
    // figure out start index. The first number starts at idx 9 (offloads to
    // stack). The offset of the stack numbers are 9. Afterwards the offset
    // changes to 12. This is handled in the following one liner.
    const index_t idx = 9 + (i < 8 ? 9 * i : 70 + (i - 8) * 12);

    // copy the memory and set bytes
    memcpy(&buffer, constant_array + i, sizeof(float));
    __sub_codelet->at(idx) = buffer[0];
    __sub_codelet->at(idx + 1) = buffer[1];
    __sub_codelet->at(idx + 2) = buffer[2];
    __sub_codelet->at(idx + 3) = buffer[3];
  }
  return __sub_codelet;
}

template <typename T>
void CodeStore<T>::set_broadcast_b_matrix(unsigned char* dest, T* b_matrix,
                                          size_t size) {
  size_t sub_codelet_size = sub_codelet_broadcast_b->size();
  size_t sub_codelet_z_size = sub_codelet_broadcast_bz->size();
  size_t total_code_size = get_code_size_broadcast_b_matrix(b_matrix, size);

  unsigned char* source_ptr = this->sub_codelet_broadcast_b->data();
  unsigned char* source_z_ptr = this->sub_codelet_broadcast_bz->data();
  unsigned char* dest_ptr = dest;

  size_t offset = 0;
  unsigned char zmm = 32;

  // fill in the code for all ZMM registers that include matrix B
  // private var includes only one ZMM register set. It needs to be
  // propagated to other registers.
  for (index_t i = 0; i < size; ++i) {
    if (b_matrix[i] == 0) {
      std::memcpy(dest_ptr + offset, source_z_ptr, sub_codelet_z_size);
      // fill b matrix broadcast registers from the bottom of ZMM registers.
      // i.e. start with ZMM31 and move up to ensure full space can be utilized
      // in later stages
      this->replace_zmm_bz(dest_ptr + offset, --zmm);
      offset += sub_codelet_z_size;
    } else {
      std::memcpy(dest_ptr + offset, source_ptr, sub_codelet_size);
      this->replace_zmm_b(dest_ptr + offset, --zmm);
      // embed b constants in to the instructions
      this->replace_b(dest_ptr + offset, b_matrix + i, zmm);
      offset += sub_codelet_size;
    }
  }

  // push back assembly "RETURN"
  dest[total_code_size - 1] = 0xc3;
}

template <typename T>
std::shared_ptr<std::vector<index_t>> CodeStore<T>::get_codelet_pos() {
  if (this->codelet_pos == nullptr) {
    throw std::domain_error(
        "unintialized codelet offset detected. are you sure code has been "
        "copied to the execution space?");
  }
  return this->codelet_pos;
}

template <typename T>
std::tuple<std::shared_ptr<std::vector<unsigned char>>,
           std::shared_ptr<std::vector<index_t>>>
CodeStore<T>::generate_b_matrix(T* b_matrix, size_t k, size_t n) {
  size_t num_zeros = 0;
  for (index_t i = 0; i < k * n; ++i) {
    if (b_matrix[i] == 0) num_zeros++;
  }
  T sparsity = static_cast<T>(num_zeros / static_cast<T>(k * n));
  b_matrix_k_block_size = b_matrix_j_block_size =
      this->compute_adjusted_blocks(sparsity);
  const index_t total_code_size = get_code_size_gemm_b_matrix(b_matrix, k, n);

  // define a vector to store generated B matrix code until transferred
  // to page memory
  std::shared_ptr<std::vector<unsigned char>> code =
      std::make_shared<std::vector<unsigned char>>(total_code_size);
  std::shared_ptr<std::vector<index_t>> track =
      std::make_shared<std::vector<index_t>>();

  if (this->b_load_elements > 15) {
    throw std::invalid_argument(
        "cannot broadcast more than 15 values of B. (total registers available "
        "on AVX512 is 32. C requires same number of registers allocated to B. "
        "A requires at least one register.). requested registers for B: " +
        std::to_string(this->b_load_elements));
  }

  index_t b_cols = 15;
  index_t a_cols = 1;
  if (this->tiling_scheme == B_COL_15_A_COL_1) {
    b_cols = 15;
    a_cols = 1;
  } else if (this->tiling_scheme == B_COL_10_A_COL_2) {
    b_cols = 10;
    a_cols = 2;
  } else if (this->tiling_scheme == B_COL_7_A_COL_3) {
    b_cols = 7;
    a_cols = 3;
  } else if (this->tiling_scheme == B_COL_5_A_COL_4) {
    b_cols = 5;
    a_cols = 4;
  } else if (this->tiling_scheme == B_COL_4_A_COL_5) {
    b_cols = 4;
    a_cols = 5;
  } else if (this->tiling_scheme == B_COL_3_A_COL_7) {
    b_cols = 3;
    a_cols = 7;
  } else if (this->tiling_scheme == B_COL_2_A_COL_10) {
    b_cols = 2;
    a_cols = 10;
  } else if (this->tiling_scheme == B_COL_1_A_COL_15) {
    b_cols = 1;
    a_cols = 15;
  } else {
    throw std::invalid_argument("unknown micro-tiling scheme selected");
  }

  T* buffer = static_cast<T*>(aligned_alloc(b_cols * a_cols, sizeof(T)));
  unsigned char* dest_ptr = code->data();

  index_t tally_code_size = 0;
  for (index_t jb = 0; jb < n; jb += b_matrix_j_block_size) {
    /* j block overflow condition */
    index_t jb_lim = std::min(jb + b_matrix_j_block_size, n);
    for (index_t kb = 0; kb < k; kb += b_matrix_k_block_size) {
      /* k block overflow condition */
      index_t kb_lim = std::min(kb + b_matrix_k_block_size, k);
      // generate b matrix code
      for (index_t kk = kb; kk < kb_lim; kk += a_cols) {
        const index_t num_a_cols = kb_lim - kk >= a_cols ? a_cols : kb_lim - kk;
        for (index_t jj = jb; jj < jb_lim; jj += b_cols) {
          const index_t num_elems =
              jb_lim - jj >= b_cols ? b_cols : jb_lim - jj;
          memset(buffer, 0, sizeof(T) * a_cols * b_cols);
          for (index_t buf_idx = 0; buf_idx < num_a_cols; ++buf_idx) {
            memcpy(buffer + (b_cols * buf_idx),
                   b_matrix + (kk + buf_idx) * n + jj, num_elems * sizeof(T));
          }
          set_broadcast_b_matrix(dest_ptr + tally_code_size, buffer,
                                 b_cols * a_cols);
          tally_code_size +=
              get_code_size_broadcast_b_matrix(buffer, b_cols * a_cols);
          track->push_back(tally_code_size);
        }
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
  return std::make_tuple(code, track);
}

template <typename T>
size_t CodeStore<T>::get_code_size_broadcast_b_matrix(T* b_matrix,
                                                      size_t size) {
  size_t num_zeros = 0;
  for (index_t i = 0; i < size; ++i) {
    if (b_matrix[i] == 0) num_zeros++;
  }
  size_t sub_codelet_size = sub_codelet_broadcast_b->size();
  size_t sub_codelet_z_size = sub_codelet_broadcast_bz->size();
  size_t total_code_size =
      (size - num_zeros) * sub_codelet_size + num_zeros * sub_codelet_z_size;
  return total_code_size + 1;  // include return statement 0xc3
}

template <typename T>
size_t CodeStore<T>::get_code_size_gemm_b_matrix(T* b_matrix, size_t k,
                                                 size_t n) {
  size_t sc_size = sub_codelet_broadcast_b->size();
  size_t sc_z_size = sub_codelet_broadcast_bz->size();

  // adjust block sizes for small matrices
  this->b_matrix_j_block_size = std::min(n, this->b_matrix_j_block_size);
  this->b_matrix_k_block_size = std::min(k, this->b_matrix_k_block_size);

  size_t num_zeros = 0;
  for (index_t i = 0; i < k * n; ++i) {
    if (b_matrix[i] == 0) num_zeros++;
  }
  LOG_DEBUG("sub codelet b size: " + std::to_string(sc_size));
  LOG_DEBUG("sub codelet bz size: " + std::to_string(sc_z_size));
  LOG_DEBUG("number of zeros in B: " + std::to_string(num_zeros));

  // abbreviated variable names
  const index_t bsize = b_matrix_j_block_size;
  const index_t ksize = b_matrix_k_block_size;
  index_t b_cols = 15;
  index_t a_cols = 1;
  if (this->tiling_scheme == B_COL_15_A_COL_1) {
    b_cols = 15;
    a_cols = 1;
  } else if (this->tiling_scheme == B_COL_10_A_COL_2) {
    b_cols = 10;
    a_cols = 2;
  } else if (this->tiling_scheme == B_COL_7_A_COL_3) {
    b_cols = 7;
    a_cols = 3;
  } else if (this->tiling_scheme == B_COL_5_A_COL_4) {
    b_cols = 5;
    a_cols = 4;
  } else if (this->tiling_scheme == B_COL_4_A_COL_5) {
    b_cols = 4;
    a_cols = 5;
  } else if (this->tiling_scheme == B_COL_3_A_COL_7) {
    b_cols = 3;
    a_cols = 7;
  } else if (this->tiling_scheme == B_COL_2_A_COL_10) {
    b_cols = 2;
    a_cols = 10;
  } else if (this->tiling_scheme == B_COL_1_A_COL_15) {
    b_cols = 1;
    a_cols = 15;
  } else {
    throw std::invalid_argument("unknown micro-tiling scheme selected");
  }
  const index_t vertical_nblocks = k / ksize;
  const index_t vertical_lblocks = k % ksize > 0 ? 1 : 0;
  const index_t k_iters_per_nblock = ksize / a_cols;
  const index_t k_remain_per_nblock = ksize % a_cols;
  const index_t k_iters_per_lblock = (k % ksize) / a_cols;
  const index_t k_remain_per_lblock = (k % ksize) % a_cols;
  const index_t k_iters = k_iters_per_nblock * vertical_nblocks +
                          k_iters_per_lblock * vertical_lblocks;

  LOG_DEBUG("b size recorded as: " + std::to_string(bsize));
  LOG_DEBUG("num b cols recorded as: " + std::to_string(b_cols));
  LOG_DEBUG("num a cols recorded as: " + std::to_string(a_cols));
  LOG_DEBUG("k iterations recorded as: " + std::to_string(k_iters));
  LOG_DEBUG("k iters per nblock: " + std::to_string(k_iters_per_nblock));
  LOG_DEBUG("k iters per lblock: " + std::to_string(k_iters_per_lblock));
  LOG_DEBUG("k remain per nblock: " + std::to_string(k_remain_per_nblock));
  LOG_DEBUG("k remain per lblock: " + std::to_string(k_remain_per_lblock));
  LOG_DEBUG("k iters: " + std::to_string(k_iters));

  // nblock: normal block code size for setting b constants
  index_t melem = bsize / b_cols;  // main num of iterations
  index_t nblock_b_code_size =
      melem != 0 ? melem * (b_cols * a_cols * sc_size + 1) : 0;
  index_t relem = bsize % b_cols;  // remaining iterations
  index_t nblock_bz_code_size =
      relem != 0 ? a_cols * (relem * sc_size + (b_cols - relem) * sc_z_size) + 1
                 : 0;
  // compute nblock code size
  index_t nblock_code_size = nblock_b_code_size + nblock_bz_code_size;
  LOG_DEBUG("num of iterations per normal block: " + std::to_string(melem));
  LOG_DEBUG("normal block code size (assuming all nnz): " +
            std::to_string(nblock_b_code_size));
  LOG_DEBUG("remaining iterations per normal block: " + std::to_string(relem));
  LOG_DEBUG("normal block code size for remainder (assuming all nnz): " +
            std::to_string(nblock_bz_code_size));

  // lblock: last block code size for setting b constants
  index_t lblock_width = n % bsize;
  melem = lblock_width / b_cols;
  index_t lblock_b_code_size =
      melem != 0 ? melem * (b_cols * a_cols * sc_size + 1) : 0;
  relem = (lblock_width % b_cols);
  index_t lblock_bz_code_size =
      relem != 0 ? a_cols * (relem * sc_size + (b_cols - relem) * sc_z_size) + 1
                 : 0;
  // compute lblock code size
  index_t lblock_code_size = lblock_b_code_size + lblock_bz_code_size;
  LOG_DEBUG("last block code size: " + std::to_string(lblock_width));
  LOG_DEBUG("last block full b row set number: " + std::to_string(melem));
  LOG_DEBUG("last block remain elements of b: " + std::to_string(relem));

  // compute number of normal blocks
  const index_t num_nblocks = n / bsize;
  // check whether a remainder block is available
  const index_t num_lblocks = n % bsize != 0 ? 1 : 0;

  const index_t total_code_full_k = k_iters * (num_nblocks * nblock_code_size +
                                               num_lblocks * lblock_code_size);

  // need to adjust to k remaining iterations
  // normal block of j with normal block of k
  melem = bsize / b_cols;  // main num of iterations
  index_t k_nblock_j_nblock_b_code_size =
      melem != 0 && k_remain_per_nblock != 0 && vertical_nblocks != 0
          ? melem * (b_cols * k_remain_per_nblock * sc_size +
                     b_cols * (a_cols - k_remain_per_nblock) * sc_z_size + 1)
          : 0;
  relem = bsize % b_cols;  // remaining iterations
  index_t k_nblock_j_nblock_bz_code_size =
      relem != 0 && k_remain_per_nblock != 0 && vertical_nblocks != 0
          ? k_remain_per_nblock *
                    (relem * sc_size + (b_cols - relem) * sc_z_size) +
                (a_cols - k_remain_per_nblock) * b_cols * sc_z_size + 1
          : 0;
  index_t k_nblock_j_nblock_code_size =
      k_nblock_j_nblock_b_code_size + k_nblock_j_nblock_bz_code_size;

  // normal block of j with last block of k
  melem = bsize / b_cols;  // main num of iterations
  index_t k_lblock_j_nblock_b_code_size =
      melem != 0 && k_remain_per_lblock != 0 && vertical_lblocks != 0
          ? melem * (b_cols * k_remain_per_lblock * sc_size +
                     b_cols * (a_cols - k_remain_per_lblock) * sc_z_size + 1)
          : 0;
  relem = bsize % b_cols;  // remaining iterations
  index_t k_lblock_j_nblock_bz_code_size =
      relem != 0 && k_remain_per_lblock != 0 && vertical_lblocks != 0
          ? k_remain_per_lblock *
                    (relem * sc_size + (b_cols - relem) * sc_z_size) +
                (a_cols - k_remain_per_lblock) * b_cols * sc_z_size + 1
          : 0;
  index_t k_lblock_j_nblock_code_size =
      k_lblock_j_nblock_b_code_size + k_lblock_j_nblock_bz_code_size;

  // last block of j with normal block of k
  lblock_width = n % bsize;
  melem = lblock_width / b_cols;
  index_t k_nblock_j_lblock_b_code_size =
      melem != 0 && k_remain_per_nblock != 0 && vertical_nblocks != 0
          ? melem * (b_cols * k_remain_per_nblock * sc_size +
                     b_cols * (a_cols - k_remain_per_nblock) * sc_z_size + 1)
          : 0;
  relem = (lblock_width % b_cols);
  index_t k_nblock_j_lblock_bz_code_size =
      relem != 0 && k_remain_per_nblock != 0 && vertical_nblocks != 0
          ? k_remain_per_nblock *
                    (relem * sc_size + (b_cols - relem) * sc_z_size) +
                (a_cols - k_remain_per_nblock) * b_cols * sc_z_size + 1
          : 0;
  index_t k_nblock_j_lblock_code_size =
      k_nblock_j_lblock_b_code_size + k_nblock_j_lblock_bz_code_size;

  // last block of j with last block of k
  lblock_width = n % bsize;
  melem = lblock_width / b_cols;
  index_t k_lblock_j_lblock_b_code_size =
      melem != 0 && k_remain_per_lblock != 0 && vertical_lblocks != 0
          ? melem * (b_cols * k_remain_per_lblock * sc_size +
                     b_cols * (a_cols - k_remain_per_lblock) * sc_z_size + 1)
          : 0;
  relem = (lblock_width % b_cols);
  index_t k_lblock_j_lblock_bz_code_size =
      relem != 0 && k_remain_per_lblock != 0 && vertical_lblocks != 0
          ? k_remain_per_lblock *
                    (relem * sc_size + (b_cols - relem) * sc_z_size) +
                (a_cols - k_remain_per_lblock) * b_cols * sc_z_size + 1
          : 0;
  index_t k_lblock_j_lblock_code_size =
      k_lblock_j_lblock_b_code_size + k_lblock_j_lblock_bz_code_size;

  nblock_code_size = vertical_nblocks * k_nblock_j_nblock_code_size +
                     vertical_lblocks * k_lblock_j_nblock_code_size;
  lblock_code_size = vertical_nblocks * k_nblock_j_lblock_code_size +
                     vertical_lblocks * k_lblock_j_lblock_code_size;

  const index_t total_code_remain_k =
      num_nblocks * nblock_code_size + num_lblocks * lblock_code_size;
  const index_t total_code = total_code_full_k + total_code_remain_k;

  const index_t total_code_size =
      total_code - (sc_size - sc_z_size) * num_zeros;
  return total_code_size;
}

// This is the heart of CodeStore in charge of creating virtual pages and
// generating the hashmap index. If position vector is empty (i.e. the user is
// letting know to treat the code space as one execution block), default key is
// set as (0,0). This key can be used to execute by default.
template <typename T>
void CodeStore<T>::copy_code_to_execution_space(
    std::shared_ptr<std::vector<unsigned char>> hex_ins,
    std::shared_ptr<std::vector<index_t>> pos) {
  const size_t size_of_pages_bytes = get_required_num_pages(hex_ins->size());

  // If addr is null, kernel chooses where to create the mapping. else kernel
  // takes a hint as to where memory mapping should be created.
  // size_of_page_bytes : length of bytes is specified as a multiple
  //                      of the page size.
  // PROT (Memory Protection)
  // PROT_EXEC          : Pages may be executed
  // PROT_WRITE         : Pages may be written
  // PROT_READ          : Pages may be read
  // PROT_NONE          : Pages may not be accessed
  //
  // flags (determines whether updates are visible to other processes
  //        mapping the same region. Also whether it modifies the
  //        underlying file)
  // MAP_SHARED          : Mapping shared and updates carried to the file
  // MAP_SHARED_VALIDATE : Verifies all flags are validated (even unbeknownst)
  // MAP_PRIVATE         : Not visible to other processes & changes not carried
  //                       to the file. Modifications directly to the file may
  //                       not be visible in the mapped region.
  // MAP_32BIT           : Allocate in the first 2 gigabytes of the process
  //                       page. Supported only in x86_64 to improve context sw.
  // MAP_ANONYMOUS       : Mapping is not backed by any file. file descriptor
  //                       (fd) must be set to -1 to ensure portability.
  // MAP_FIXED           : place the address exactly specified as addr. If the
  //                       region overlaps with a preexistent allocation,
  //                       overlapping existing memory will be discarded.
  //                       USE WITH CARE!
  //
  // file descriptor     : -1
  // offset              : 0
  //
  // return:
  //  set the page address of the copied memory
  void* p_addr =
      static_cast<void*>(mmap(0, size_of_pages_bytes, PROT_READ | PROT_WRITE,
                              MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
  if (p_addr == MAP_FAILED) {
    throw std::runtime_error("Cannot dynamically allocated page memory");
  }

  // copy the instruction bytes to the virtual memory page
  std::memcpy(p_addr, hex_ins->data(), hex_ins->size());

  // change page permissions now data has been copied
  int mresult = mprotect(p_addr, size_of_pages_bytes, PROT_READ | PROT_EXEC);
  if (mresult == -1) {
    throw std::runtime_error("Cannot dynamically allocated page memory");
  }

  this->page_size_bytes_allocated = size_of_pages_bytes;
  this->p_addr = p_addr;
  pos->insert(pos->begin(), static_cast<index_t>(0));
  this->codelet_pos = pos;
  // deprecated: original method call followed
  // create_codelet_indexing(pos);
}

// This is a deprecated method. Used to verify the accuracy
// in virtual page creation. Refrain from using this method.
// It is kept only to verify virtual page creation and execution
// initiation.
template <typename T>
bool CodeStore<T>::execute(T* ptr) {
  void (*execute_function)(float* pointer);
  execute_function = reinterpret_cast<void (*)(T*)>(this->p_addr);

  try {
    execute_function(ptr);
  } catch (std::exception& e) {
    throw std::runtime_error(
        "illegal memory access reported while executing codelet");
  }
  return true;
}

// default execution
template <typename T>
bool CodeStore<T>::fast_execute(index_t offset) {
  if (offset >= page_size_bytes_allocated) {
    throw std::out_of_range("please check the offset. page size: " +
                            std::to_string(page_size_bytes_allocated) +
                            " requested: " + std::to_string(offset));
  }
  void (*execute_function)();
  try {
    execute_function = reinterpret_cast<void (*)()>(
        static_cast<unsigned char*>(this->p_addr) + offset);
  } catch (std::exception& e) {
    throw std::runtime_error("cannot reinterpret function pointer");
  }

  try {
    execute_function();
  } catch (std::exception& e) {
    throw std::runtime_error(
        "illegal memory access reported while executing codelet");
  }
  return true;
}

template <typename T>
void CodeStore<T>::pretty_print_16sp(
    std::shared_ptr<std::vector<unsigned char>> hex_ins) {
  index_t idx_7 = 0;
  index_t idx_12 = 0;
  for (index_t i = 0; i < hex_ins->size(); ++i) {
    printf("0x%02x, ", hex_ins->at(i));
    if (i == 3) {
      printf("\n");
    } else if (i > 75) {
      if ((i - 75) == (idx_7 * 12 + 7)) {
        printf("\n");
        idx_7++;
      } else if ((i - 75) == (idx_12 * 12 + 12)) {
        printf("\n");
        idx_12++;
      }
    } else if (i >= 12 && (i - 12) % 9 == 0) {
      printf("\n");
    }
  }
}

template <typename T>
void CodeStore<T>::pretty_print_gemm_b(
    std::shared_ptr<std::vector<unsigned char>> hex_ins) {
  bool bflag = false;
  bool zflag = false;
  for (index_t i = 0; i < hex_ins->size(); ++i) {
    if (i > 2 && hex_ins->at(i - 2) == 0xc7 && hex_ins->at(i - 1) == 0xc0) {
      bflag = true;
    }
    if (hex_ins->at(i) == 0x62 && hex_ins->at(i + 4) == 0x57) {
      zflag = true;
    }
    if (bflag) {
      printf("\033[0;33m");
      printf("%02x ", hex_ins->at(i));
    } else if (zflag) {
      printf("\033[1;32m");
      printf("%02x ", hex_ins->at(i));
    } else {
      printf("%02x ", hex_ins->at(i));
    }
    if (hex_ins->at(i) == 0xc3) {
      printf("\n");
    }
    printf("\033[0m");
    if (i > 5 && hex_ins->at(i - 5) == 0xc7 && hex_ins->at(i - 4) == 0xc0) {
      bflag = false;
    }
    if (i > 4 && hex_ins->at(i - 5) == 0x62 && hex_ins->at(i - 1) == 0x57) {
      zflag = false;
    }
  }
}

template <typename T>
void CodeStore<T>::replace_b(unsigned char* sub_codelet, T* constant_array,
                             unsigned char reg) {
  unsigned char* ptr = sub_codelet;
  index_t idx = 1;
  // create a buffer to separate out the bytes of a given floating point
  // number
  unsigned char buffer[4];
  memcpy(&buffer, constant_array, sizeof(float));
  ptr[idx] = buffer[0];
  ptr[idx + 1] = buffer[1];
  ptr[idx + 2] = buffer[2];
  ptr[idx + 3] = buffer[3];
}

// numbers are to be filled in reverse order (as if a stack)
template <typename T>
void CodeStore<T>::replace_zmm_b(unsigned char* sub_codelet,
                                 unsigned char reg_zmm) {
  if (reg_zmm < 8) {
    throw std::invalid_argument("cannot allocate scratch AVX registers. zmm :" +
                                std::to_string(reg_zmm));
  }
  unsigned char* ptr = sub_codelet;
  const index_t start = 5;  // 18 (prev val when load ins was in codelet);

  unsigned char* zmm_mc = ptr + start;
  unsigned char reg_zmm_bracket = reg_zmm / 8;
  // only the first and fifth elements need to be modified to adapt to a given
  // ZMM register.
  zmm_mc[1] = reg_zmm_bracket % 2 == 0 ? 0xf2 - 0x10 * (reg_zmm_bracket / 2)
                                       : 0x72 - 0x10 * (reg_zmm_bracket / 2);
  zmm_mc[5] = 0xc0 + 0x10 * ((reg_zmm % 8) / 2) + 0x08 * (reg_zmm % 2);
}

// set and broadcast zero along a given ZMM register
template <typename T>
void CodeStore<T>::replace_zmm_bz(unsigned char* sub_codelet,
                                  unsigned char reg_zmm) {
  if (reg_zmm < 8) {
    throw std::invalid_argument("cannot allocate scratch AVX registers. zmm :" +
                                std::to_string(reg_zmm));
  }
  unsigned char* zmm_mc = sub_codelet;
  unsigned char which_half = reg_zmm / 16;  // 16 bit bracket (3rd byte)
  unsigned char which_idx_in_half = reg_zmm % 16;
  unsigned char which_quater = which_idx_in_half / 8;  // 8 bit bracket
  unsigned char which_idx_in_quater = which_idx_in_half % 8;

  zmm_mc[1] = (which_half == 0 ? 0xf1 : 0xa1) - which_quater * 0xa0;
  zmm_mc[2] = 0x7c - which_idx_in_half * 0x8;
  zmm_mc[3] = which_half == 0 ? 0x48 : 0x40;
  zmm_mc[5] = 0xc0 + which_idx_in_quater * 0x9;
}

// write generated code to the specified filename
template <typename T>
void CodeStore<T>::tofile(
    std::string& filename,
    std::tuple<std::shared_ptr<std::vector<unsigned char>>,
               std::shared_ptr<std::vector<index_t>>>
        code_obj,
    index_t n, index_t k, index_t mode) {
  std::shared_ptr<std::vector<unsigned char>> code = std::get<0>(code_obj);
  std::shared_ptr<std::vector<index_t>> pos = std::get<1>(code_obj);

  // insert header file information to code
  pos->insert(pos->begin(), b_matrix_k_block_size);
  pos->insert(pos->begin(), b_matrix_j_block_size);
  pos->insert(pos->begin(), mode);
  pos->insert(pos->begin(), k);
  pos->insert(pos->begin(), n);

  unsigned char* code_data = code->data();
  index_t* pos_data = pos->data();

  size_t pos_data_size = pos->size() * sizeof(index_t);
  unsigned char* pos_data_ = new unsigned char[pos_data_size];
  memcpy(pos_data_, pos_data, pos_data_size);

  std::ofstream csfile;
  csfile.open(filename + ".cs", std::ios::out | std::ios::binary);
  if (!csfile.is_open()) {
    throw std::ios_base::failure(
        "file not found. please check file permissions");
  }
  try {
    csfile.write(reinterpret_cast<char*>(code_data), code->size());
  } catch (std::exception& e) {
    throw std::ios_base::failure("cannot write to file");
  }
  try {
    csfile.close();
  } catch (std::exception& e) {
    throw std::ios_base::failure("error while closing file");
  }

  std::ofstream offile;
  offile.open(filename + ".of", std::ios::out | std::ios::binary);
  if (!offile.is_open()) {
    throw std::ios_base::failure(
        "file not found. please check file permissions");
  }

  try {
    offile.write(reinterpret_cast<char*>(pos_data_), pos_data_size);
  } catch (std::exception& e) {
    throw std::ios_base::failure("cannot write to file");
  }
  try {
    offile.close();
  } catch (std::exception& e) {
    throw std::ios_base::failure("error while closing file");
  }
  delete[] pos_data_;
}

// read generated code from the specified filename
template <typename T>
void CodeStore<T>::fromfile(std::string& filename, index_t n, index_t k,
                            index_t mode) {
  std::string csfile = filename + ".cs";
  int32_t fd = open(csfile.c_str(), O_RDONLY);
  if (fd == -1) {
    throw std::ios_base::failure(
        "file not found. please check file permissions");
  }
  struct stat sb;
  if (fstat(fd, &sb) == -1) {
    throw std::ios_base::failure(
        "file status query failed. cannot read file size");
  }
  size_t csize = sb.st_size;
  const size_t size_of_pages_bytes = get_required_num_pages(csize);
  void* p_addr = static_cast<void*>(
      mmap(0, size_of_pages_bytes, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0));
  if (p_addr == MAP_FAILED) {
    throw std::runtime_error("Cannot dynamically allocated page memory");
  }

  std::string offile_c = filename + ".of";
  fd = open(offile_c.c_str(), O_RDONLY);
  if (fd == -1) {
    throw std::ios_base::failure(
        "file not found. please check file permissions");
  }
  if (fstat(fd, &sb) == -1) {
    throw std::ios_base::failure(
        "file status query failed. cannot read file size");
  }
  size_t file_size = sb.st_size;
  close(fd);
  std::ifstream offile;
  offile.open(filename + ".of", std::ios::in | std::ios::binary);
  if (!offile.is_open()) {
    throw std::ios_base::failure(
        "file not found. please check file permissions");
  }

  unsigned char* offset_bytes = new unsigned char[file_size];
  offile.read(reinterpret_cast<char*>(offset_bytes), file_size);
  offile.close();

  std::shared_ptr<std::vector<index_t>> pos =
      std::make_shared<std::vector<index_t>>(file_size / sizeof(index_t), 0);
  index_t* pos_data = pos->data();
  memcpy(pos_data, offset_bytes, file_size);

  if (n != pos_data[0] || k != pos_data[1] || mode != pos_data[2]) {
    throw std::domain_error(
        "invalid matrix dimensions in code generation detected. please rerun "
        "cperf with correct parameters.");
  }
  this->b_matrix_j_block_size = pos_data[3];
  this->b_matrix_k_block_size = pos_data[4];
  for (int i = 0; i < 5; ++i) {
    pos->erase(pos->begin());
  }

  // configure code store
  this->page_size_bytes_allocated = size_of_pages_bytes;
  this->p_addr = p_addr;
  pos->insert(pos->begin(), static_cast<index_t>(0));
  this->codelet_pos = pos;

  // delete buffers
  delete[] offset_bytes;
}

#endif