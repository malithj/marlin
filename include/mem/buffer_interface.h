#include <numeric>
#include <vector>

#include "allocator_interface.h"

template <typename T>
class IBuffer {
 protected:
  size_t _size;

 public:
  IBuffer() : _size(0) {}
  explicit IBuffer(size_t _size) : _size(_size) {}
  virtual ~IBuffer() {}
  virtual void *get_buffer_addr() noexcept = 0;
  virtual const void *raw_data() const = 0;
  virtual void *raw_mutable_data() = 0;
  virtual bool allocate(index_t nbytes) = 0;
  virtual bool allocate(std::vector<size_t> &shape) = 0;
  virtual bool resize(index_t nbytes) = 0;
  virtual void copy(void *src, index_t offset, index_t length) = 0;
  virtual void clear() = 0;
  virtual void clear(index_t size) = 0;
  virtual index_t offset() const { return 0; }
  const T *data() const { return reinterpret_cast<const T *>(raw_data()); }
  T *mutable_data() { return reinterpret_cast<T *>(raw_mutable_data()); }
  size_t size() const { return _size; }
};