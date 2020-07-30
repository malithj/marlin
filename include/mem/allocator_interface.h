#ifndef __MEM_MANAGER_INTERFACE_H__
#define __MEM_MANAGER_INTERFACE_H__

#include <memory>

#include "../types/types.h"

template <typename T>
class IAllocator {
 public:
  virtual void* allocate(size_t) = 0;
  virtual void free(void*) = 0;
  virtual void* resize(void* base_ptr, size_t size) = 0;
};

#endif