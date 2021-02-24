#ifndef __UTILS_H_
#define __UTILS_H_

template <typename Integer>
Integer RoundUp(Integer i, Integer factor) {
  return (i + factor - 1) / factor * factor;
}

#endif