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
#ifndef __JITTER_H_
#define __JITTER_H_

#include "../mem/allocator.h"
#include "../mem/buffer.h"
#include "byte_code.h"
#include "code_store.h"
#include "codelet.h"

// Jitter issues code generation directives and retains pointers to the base
// page address and also the total page size. By destroying the Jitter,
// underlying pages are also destroyed.
//
template <typename T>
class Jitter {
 protected:
  std::shared_ptr<IAllocator<unsigned char>> code_alloc;
  std::shared_ptr<IAllocator<index_t>> off_alloc;
  std::shared_ptr<IBuffer<unsigned char>> code_buffer;
  std::shared_ptr<IBuffer<index_t>> offset_buffer;
  std::shared_ptr<CodeStore<T>> store;
  std::shared_ptr<ByteCode> bytecode;
  std::shared_ptr<Codelet> codelet;
  bool is_buffer_owner;
  bool is_store_owner;
  void* p_addr;
  size_t page_size_bytes;
  index_t* offset_data;
  std::string name;
  uint32_t* arr_a_offsets;
  uint32_t* arr_c_offsets;
  uint16_t mask;
  uint16_t pmask;

 public:
  Jitter(std::shared_ptr<IAllocator<unsigned char>> code_alloc,
         std::shared_ptr<IAllocator<index_t>> off_alloc,
         const std::string name = "")
      : code_alloc(code_alloc),
        off_alloc(off_alloc),
        code_buffer(nullptr),
        offset_buffer(nullptr),
        is_buffer_owner(true),
        is_store_owner(true),
        name(name) {}
  Jitter(std::shared_ptr<IBuffer<unsigned char>> code_buffer,
         std::shared_ptr<IBuffer<index_t>> offset_buffer,
         const std::string name = "")
      : code_alloc(code_alloc),
        off_alloc(off_alloc),
        code_buffer(code_buffer),
        offset_buffer(offset_buffer),
        is_buffer_owner(false),
        is_store_owner(true),
        name(name){};
  Jitter(std::shared_ptr<IAllocator<unsigned char>> code_alloc,
         std::shared_ptr<IAllocator<index_t>> off_alloc,
         std::shared_ptr<CodeStore<T>> store, const std::string name = "")
      : code_alloc(code_alloc),
        off_alloc(off_alloc),
        store(store),
        is_buffer_owner(true),
        is_store_owner(false){};
  explicit Jitter()
      : Jitter(GetCPUAllocator<unsigned char>(), GetCPUAllocator<index_t>()){};
  ~Jitter();
  void generate_code(T* matrix, int m, int k, int n);
  void execute(index_t idx);
  void* get_p_addr() { return this->p_addr; }
  index_t* get_offset_data() { return this->offset_data; }
  uint32_t* get_a_offsets() { return this->arr_a_offsets; }
  uint32_t* get_c_offsets() { return this->arr_c_offsets; }
  uint16_t get_mask() { return this->mask; }
  uint16_t get_pmask() { return this->pmask; }
};

template <typename T>
Jitter<T>::~Jitter() {
  // if (this->arr_a_offsets != nullptr) {
  //   delete[] arr_a_offsets;
  // }
  // if (this->arr_c_offsets != nullptr) {
  //   delete[] arr_c_offsets;
  // }
}

template <typename T>
void Jitter<T>::generate_code(T* matrix, int m, int k, int n) {
  if (this->code_buffer == nullptr) {
    this->code_buffer =
        std::make_shared<Buffer<unsigned char>>(this->code_alloc);
  }
  if (this->offset_buffer == nullptr) {
    this->offset_buffer = std::make_shared<Buffer<index_t>>(this->off_alloc);
  }
  if (this->store == nullptr) {
    this->store = std::make_shared<CodeStore<T>>();
  }
  this->code_buffer->clear();
  this->offset_buffer->clear();
  this->bytecode = std::make_shared<ByteCode>(code_buffer, offset_buffer);
  this->codelet = std::make_shared<Codelet>();
  store->generate_b_matrix(matrix, k, n, bytecode);
  store->copy_code_to_execution_space(bytecode, codelet);
  this->p_addr = codelet->get_p_addr();
  this->page_size_bytes = codelet->get_page_size_bytes();
  this->offset_data = this->bytecode->get_offset_buffer()->mutable_data();
  this->mask = 0xffff;
  this->pmask = ~(0xffff << (m & 0xf));
}

template <typename T>
void Jitter<T>::execute(index_t idx) {
  index_t offset = offset_data[idx];
  if (offset >= page_size_bytes) {
    throw std::out_of_range("please check the offset. page size: " +
                            std::to_string(codelet->get_page_size_bytes()) +
                            " requested: " + std::to_string(offset));
  }
  void (*execute_function)();
  try {
    execute_function = reinterpret_cast<void (*)()>(
        static_cast<unsigned char*>(p_addr) + offset);
  } catch (std::exception& e) {
    throw std::runtime_error("cannot reinterpret function pointer");
  }

  try {
    execute_function();
  } catch (std::exception& e) {
    throw std::runtime_error(
        "illegal memory access reported while executing codelet");
  }
}
#endif