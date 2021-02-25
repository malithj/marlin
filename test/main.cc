/*******************************************************************************
 * Copyright (c) Malith Jayaweera - All rights reserved.                       *
 * This file is part of the MARLIN library.                                    *
 *                                                                             *
 * For information on the license, see the LICENSE file.                       *
 * Further information: https://github.com/malithj/marlin/                     *
 * SPDX-License-Identifier: BSD-3-Clause                                       *
 ******************************************************************************/
/* Malith Jayaweera
*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>

#include <iostream>
#include <memory>

#include "../include/log/logging.h"
#include "gtest/gtest.h"

int main(int argc, char *argv[]) {
  std::unique_ptr<Logging::LoggingInternals::Logger> logger(
      new Logging::LoggingInternals::Logger(__FILE__));
  // turn off logging
  setenv("CPP_MINIMUM_LOG_LEVEL", "5", 1);
  LOG_INFO("starting the test suite");
  testing::InitGoogleTest(&argc, argv);
#ifndef __AVX512F__
  std::cout << "AVX512F not available on the target architecture" << std::endl;
  return 0;
#endif
  int result = RUN_ALL_TESTS();
  delete Env<void>::get_env();
  return result;
}