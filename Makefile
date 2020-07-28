CC=g++
CFLAGS=-march=skylake-avx512 -g
TEST_FLAGS=-Wall -ftest-coverage -fprofile-arcs -march=skylake-avx512 -g
TARGET=main
TEST_TARGET=test
BUILD_DIR=build
SRC_DIR=src
TEST_DIR=test
INCLUDE_DIR=include
MKDIR_P=mkdir -p
GOOGLE_TEST=googletest
RESULT_DIR=results
MKL_LIB_DIR=${MKL_LIB}
MKL_INC_DIR=${MKL_INC}
VTUNE_LIB_DIR=${VTUNE_LIB}
VTUNE_INC_DIR=${VTUNE_INC}
LINE_COLOR=\033[0;33m
CMD_COLOR=\033[1;32m
RESET_COLOR=\033[0m

# object file names
ODIR=$(BUILD_DIR)/bin
MAIN_O=main.o
ASM_GEMM_O=asm_gemm.o
TEST_O=test.o
TEST_GEMM_CUSTOM_O=test_gemm_custom.o
TEST_GEMM_F32_O=test_gemm_f32.o
TEST_GEMM_KERNEL_O=test_gemm_kernel.o
TEST_GEMM_O=test_gemm.o
TEST_TRANSPOSE_O=test_transpose.o
TEST_GATHER_O=test_gather.o
TEST_SCATTER_O=test_scatter.o

# create object files in binary directory
MAIN=$(patsubst %,$(ODIR)/%,$(MAIN_O))
ASM_GEMM=$(patsubst %,$(ODIR)/%,$(ASM_GEMM_O))
TEST=$(patsubst %,$(ODIR)/%,$(TEST_O))
TEST_GEMM_CUSTOM=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_CUSTOM_O))
TEST_GEMM_F32=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_F32_O))
TEST_GEMM_KERNEL=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_KERNEL_O))
TEST_GEMM=$(patsubst %,$(ODIR)/%,$(TEST_GEMM_O))
TEST_TRANSPOSE=$(patsubst %,$(ODIR)/%,$(TEST_TRANSPOSE_O))
TEST_GATHER=$(patsubst %,$(ODIR)/%,$(TEST_GATHER_O))
TEST_SCATTER=$(patsubst %,$(ODIR)/%,$(TEST_SCATTER_O))
OUT_DIR=$(ODIR)

all: $(OUT_DIR) $(GOOGLE_TEST) $(TARGET)
	@echo -n "${CMD_COLOR}"
	@echo "${LINE_COLOR}Finished building target: $^${RESET_COLOR}" 
	@echo "${RESET_COLOR}"

$(OUT_DIR):
	@echo "${LINE_COLOR}Creating directory: $(OUR_DIR)${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	${MKDIR_P} ${OUT_DIR}
	${MKDIR_P} ${BUILD_DIR}/$(GOOGLE_TEST)
	${MKDIR_P} ${BUILD_DIR}/$(RESULT_DIR)
	@echo "${RESET_COLOR}"

$(GOOGLE_TEST):
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	@cd $(BUILD_DIR)/$(GOOGLE_TEST) && cmake ../../$(GOOGLE_TEST) && make
	@echo "${RESET_COLOR}"

$(ASM_GEMM): $(SRC_DIR)/asm/gemm.s
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^
	@echo "${RESET_COLOR}"

$(MAIN): $(SRC_DIR)/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(CFLAGS) -I $(MKL_INC_DIR) -I $(VTUNE_INC_DIR)
	@echo "${RESET_COLOR}"

$(TEST): $(TEST_DIR)/main.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $^ $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include 
	@echo "${RESET_COLOR}"

$(TEST_GEMM_CUSTOM): $(TEST_DIR)/gemm/test_gemm_custom.cc $(INCLUDE_DIR)/gemm/gemm_custom.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM_F32): $(TEST_DIR)/gemm/test_gemm_f32.cc $(INCLUDE_DIR)/gemm/kernels/*.h $(INCLUDE_DIR)/gemm/gemm_f32.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM_KERNEL): $(TEST_DIR)/gemm/test_gemm_kernel.cc $(INCLUDE_DIR)/gemm/kernels/*.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GEMM): $(TEST_DIR)/gemm/test_gemm.cc $(INCLUDE_DIR)/gemm/gemm.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_TRANSPOSE): $(TEST_DIR)/mat/test_transpose.cc $(INCLUDE_DIR)/mat/transpose.h
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_GATHER): $(TEST_DIR)/mat/test_gather.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

$(TEST_SCATTER): $(TEST_DIR)/mat/test_scatter.cc
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -o $@ -c $< $(CFLAGS) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(INCLUDE_DIR)
	@echo "${RESET_COLOR}"

main: $(MAIN) $(VTUNE_LIB_DIR)/libjitprofiling.a
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^  $(CFLAGS) -I $(INCLUDE_DIR) -I $(MKL_INC_DIR) -I $(VTUNE_INC_DIR) -Wl,--start-group $(MKL_LIB_DIR)/libmkl_intel_ilp64.a  $(MKL_LIB_DIR)/libmkl_sequential.a $(MKL_LIB_DIR)/libmkl_core.a -Wl,--end-group -lpthread -lm -ldl
	@echo "${RESET_COLOR}"
	@echo "${LINE_COLOR}BUILD SUCCESSFUL${RESET_COLOR}"

test: $(TEST) $(TEST_GEMM_KERNEL) $(TEST_GEMM_F32) $(TEST_GATHER) $(TEST_SCATTER) $(TEST_TRANSPOSE) $(ASM_GEMM) $(TEST_GEMM) $(TEST_GEMM_CUSTOM) $(BUILD_DIR)/$(GOOGLE_TEST)/lib/libgtest.a
	@echo "${LINE_COLOR}Linking object file $@ with $^${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(CFLAGS) -I $(INCLUDE_DIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -lpthread 

.PHONY: clean googletest

clean:
	@echo -n "${CMD_COLOR}"
	rm -f $(ODIR)/*.o $(BUILD_DIR)/*~ $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/$(TEST_TARGET)
	@echo -n "${RESET_COLOR}"
