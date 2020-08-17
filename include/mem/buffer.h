#ifndef __BUFFER_H__
#define __BUFFER_H__

#include <memory.h>

#include "buffer_interface.h"

template <typename T>
class Buffer : public IBuffer<T> {
 private:
  void* base_ptr;
  // use mapped if the buffer manages data between host
  // and device @TODO:(malith)
  void* mapped_base_ptr;
  std::shared_ptr<IAllocator<T>> allocator;
  bool is_data_owner;

 public:
  // initializes a Buffer and assigns the creator as
  // the Buffer owner.
  Buffer(std::shared_ptr<IAllocator<T>> allocator)
      : IBuffer<T>(0),
        base_ptr(nullptr),
        mapped_base_ptr(nullptr),
        allocator(allocator),
        is_data_owner(true) {}
  // encapsulates existing memory area as a Buffer managed
  // entity. Since memory was not allocated by the buffer,
  // ownership is not awarded.
  Buffer(std::shared_ptr<IAllocator<T>> allocator, void* data, index_t size)
      : IBuffer<T>(size),
        base_ptr(data),
        mapped_base_ptr(nullptr),
        allocator(allocator),
        is_data_owner(false) {}
  // disable copy and move assignment operators
  Buffer& operator=(const Buffer& a) = delete;
  Buffer& operator=(const Buffer&& a) = delete;
  virtual ~Buffer();
  void* get_buffer_addr() noexcept;
  const void* raw_data() const noexcept;
  void* raw_mutable_data() noexcept;
  bool allocate(index_t size);
  bool allocate(std::vector<size_t>& shape);
  bool resize(index_t size);
  void copy(void* src, index_t offset, index_t length);
  void clear();
  void clear(index_t size);
};

template <typename T>
Buffer<T>::~Buffer() {
  if (this->is_data_owner && this->base_ptr != nullptr) {
    this->allocator->free(this->base_ptr);
  }
}

template <typename T>
void* Buffer<T>::get_buffer_addr() noexcept {
  if (this->base_ptr != nullptr) {
    return this->base_ptr;
  } else {
    return nullptr;
  }
}

template <typename T>
const void* Buffer<T>::raw_data() const noexcept {
  if (this->base_ptr != nullptr) {
    return this->base_ptr;
  } else {
    return nullptr;
  }
}

template <typename T>
void* Buffer<T>::raw_mutable_data() noexcept {
  if (this->base_ptr != nullptr) {
    return this->base_ptr;
  } else {
    return nullptr;
  }
}

template <typename T>
bool Buffer<T>::allocate(index_t size) {
  if (!is_data_owner) {
    throw std::runtime_error("non data owner cannot allocate memory");
    if (this->base_ptr == nullptr) {
      this->allocator->allocate(size);
      this->_size = size;
    } else {
      throw std::runtime_error("buffer already allocated");
    }
  }
  return true;
}

template <typename T>
bool Buffer<T>::allocate(std::vector<size_t>& shape) {
  size_t num_bytes = std::accumulate(shape.begin(), shape.end(), 1,
                                     std::multiplies<size_t>()) *
                     sizeof(T);
  this->base_ptr = this->allocator->allocate(num_bytes);
  this->_size = num_bytes;
  return true;
}

template <typename T>
bool Buffer<T>::resize(index_t size) {
  if (!is_data_owner) {
    throw std::runtime_error("non data owner cannot allocate memory");
  }
  if (this->base_ptr == nullptr) {
    this->base_ptr = this->allocator->allocate(size);
    this->_size = size;
  } else {
    this->base_ptr = this->allocator->resize(base_ptr, size);
    this->_size = size;
  }
  return true;
}

template <typename T>
void Buffer<T>::copy(void* src, index_t offset, index_t length) {
  memcpy(static_cast<unsigned char*>(this->raw_mutable_data()) + offset, src,
         length);
}

template <typename T>
void Buffer<T>::clear() {
  this->clear(this->_size);
}

template <typename T>
void Buffer<T>::clear(index_t size) {
  memset(reinterpret_cast<void*>(this->raw_mutable_data()), 0, size);
}

#endif