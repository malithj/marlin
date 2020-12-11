CC						= g++
CFLAGS					= -march=skylake-avx512
EXT_TARGET				= ext
EXT_FLAGS				= -Wall -march=skylake-avx512 -DENABLE_JIT -O2 -fPIC -fprefetch-loop-arrays -falign-functions=16 -falign-loops=16 -flto -fuse-linker-plugin -funroll-loops -Wl,--gc-sections -fdata-sections -ffunction-sections -fvisibility=hidden -fopenmp
TEST_FLAGS				= -Wall -march=skylake-avx512 -DENABLE_JIT -O2 -fPIC -fprefetch-loop-arrays -falign-functions=16 -falign-loops=16 -flto -fuse-linker-plugin -funroll-loops -Wl,--gc-sections -fdata-sections -ffunction-sections -fvisibility=hidden -fopenmp
CFLAGS					= -fPIC -g $(TEST_FLAGS)
LIB_FLAGS				= -fPIC -g $(TEST_FLAGS)
PERF_TARGET				= perf_marlin
WIN_PERF_TARGET			= win_perf_marlin
TARGET					= libmarlin
TEST_TARGET				= test
XSMM_TARGET				= xsmm
BUILD_DIR				= build
SRC_DIR					= src
TEST_DIR				= test
IDIR					= include
INCLUDE_DIR				= include
MKDIR_P					= mkdir -p
GOOGLE_TEST				= googletest
RESULT_DIR				= results
EIGEN_INC_DIR			= ${EIGEN_INC}
LIBXSMM_LIB_DIR			= ${LIBXSMM_LIB}
LIBXSMM_INC_DIR			= ${LIBXSMM_INC}
MKL_LIB_DIR				= ${MKL_LIB}
MKL_INC_DIR				= ${MKL_INC}
OPENBLAS_INC_DIR		= ${OPENBLAS_INC}
OPENBLAS_CFG_INC_DIR	= ${OPENBLAS_CFG_INC}
OPENBLAS_LIB_DIR		= ${OPENBLAS_LIB}
ONEDNN_CFG_INC_DIR		= ${ONEDNN_LIB}/../include
ONEDNN_LIB_DIR			= ${ONEDNN_LIB}
ONEDNN_INC_DIR			= ${ONEDNN_INC}
ODIR					= $(BUILD_DIR)/bin
OUT_DIR					= $(ODIR)
VTUNE_LIB_DIR			= ${VTUNE_LIB}
VTUNE_INC_DIR			= ${VTUNE_INC}
LINE_COLOR				= \033[0;33m
CMD_COLOR				= \033[1;32m
RESET_COLOR				= \033[0m
DANGER_COLOR			= \033[1;91m


TEST_DIRS = $(sort $(dir $(wildcard test/*/*)))
SRC_DIRS = $(sort $(dir $(wildcard src/*/*/*)))
PREFIXED_T = $(patsubst %,$(ODIR)/%,$(TEST_DIRS))
PREFIXED_S = $(patsubst %,$(ODIR)/%,$(SRC_DIRS))
MODULES = $(ODIR)/test $(PREFIXED_S) $(PREFIXED_T) $(ODIR)/ext $(ODIR)/perf $(ODIR)/win_perf $(BUILD_DIR)/$(GOOGLE_TEST) $(BUILD_DIR)/$(RESULT_DIR)
OBJ  = $(TARGET).o
ASM_OBJ = $(wildcard src/asm/asm*.s) $(wildcard src/asm/kernels/*.s)
TEST_OBJ = $(wildcard test/*.cc) $(wildcard test/*/*.cc)

EXT_OBJ = benchmark.o main.o
PERF_OBJ = main.o

DEPS = $(IDIR) $(wildcard $(IDIR)/*/*.h) $(wildcard $(IDIR)/*/*/*.h) $(LIBXSMM_INC_DIR) 
INC = -I $(IDIR) -I $(GOOGLE_TEST)/$(GOOGLE_TEST)/include -I $(LIBXSMM_INC_DIR) 
MKL_LINK_ADVISOR=-Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl
EXT_INC = -I $(ONEDNN_INC_DIR) -I ${ONEDNN_CFG_INC_DIR} -I $(MKL_INC_DIR) -I ${EIGEN_INC_DIR} 
LIBS =	-L $(BUILD_DIR)/$(GOOGLE_TEST)/lib -lgtest -lpthread -lm -ldl
EXT_LIBS = -L $(MKL_LIB_DIR) -L $(LIBXSMM_LIB_DIR) -L $(ONEDNN_LIB_DIR) -ldnnl -lxsmm $(MKL_LINK_ADVISOR)

OBJ_WITH_PATH = $(patsubst %,$(ODIR)/%,$(OBJ))
ASM_OBJ_WITH_PATH = $(patsubst %.s,$(ODIR)/%.o,$(ASM_OBJ))
TEST_OBJ_WITH_PATH = $(patsubst %.cc,$(ODIR)/%.o,$(TEST_OBJ))
EXT_OBJ_WITH_PATH = $(patsubst %,$(ODIR)/ext/%,$(EXT_OBJ))
PERF_OBJ_WITH_PATH = $(patsubst %,$(ODIR)/perf/%,$(PERF_OBJ))
WIN_PERF_OBJ_WITH_PATH = $(patsubst %,$(ODIR)/win_perf/%,$(PERF_OBJ))

all: $(OUT_DIR) $(GOOGLE_TEST) $(TARGET)
	@echo -n "${CMD_COLOR}"
	@echo "${LINE_COLOR}Finished building target: $^${RESET_COLOR}" 
	@echo "${RESET_COLOR}"

$(ODIR)/%.o: %.s $(DEPS)
	@echo "${LINE_COLOR}building object: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -c -o $@ $< $(CFLAGS) $(INC)
	@echo "${RESET_COLOR}"

$(ODIR)/%.o: %.cc $(DEPS)
	@echo "${LINE_COLOR}building object: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -c -o $@ $< $(CFLAGS) $(INC) $(EXT_INC)
	@echo "${RESET_COLOR}"

$(GOOGLE_TEST):
	@echo "${LINE_COLOR}Building object file: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	@cd $(BUILD_DIR)/$(GOOGLE_TEST) && cmake ../../$(GOOGLE_TEST) && make
	@echo "${RESET_COLOR}"

$(OUT_DIR):
	@echo "${LINE_COLOR}Creating directory: $(OUR_DIR)${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	${MKDIR_P} ${OUT_DIR}
	${MKDIR_P} ${MODULES}
	@echo "${RESET_COLOR}"

$(TEST_TARGET): $(TEST_OBJ_WITH_PATH) $(ASM_OBJ_WITH_PATH)
	@echo "${LINE_COLOR}building executable: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(TEST_FLAGS) $(LIBS) $(EXT_LIBS)
	@echo "${RESET_COLOR}"

$(EXT_TARGET): $(ASM_OBJ_WITH_PATH) $(EXT_OBJ_WITH_PATH)
	@echo "${LINE_COLOR}building executable: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(CFLAGS) $(LIBS) $(EXT_LIBS)
	@echo "${RESET_COLOR}"

$(PERF_TARGET): $(ASM_OBJ_WITH_PATH) $(PERF_OBJ_WITH_PATH)
	@echo "${LINE_COLOR}building executable: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(CFLAGS) $(LIBS) $(EXT_LIBS)
	@echo "${RESET_COLOR}"

$(WIN_PERF_TARGET): $(ASM_OBJ_WITH_PATH) $(WIN_PERF_OBJ_WITH_PATH)
	@echo "${LINE_COLOR}building executable: $@${RESET_COLOR}"
	@echo -n "${CMD_COLOR}"
	$(CC) -o $(BUILD_DIR)/$@ $^ $(CFLAGS) $(LIBS) $(EXT_LIBS)
	@echo "${RESET_COLOR}"

$(TARGET): $(ASM_OBJ_WITH_PATH)
	@echo "${LINE_COLOR}Building library $@ packaging $^${RESET_COLOR}"	
	@echo -n "${CMD_COLOR}"
	$(CC) -shared -o $(BUILD_DIR)/$@.so $^ $(LIB_FLAGS) -I $(INCLUDE_DIR)

.PHONY: clean googletest

clean:
	@echo -n "${DANGER_COLOR}"
	rm -f $(BUILD_DIR)/*~ $(BUILD_DIR)/$(TARGET) $(BUILD_DIR)/$(TEST_TARGET) $(BUILD_DIR)/$(EXT_TARGET) $(BUILD_DIR)/$(PERF_TARGET)
	find $(ODIR) -type f -name '*.o' -delete
	@echo -n "${RESET_COLOR}"
