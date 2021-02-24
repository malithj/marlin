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
#include <vector>

#include "../log/logging.h"
#include "../mem/memory.h"
#include "../types/types.h"
#include "byte_code.h"
#include "codelet.h"

using namespace Logging::LoggingInternals;

// CodeStore allocates virtual pages and creates Codelet containers that
// relay execution commands to the underlying page.
template <typename T>
class CodeStore {
 private:
  std::unique_ptr<Logger> logger;

 protected:
  std::unique_ptr<std::vector<unsigned char>> sub_codelet_broadcast_b;
  std::unique_ptr<std::vector<unsigned char>> sub_codelet_broadcast_bz;
  // fast execute method uses codelet positions
  std::shared_ptr<std::vector<index_t>> codelet_pos;
  size_t page_size_bytes_allocated = 0;
  void* p_addr = nullptr;
  // set and broadcast B matrix
  void set_broadcast_b_matrix(unsigned char* dest, T* constant_array,
                              size_t size);
  // adapt the code to different ZMM registers
  void replace_zmm_b(unsigned char* sub_codelet, unsigned char reg_zmm);
  void replace_zmm_bz(unsigned char* sub_codelet, unsigned char reg_zmm);
  // adapt the code to different B constant values
  void replace_b(unsigned char* sub_codelet, T* array, unsigned char reg_zmm);

 public:
  CodeStore<T>();
  ~CodeStore<T>();

  size_t get_code_size_broadcast_b_matrix(T* b_matrix, size_t num_elements);
  size_t get_code_size_gemm_b_matrix(T* b_matrix, size_t k, size_t n);
  // generate instructions for B matrix
  void generate_b_matrix(T* b_matrix, size_t k, size_t n,
                         std::shared_ptr<ByteCode> bytecode);
  // store code and offset to file
  void tofile(std::string& filename,
              std::tuple<std::shared_ptr<std::vector<unsigned char>>,
                         std::shared_ptr<std::vector<index_t>>>
                  code_obj,
              index_t n, index_t k, index_t mode);
  // read code and offset from file
  void fromfile(std::string& filename, index_t n, index_t k, index_t mode);
  std::shared_ptr<std::vector<index_t>> get_codelet_pos();
  // Copy the code from the provided vector containing unsigned char bytes to
  // a virtual page obtained by the OS. Set the appropriate permissions
  void copy_code_to_execution_space(std::shared_ptr<ByteCode> input,
                                    std::shared_ptr<Codelet> output);
  // execute the code
  bool execute(T* ptr);
  bool fast_execute(index_t offset);
};

template <typename T>
CodeStore<T>::CodeStore() {
  this->logger = std::make_unique<Logger>(__FILE__);
  // The following inline assembly has been converted in to code. (Except for
  // rsi -> rdi move required to set the memory location of the array to be
  // overwritten). The following codelet loads 1 - 16 floating point numbers to
  // ZMM0 register and stores the values in the register (16 SPs) to memory.
  unsigned char sub_codelet_b[11] = {
      0xb8, 0x00, 0x00, 0x00, 0x41,       // mov     eax, 0x41000000
      0x62, 0xf2, 0x7d, 0x48, 0x7c, 0xc0  // vpbroadcastd zmm0, eax
  };
  unsigned char sub_codelet_bz[6] = {
      0x62, 0xf1, 0x7c, 0x48, 0x57, 0xc0  // vxorps zmm0, zmm0, zmm0
  };
  this->sub_codelet_broadcast_b = std::make_unique<std::vector<unsigned char>>(
      sub_codelet_b, sub_codelet_b + sizeof(sub_codelet_b));
  this->sub_codelet_broadcast_bz = std::make_unique<std::vector<unsigned char>>(
      sub_codelet_bz, sub_codelet_bz + sizeof(sub_codelet_bz));
}

