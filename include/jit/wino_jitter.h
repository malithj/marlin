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
#ifndef __WINO_JITTER_H_
#define __WINO_JITTER_H_

#include "jitter.h"
#include "wino_store.h"

// Jitter issues code generation directives and retains pointers to the base
// page address and also the total page size. By destroying the Jitter,
// underlying pages are also destroyed.
//
template <typename T>
class WinoJitter : public Jitter<T> {
 private:
  std::shared_ptr<WinoStore<T>> store;

 public:
  void generate_code(const T* tensor, const index_t in_tile_area,
                     const index_t input_channels,
                     const index_t output_channels);
};

template <typename T>
void WinoJitter<T>::generate_code(const T* tensor, const index_t in_tile_area,
                                  const index_t input_channels,
                                  const index_t output_channels) {
  if (this->code_buffer == nullptr) {
    this->code_buffer =
        std::make_shared<Buffer<unsigned char>>(this->code_alloc);
  }
  if (this->offset_buffer == nullptr) {
    this->offset_buffer = std::make_shared<Buffer<index_t>>(this->off_alloc);
  }
  if (this->store == nullptr) {
    this->store = std::make_shared<WinoStore<T>>();
  }
  this->code_buffer->clear();
  this->offset_buffer->clear();
  this->bytecode =
      std::make_shared<ByteCode>(this->code_buffer, this->offset_buffer);
  this->codelet = std::make_shared<Codelet>();
  this->store->generate_b_tensor(tensor, in_tile_area, input_channels,
                                 output_channels, this->bytecode);
  this->store->copy_code_to_execution_space(this->bytecode, this->codelet);
  this->p_addr = this->codelet->get_p_addr();
  this->page_size_bytes = this->codelet->get_page_size_bytes();
  this->offset_data = this->bytecode->get_offset_buffer()->mutable_data();
}
#endif