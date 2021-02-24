#include <stdio.h>
#include <stdlib.h>

#include <memory>

#include "gtest/gtest.h"
#include "log/logging.h"

int main(int argc, char *argv[]) {
  std::unique_ptr<Logging::LoggingInternals::Logger> logger(
      new Logging::LoggingInternals::Logger(__FILE__));
  // turn off logging
  setenv("CPP_MINIMUM_LOG_LEVEL", "5", 1);
  LOG_INFO("starting the external test suite");
  testing::InitGoogleTest(&argc, argv);
  int result = RUN_ALL_TESTS();
  delete Env<void>::get_env();
  return result;
}