template <typename T>
CodeStore<T>::~CodeStore() {
  munmap(this->p_addr, this->page_size_bytes_allocated);
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
void CodeStore<T>::generate_b_matrix(T* b_matrix, size_t k, size_t n,
                                     std::shared_ptr<ByteCode> bytecode) {
  size_t num_zeros = 0;
  for (index_t i = 0; i < k * n; ++i) {
    if (b_matrix[i] == 0) num_zeros++;
  }

  // full tile bounding limit
  const index_t ftile_j_lim = (n / 15) * 15;
  // partial tile bounding limit
  const index_t ptile_j_remain = n - ftile_j_lim;

  const index_t b_cols = 15;
  const index_t a_cols = 1;
  const index_t total_code_size = get_code_size_gemm_b_matrix(b_matrix, k, n);
  const index_t total_iterations = (ftile_j_lim / 15) * k + k + 1;

  // define a vector to store generated B matrix code until transferred
  // to page memory
  bytecode->get_code_buffer()->resize(total_code_size);
  unsigned char* dest_ptr = bytecode->get_code_buffer()->mutable_data();

  bytecode->get_offset_buffer()->resize(total_iterations);
  index_t* track = bytecode->get_offset_buffer()->mutable_data();

  T* buffer = static_cast<T*>(aligned_alloc(b_cols * a_cols, sizeof(T)));
  index_t tally_code_size = 0;
  index_t idx = 0;
  track[idx++] = 0;
  // generate b matrix code
  for (index_t jj = 0; jj < ftile_j_lim; jj += b_cols) {
    for (index_t kk = 0; kk < k; ++kk) {
      memset(buffer, 0, sizeof(T) * a_cols * b_cols);
      memcpy(buffer, b_matrix + kk * n + jj, b_cols * sizeof(T));
      set_broadcast_b_matrix(dest_ptr + tally_code_size, buffer,
                             b_cols * a_cols);
      tally_code_size +=
          get_code_size_broadcast_b_matrix(buffer, b_cols * a_cols);
      track[idx++] = tally_code_size;
    }
  }

  if (ptile_j_remain) {
    for (index_t kk = 0; kk < k; ++kk) {
      memset(buffer, 0, sizeof(T) * a_cols * b_cols);
      memcpy(buffer, b_matrix + kk * n + ftile_j_lim,
             ptile_j_remain * sizeof(T));
      set_broadcast_b_matrix(dest_ptr + tally_code_size, buffer,
                             ptile_j_remain);
      tally_code_size +=
          get_code_size_broadcast_b_matrix(buffer, ptile_j_remain);
      track[idx++] = tally_code_size;
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
  const size_t sc_size = sub_codelet_broadcast_b->size();
  const size_t sc_z_size = sub_codelet_broadcast_bz->size();

  size_t num_zeros = 0;
  for (index_t i = 0; i < k * n; ++i) {
    if (b_matrix[i] == 0) num_zeros++;
  }

  LOG_DEBUG("sub codelet b size: " + std::to_string(sc_size));
  LOG_DEBUG("sub codelet bz size: " + std::to_string(sc_z_size));
  LOG_DEBUG("number of zeros in B: " + std::to_string(num_zeros));

  const index_t num_full_tiles = n / 15;
  const index_t elems_per_full_tile = 15;
  // full tile & partial tile bounding limit
  const index_t ftile_j_lim = (n / 15) * 15;
  const index_t ptile_j_remain = n - ftile_j_lim;

  const index_t full_tile_code =
      (elems_per_full_tile * sc_size + 1) * num_full_tiles * k;
  const index_t partial_tile_code =
      ptile_j_remain > 0 ? (ptile_j_remain * sc_size + 1) * k : 0;
  const index_t zero_optimized_code = num_zeros * (sc_size - sc_z_size);

  const index_t total_code_size =
      full_tile_code + partial_tile_code - zero_optimized_code;
  return total_code_size;
}

// This is the heart of CodeStore in charge of creating virtual pages and
// generating the hashmap index. If position vector is empty (i.e. the user is
// letting know to treat the code space as one execution block), default key is
// set as (0,0). This key can be used to execute by default.
template <typename T>
void CodeStore<T>::copy_code_to_execution_space(
    std::shared_ptr<ByteCode> input, std::shared_ptr<Codelet> output) {
  const size_t size_of_pages_bytes =
      get_required_num_pages(input->get_code_buffer()->size());

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
  std::memcpy(p_addr, input->get_code_buffer()->raw_data(),
              input->get_code_buffer()->size());

  // change page permissions now data has been copied
  int mresult = mprotect(p_addr, size_of_pages_bytes, PROT_READ | PROT_EXEC);
  if (mresult == -1) {
    throw std::runtime_error("Cannot dynamically allocated page memory");
  }

  output->set_page_meta(p_addr, size_of_pages_bytes);
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
  pos->insert(pos->begin(), 0x1);
  pos->insert(pos->begin(), 0xf);
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