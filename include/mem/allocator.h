#ifndef __MEM_MANAGER_H__
#define __MEM_MANAGER_H__

#include <iostream>
#include <vector>

#include "allocator_interface.h"
#include "log/logging.h"

template <typename T>
class Allocator : public IAllocator<T> {
 private:
  // Allocator does not retain state
  index_t ALIGN_SIZE = 64;
  std::shared_ptr<Logging::LoggingInternals::Logger> Logger;

 public:
  Allocator();
  ~Allocator() = default;
  // disable copy constructor, copy assignment and move assigment
  Allocator(const Allocator& a) = delete;
  Allocator& operator=(const Allocator& a) = delete;
  Allocator& operator=(const Allocator&& a) = delete;
  // allocates aligned memory when specified the number of bytes required
  // more bytes will be required to align the memory. Original pointer is stored
  // one location before the removed pointer. Therefore, free should only be
  // carried out by the Allocator::free(void*)
  void* allocate(size_t size);
  // expands the given space according to the number of bytes required by the
  // user. Aligned memory requirement is handled by the realloc method and
  // free should only be carried out by Allocator::free(void*)
  void* resize(void* base_ptr, size_t size);
  void free(void* addr);
  void* map(void* base_ptr, size_t offset, size_t bytes);
};

template <typename T>
Allocator<T>::Allocator() {
  this->Logger = std::make_unique<Logging::LoggingInternals::Logger>();
}

template <typename T>
void* Allocator<T>::allocate(size_t size) {
  index_t offset = ALIGN_SIZE - 1 + sizeof(void*);
  index_t total_size = size * sizeof(T) + offset;
  void* ptr;
  try {
    ptr = std::malloc(total_size);
  } catch (std::exception& e) {
    throw std::bad_alloc();
  }
  void** aligned_ptr = reinterpret_cast<void**>(
      (reinterpret_cast<size_t>(ptr) + offset) & ~(ALIGN_SIZE - 1));
  aligned_ptr[-1] = ptr;
  return reinterpret_cast<void*>(aligned_ptr);
}

template <typename T>
void Allocator<T>::free(void* addr) {
  std::free(reinterpret_cast<void**>(addr)[-1]);
}

template <typename T>
void* Allocator<T>::resize(void* base_ptr, size_t size) {
  index_t offset = ALIGN_SIZE - 1 + sizeof(void*);
  index_t total_size = size * sizeof(T) + offset;
  void* original_ptr = reinterpret_cast<void**>(base_ptr)[-1];
  void* ptr = std::realloc(original_ptr, total_size);
  if (ptr == nullptr) {
    return reinterpret_cast<void*>(base_ptr);
  }
  void** aligned_ptr = reinterpret_cast<void**>(
      (reinterpret_cast<size_t>(ptr) + offset) & ~(ALIGN_SIZE - 1));
  aligned_ptr[-1] = ptr;
  return reinterpret_cast<T*>(aligned_ptr);
}

template <typename T>
void* Allocator<T>::map(void* base_ptr, size_t offset, size_t bytes) {
  return reinterpret_cast<void*>(static_cast<unsigned char*>(base_ptr) +
                                 offset);
}

template <typename T>
std::shared_ptr<IAllocator<T>> GetCPUAllocator() {
  static std::shared_ptr<Allocator<T>> allocator =
      std::make_shared<Allocator<T>>();
  return allocator;
}

#endif