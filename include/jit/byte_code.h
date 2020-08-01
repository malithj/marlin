#ifndef __BYTE_CODE_H_
#define __BYTE_CODE_H_

#include "../mem/buffer.h"

class ByteCode {
 private:
  std::shared_ptr<IBuffer<unsigned char>> code_buffer;
  std::shared_ptr<IBuffer<index_t>> offset_buffer;

 public:
  ByteCode(std::shared_ptr<IBuffer<unsigned char>> code_buffer,
           std::shared_ptr<IBuffer<index_t>> offset_buffer)
      : code_buffer(code_buffer), offset_buffer(offset_buffer){};
  ~ByteCode() = default;
  void set_code(std::shared_ptr<IBuffer<unsigned char>> code_buffer);
  void set_offset(std::shared_ptr<IBuffer<index_t>> offset_buffer);
  std::shared_ptr<IBuffer<unsigned char>> get_code_buffer();
  std::shared_ptr<IBuffer<index_t>> get_offset_buffer();
};

inline void ByteCode::set_code(
    std::shared_ptr<IBuffer<unsigned char>> code_buffer) {
  this->code_buffer = code_buffer;
}

inline void ByteCode::set_offset(
    std::shared_ptr<IBuffer<index_t>> offset_buffer) {
  this->offset_buffer = offset_buffer;
}

inline std::shared_ptr<IBuffer<unsigned char>> ByteCode::get_code_buffer() {
  return this->code_buffer;
}

inline std::shared_ptr<IBuffer<index_t>> ByteCode::get_offset_buffer() {
  return this->offset_buffer;
}

#endif