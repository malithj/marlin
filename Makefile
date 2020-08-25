CC=g++
CFLAGS=-march=skylake-avx512
EXT_TARGET=ext
EXT_FLAGS=-Wall -march=skylake-avx512 -DENABLE_JIT -O2 -fPIC -fprefetch-loop-arrays -falign-functions=16 -falign-loops=16 -flto -fuse-linker-plugin -funroll-loops -Wl,--gc-sections -fdata-sections -ffunction-sections -fvisibility=hidden
TEST_FLAGS=-Wall -march=skylake-avx512 -DENABLE_JIT -O2 -fPIC -fprefetch-loop-arrays -falign-functions=16 -falign-loops=16 -flto -fuse-linker-plugin -funroll-loops -Wl,--gc-sections -fdata-sections -ffunction-sections -fvisibility=hidden
LIB_FLAGS=-fPIC -g
PERF_TARGET=perf_marlin
TARGET=main
TEST_TARGET=test
XSMM_TARGET=xsmm
LIB_TARGET=libmarlin
BUILD_DIR=build
SRC_DIR=src
TEST_DIR=test
INCLUDE_DIR=include
MKDIR_P=mkdir -p
GOOGLE_TEST=googletest
RESULT_DIR=results
EIGEN_INC_DIR=${EIGEN_INC}
LIBXSMM_LIB_DIR=${LIBXSMM_LIB}
LIBXSMM_INC_DIR=${LIBXSMM_INC}
MKL_LIB_DIR=${MKL_LIB}
MKL_INC_DIR=${MKL_INC}
OPENBLAS_INC_DIR=${OPENBLAS_INC}
OPENBLAS_CFG_INC_DIR=${OPENBLAS_CFG_INC}
OPENBLAS_LIB_DIR=${OPENBLAS_LIB}
ONEDNN_CFG_INC_DIR=${ONEDNN_LIB}/../include
ONEDNN_LIB_DIR=${ONEDNN_LIB}
ONEDNN_INC_DIR=${ONEDNN_INC}
VTUNE_LIB_DIR=${VTUNE_LIB}
VTUNE_INC_DIR=${VTUNE_INC}
LINE_COLOR=\033[0;33m
CMD_COLOR=\033[1;32m
RESET_COLOR=\033[0m

# object file names
ASM_GEMM_O=asm_gemm.o
ASM_GEMM_F32_J1_O=asm_gemm_f32_j1.o
ASM_GEMM_F32_J2_O=asm_gemm_f32_j2.o
ASM_GEMM_F32_J3_O=asm_gemm_f32_j3.o
ASM_GEMM_F32_J4_O=asm_gemm_f32_j4.o
ASM_GEMM_F32_J5_O=asm_gemm_f32_j5.o
ASM_GEMM_F32_J6_O=asm_gemm_f32_j6.o
ASM_GEMM_F32_J7_O=asm_gemm_f32_j7.o
ASM_GEMM_F32_J8_O=asm_gemm_f32_j8.o
ASM_GEMM_F32_J9_O=asm_gemm_f32_j9.o
ASM_GEMM_F32_J10_O=asm_gemm_f32_j10.o
ASM_GEMM_F32_J11_O=asm_gemm_f32_j11.o
ASM_GEMM_F32_J12_O=asm_gemm_f32_j12.o
ASM_GEMM_F32_J13_O=asm_gemm_f32_j13.o
ASM_GEMM_F32_J14_O=asm_gemm_f32_j14.o
ASM_TRANSPOSE_O=asm_transpose.o
BENCHMARK_O=benchmark.o
EXT_O=ext.o
MAIN_O=main.o
ODIR=$(BUILD_DIR)/bin
PERF_O=perf.o
TEST_O=test.o
TEST_GATHER_O=test_gather.o
TEST_GEMM_O=test_gemm.o
TEST_GEMM_CUSTOM_O=test_gemm_custom.o
TEST_GEMM_F32_O=test_gemm_f32.o
TEST_GEMM_KERNEL_O=test_gemm_kernel.o
TEST_JIT_O=test_jit.o
TEST_JIT_ASM_O=test_jit_asm.o
TEST_JIT_GEMM_O=test_jit_gemm.o
TEST_JIT_KERNEL_O=test_jit_kernel.o
TEST_TRANSPOSE_O=test_transpose.o
TEST_SCATTER_O=test_scatter.o
TEST_XSMM_O=test_xsmm.o
XSMM_O=xsmm.o

# create object files in binary directory
ASM_GEMM=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_O))
ASM_GEMM_F32_J1=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J1_O))
ASM_GEMM_F32_J2=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J2_O))
ASM_GEMM_F32_J3=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J3_O))
ASM_GEMM_F32_J4=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J4_O))
ASM_GEMM_F32_J5=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J5_O))
ASM_GEMM_F32_J6=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J6_O))
ASM_GEMM_F32_J7=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J7_O))
ASM_GEMM_F32_J8=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J8_O))
ASM_GEMM_F32_J9=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J9_O))
ASM_GEMM_F32_J10=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J10_O))
ASM_GEMM_F32_J11=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J11_O))
ASM_GEMM_F32_J12=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J12_O))
ASM_GEMM_F32_J13=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J13_O))
ASM_GEMM_F32_J14=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_F32_J14_O))
ASM_TRANSPOSE=$(patsubst %,$(ODIR)/%,$(ASM_TRANSPOSE_O))
BENCHMARK=$(patsubst %,$(ODIR)/%,$(BENCHMARK_O))
EXT=$(patsubst %,$(ODIR)/%,$(EXT_O))
MAIN=$(patsubst %,$(ODIR)/%,$(MAIN_O))
OUT_DIR=$(ODIR)
PERF=$(patsubst %,$(ODIR)/%,$(PERF_O))
TEST=$(patsubst %,$(ODIR)/%,$(TEST_O))
TEST_GATHER=$(patsubst %,$(ODIR)/%,$(TEST_GATHER_O))
TEST_GEMM=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_O))
TEST_GEMM_CUSTOM=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_CUSTOM_O))
TEST_GEMM_F32=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_F32_O))
TEST_GEMM_KERNEL=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_KERNEL_O))
TEST_JIT=$(patsubst %,$(ODIR)/%,$(TEST_JIT_O))
TEST_JIT_ASM=$(patsubst %,$(ODIR)/%,$(TEST_JIT_ASM_O))
TEST_JIT_KERNEL=$(patsubst %,$(ODIR)/%,$(TEST_JIT_KERNEL_O))
TEST_JIT_GEMM=$(patsubst %,$(ODIR)/%,$(TEST_JIT_GEMM_O))
TEST_TRANSPOSE=$(patsubst %,$(ODIR)/%,$(TEST_TRANSPOSE_O))
TEST_SCATTER=$(patsubst %,$(ODIR)/%,$(TEST_SCATTER_O))
TEST_XSMM=$(patsubst %,$(ODIR)/%,$(TEST_XSMM_O))
XSMM=$(patsubst %,$(ODIR)/%,$(XSMM_O))


