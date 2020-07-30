#ifndef __MEMORY_H_
#define __MEMORY_H_

#include <unistd.h>

#include <memory>

#include "../constants/constants.h"

// Allocates memory in an aligned fashion
// API is compatible with calloc and returns
// the aligned memory address location
inline void *aligned_alloc(size_t num, size_t size) {
  size_t offset = ALIGN_BYTE_SIZE - 1 + size;
  size_t total_size = num * size + offset;
  void *src = (void *)malloc(total_size);
  void **dest = (void **)(((size_t)src + offset) & ~(ALIGN_BYTE_SIZE - 1));
  dest[-1] = src;
  return dest;
}

// If Aligned allocation is used for memory
// allocation, aligned free should be used to free up
// the memory
inline void aligned_free(void *ptr) {
  void *p = ((void **)ptr)[-1];
  free(p);
}

// Returns the number of pages required to allocate
// the code in to execution memory
inline size_t get_required_num_pages(size_t code_size_in_bytes) {
  const size_t page_size = sysconf(_SC_PAGE_SIZE);
  return (code_size_in_bytes + page_size - 1) & ~(page_size - 1);
}
#endif