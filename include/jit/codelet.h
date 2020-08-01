#ifndef __CODELET_H_
#define __CODELET_H_

#include <sys/mman.h>

#include "../types/types.h"
class Codelet {
 private:
  void* p_addr;
  index_t page_size_bytes_allocated;

 public:
  explicit Codelet() = default;
  ~Codelet();
  // disable copy and move assignment operators
  Codelet& operator=(const Codelet& a) = delete;
  Codelet& operator=(const Codelet&& a) = delete;
  Codelet(void* p_addr, index_t page_size_bytes_allocated)
      : p_addr(p_addr), page_size_bytes_allocated(page_size_bytes_allocated){};
  void set_page_meta(void* p_addr, index_t page_size_bytes_allocated);
  void* get_p_addr() { return p_addr; }
  index_t get_page_size_bytes() { return page_size_bytes_allocated; }
};

inline Codelet::~Codelet() {
  munmap(this->p_addr, this->page_size_bytes_allocated);
}

inline void Codelet::set_page_meta(void* p_addr,
                                   index_t page_size_bytes_allocated) {
  this->p_addr = p_addr;
  this->page_size_bytes_allocated = page_size_bytes_allocated;
}

#endif