all: $(OUT_DIR) $(GOOGLE_TEST) $(TARGET)
	@echo -n "${CMD_COLOR}"
	@echo "${LINE_COLOR}Finished building target: $^${RESET_COLOR}" 
	@echo "${RESET_COLOR}"

$(ASM_GEMM): $(SRC_DIR)/asm/asm_gemm.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J1): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j1.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J2): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j2.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J3): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j3.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J4): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j4.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J5): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j5.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J6): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j6.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J7): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j7.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J8): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j8.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J9): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j9.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J10): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j10.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J11): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j11.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J12): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j12.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J13): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j13.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_GEMM_F32_J14): $(SRC_DIR)/asm/kernels/asm_gemm_f32_j14.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(ASM_TRANSPOSE): $(SRC_DIR)/asm/asm_transpose.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS)
	@echo "${RESET_COLOR}"

$(BENCHMARK): $(TEST_DIR)/ext/benchmark.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(EXT_FLAGS) -I $(INCLUDE_DIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(ONEDNN_INC_DIR) -I ${ONEDNN_CFG_INC_DIR} -I $(MKL_INC_DIR)  -I $(LIBXSMM_INC_DIR) -I ${EIGEN_INC_DIR} 
	@echo "${RESET_COLOR}"

$(EXT): $(TEST_DIR)/ext/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(EXT_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include 
	@echo "${RESET_COLOR}"

$(GOOGLE_TEST):
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	@cd $(BUILD_DIR)/$(GOOGLE_TEST) && cmake ../../$(GOOGLE_TEST) && make
	@echo "${RESET_COLOR}"

$(MAIN): $(SRC_DIR)/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(CFLAGS) -I $(MKL_INC_DIR) -I $(VTUNE_INC_DIR)
	@echo "${RESET_COLOR}"

$(OUT_DIR):
	@echo "${LINE_COLOR}Creating directory: $(OUR_DIR)${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	${MKDIR_P} ${OUT_DIR}
	${MKDIR_P} ${BUILD_DIR}/$(GOOGLE_TEST)
	${MKDIR_P} ${BUILD_DIR}/$(RESULT_DIR)
	@echo "${RESET_COLOR}"

$(PERF): $(TEST_DIR)/perf/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(EXT_FLAGS) -I $(INCLUDE_DIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(ONEDNN_INC_DIR) -I ${ONEDNN_CFG_INC_DIR} -I $(MKL_INC_DIR)  -I $(LIBXSMM_INC_DIR) -I ${EIGEN_INC_DIR} -I ${OPENBLAS_INC} 
	@echo "${RESET_COLOR}"

$(TEST): $(TEST_DIR)/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include 
	@echo "${RESET_COLOR}"

$(TEST_GATHER): $(TEST_DIR)/mat/test_gather.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM): $(TEST_DIR)/gemm/test_gemm.cc $(INCLUDE_DIR)/gemm/gemm.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM_CUSTOM): $(TEST_DIR)/gemm/test_gemm_custom.cc $(INCLUDE_DIR)/gemm/gemm_custom.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM_F32): $(TEST_DIR)/gemm/test_gemm_f32.cc $(INCLUDE_DIR)/gemm/kernels/*.h $(INCLUDE_DIR)/gemm/gemm_f32.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM_KERNEL): $(TEST_DIR)/gemm/test_gemm_kernel.cc $(INCLUDE_DIR)/gemm/kernels/*.h $(INCLUDE_DIR)/gemm/asm_kernels/*.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_JIT): $(TEST_DIR)/jit/test_jit.cc $(INCLUDE_DIR)/jit/jitter.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"


$(TEST_JIT_ASM): $(TEST_DIR)/jit/test_jit_asm.cc $(SRC_DIR)/asm/asm_gemm.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_JIT_KERNEL): $(TEST_DIR)/jit/test_jit_kernel.cc $(SRC_DIR)/asm/kernels/*.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_JIT_GEMM): $(TEST_DIR)/jit/test_jit_gemm.cc $(INCLUDE_DIR)/gemm/gemm_f32.h $(INCLUDE_DIR)/gemm/asm_kernels/*.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_SCATTER): $(TEST_DIR)/mat/test_scatter.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_TRANSPOSE): $(TEST_DIR)/mat/test_transpose.cc $(INCLUDE_DIR)/mat/transpose.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_XSMM): $(TEST_DIR)/xsmm/test_xsmm.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR) -I $(LIBXSMM_INC_DIR)
	@echo "${RESET_COLOR}"

$(XSMM): $(TEST_DIR)/xsmm/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(TEST_FLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

ext: $(EXT) $(BENCHMARK) $(ASM_GEMM) $(ASM_GEMM_F32_J1) $(ASM_GEMM_F32_J2) $(ASM_GEMM_F32_J3) $(ASM_GEMM_F32_J4) $(ASM_GEMM_F32_J5) $(ASM_GEMM_F32_J6) $(ASM_GEMM_F32_J7) $(ASM_GEMM_F32_J8) $(ASM_GEMM_F32_J9) $(ASM_GEMM_F32_J10) $(ASM_GEMM_F32_J11) $(ASM_GEMM_F32_J12) $(ASM_GEMM_F32_J13) $(ASM_GEMM_F32_J14) $(BUILD_DIR)/$(GOOGLE_TEST)/lib/libgtest.a
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(TEST_FLAGS) -DMKL_ILP64 -m64 -I $(INCLUDE_DIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(ONEDNN_INC_DIR) -I ${ONEDNN_CFG_INC_DIR} -L $(ONEDNN_LIB_DIR) -I $(MKL_INC_DIR) -L $(MKL_LIB_DIR) -L $(LIBXSMM_LIB_DIR) -lxsmm -ldnnl -Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl

main: $(MAIN) $(VTUNE_LIB_DIR)/libjitprofiling.a
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^  $(CFLAGS) -I $(INCLUDE_DIR) -I $(MKL_INC_DIR) -I $(VTUNE_INC_DIR) -Wl,--start-group $(MKL_LIB_DIR)/libmkl_intel_ilp64.a  $(MKL_LIB_DIR)/libmkl_sequential.a $(MKL_LIB_DIR)/libmkl_core.a -Wl,--end-group -lpthread -lm -ldl
	@echo "${RESET_COLOR}"
	@echo "${LINE_COLOR}BUILD SUCCESSFUL${RESET_COLOR}"

perf_marlin: $(PERF) $(ASM_GEMM) $(ASM_GEMM_F32_J1) $(ASM_GEMM_F32_J2) $(ASM_GEMM_F32_J3) $(ASM_GEMM_F32_J4) $(ASM_GEMM_F32_J5) $(ASM_GEMM_F32_J6) $(ASM_GEMM_F32_J7) $(ASM_GEMM_F32_J8) $(ASM_GEMM_F32_J9) $(ASM_GEMM_F32_J10) $(ASM_GEMM_F32_J11) $(ASM_GEMM_F32_J12) $(ASM_GEMM_F32_J13) $(ASM_GEMM_F32_J14)
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(TEST_FLAGS) -DMKL_ILP64 -m64 -I $(INCLUDE_DIR) -I $(ONEDNN_INC_DIR) -I ${ONEDNN_CFG_INC_DIR} -L $(ONEDNN_LIB_DIR) -I $(MKL_INC_DIR) -L $(MKL_LIB_DIR) -L $(LIBXSMM_LIB_DIR) -L $(OPENBLAS_LIB_DIR) -lopenblas -lxsmm -ldnnl -Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl

test: $(TEST) $(TEST_GEMM_KERNEL) $(TEST_GEMM_F32) $(TEST_JIT) $(TEST_JIT_ASM) $(TEST_JIT_GEMM) $(TEST_JIT_KERNEL) $(TEST_GATHER) $(TEST_SCATTER) $(TEST_TRANSPOSE) $(ASM_GEMM) $(ASM_GEMM_F32_J1) $(ASM_GEMM_F32_J2) $(ASM_GEMM_F32_J3) $(ASM_GEMM_F32_J4) $(ASM_GEMM_F32_J5) $(ASM_GEMM_F32_J6) $(ASM_GEMM_F32_J7) $(ASM_GEMM_F32_J8) $(ASM_GEMM_F32_J9) $(ASM_GEMM_F32_J10) $(ASM_GEMM_F32_J11) $(ASM_GEMM_F32_J12) $(ASM_GEMM_F32_J13) $(ASM_GEMM_F32_J14) $(ASM_TRANSPOSE) $(TEST_GEMM) $(TEST_GEMM_CUSTOM) $(BUILD_DIR)/$(GOOGLE_TEST)/lib/libgtest.a
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(TEST_FLAGS) -I $(INCLUDE_DIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -lpthread 

xsmm: $(XSMM) $(TEST_XSMM) $(BUILD_DIR)/$(GOOGLE_TEST)/lib/libgtest.a
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(TEST_FLAGS) -I $(INCLUDE_DIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(MKL_INC_DIR) -L $(MKL_LIB_DIR) -L $(LIBXSMM_LIB_DIR) -L $(OPENBLAS_LIB_DIR) -lopenblas -lxsmm -Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl

libmarlin: $(ASM_GEMM) $(ASM_GEMM_F32_J1) $(ASM_GEMM_F32_J2) $(ASM_GEMM_F32_J3) $(ASM_GEMM_F32_J4) $(ASM_GEMM_F32_J5) $(ASM_GEMM_F32_J6) $(ASM_GEMM_F32_J7) $(ASM_GEMM_F32_J8) $(ASM_GEMM_F32_J9) $(ASM_GEMM_F32_J10) $(ASM_GEMM_F32_J11) $(ASM_GEMM_F32_J12) $(ASM_GEMM_F32_J13) $(ASM_GEMM_F32_J14) $(ASM_TRANSPOSE)
	@echo "${LINE_COLOR}Building library $@ packaging $^${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -shared -o $(BUILD_DIR)/$@.so $^ $(LIB_FLAGS) -I $(INCLUDE_DIR)

.PHONY: clean googletest

clean:
	@echo -n "${CMD_COLOR}"
	rm -f $(ODIR)/*.o $(BUILD_DIR)/*~ $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/$(TEST_TARGET) $(BUILD_DIR)/$(EXT_TARGET) $(BUILD_DIR)/$(PERF_TARGET) $(BUILD_DIR)/$(LIB_TARGET)
	@echo -n "${RESET_COLOR}"
