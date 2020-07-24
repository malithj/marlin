#ifndef __ENV_H_
#define __ENV_H_

#include <stdlib.h>

template <typename D>
class Env {
 private:
  static Env *env_instance;
  Env();

 public:
  std::string get_log_file();
  int get_min_log_level();
  static Env *get_env();
  ~Env() {}
};

template <typename D>
Env<D> *Env<D>::env_instance = nullptr;

template <typename D>
Env<D>::Env() {
  setenv("CPP_MINIMUM_LOG_LEVEL", "0", 0);
  setenv("CPP_LOG_FILE", "log.log", 1);
}

template <typename D>
Env<D> *Env<D>::get_env() {
  if (Env::env_instance == nullptr) {
    Env::env_instance = new Env();
  }
  return Env::env_instance;
}

template <typename D>
std::string Env<D>::get_log_file() {
  return std::string(getenv("CPP_LOG_FILE"));
}

template <typename D>
int Env<D>::get_min_log_level() {
  return atoi(getenv("CPP_MINIMUM_LOG_LEVEL"));
}

#endif