#ifndef __WINO_STORE_H__
#define __WINO_STORE_H__

#include "../log/logging.h"
#include "../mem/memory.h"
#include "../types/types.h"

using namespace Logging::LoggingInternals;

// CodeStore allocates virtual pages and creates Codelet containers that
// relay execution commands to the underlying page.
template <typename T>
class WinoStore {
 public:
  WinoStore<T>();
  ~WinoStore<T>() = default;

 private:
};

template <typename T>
WinoStore<T>::WinoStore() {}
#endif