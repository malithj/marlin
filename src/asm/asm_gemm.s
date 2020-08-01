#	Assemble revision 001 of GEMM
#	21:39 JULY 31, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE GEMM USING TILING SIZE
# 15 B COLS AND 1 A COLS.
#
# CALLING SEQUENCE IS AS FOLLOWS:
#		RDI : K
#       RSI : MATRIX A PTR
#       RDX : MATRIX C PTR
#       RCX : BASE PAGE ADDRESS
#       R8  : PAGE OFFSET DATA
#       R9  : MATRIX A GATHER INDICES
# 0x10(EBP) : MATRIX C GATHER INDICES
# 0x18(EBP) : MASK
# 0x20(EBP) : B MATRIX IDX (CODE GEN INVOKER IDX)
#
# FUNCTION DEFINITION TO BE DECLARED IS AS FOLLOWS:
#       extern "C" float asm_gemm(index_t k, float* a, float* c, void* p_addr,
#                                 index_t* offset_data, uint32_t* arr_a,
#                                 uint32_t* arr_c, uint16_t mask, index_t idx);
#                        
#

.global asm_gemm
    .text
asm_gemm:
    # FUNCTION PRELOG BEGINS HERE
    pushq %rbp              
    movq %rsp, %rbp
    # ALLOCATE STACK SPACE
    subq $64, %rsp                           # [STACK ALLOCATE 64 BYTES]
    # FUNCTION BODY
    vxorps %zmm0, %zmm0, %zmm0               # SET SRC REGISTER TO ZERO
    movq 0x10(%rbp), %r10                    # GATHER INDICES
    vmovdqu32 (%r10), %zmm1                  # LD C MATRIX INDICES [DSTRYBL:r10]
    movq %rdx, %r10                          # [SAVE C MATRIX PTR TO r10]

    vmovaps %zmm0, %zmm2                     # COPY SRC REGISTER TO FUTURE C0 
    movzwl 0x18(%rbp), %r11d                 # LD MASK FROM STACK  [SCRBL: r11]
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm2{%k1}  # LOAD C0 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm3                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm3{%k1}  # LOAD C1 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm4                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm4{%k1}  # LOAD C2 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm5                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm5{%k1}  # LOAD C3 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm6                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm6{%k1}  # LOAD C4 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm7                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm7{%k1}  # LOAD C5 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm8                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm8{%k1}  # LOAD C6 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm9                     # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm9{%k1}  # LOAD C7 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm10                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm10{%k1} # LOAD C8 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm11                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm11{%k1} # LOAD C9 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm12                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm12{%k1} # LOAD C10 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm13                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm13{%k1} # LOAD C11 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm14                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm14{%k1} # LOAD C12 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm15                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm15{%k1} # LOAD C13 COL TO REGISTER
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    vmovaps %zmm0, %zmm16                    # COPY SRC REGISTER TO FUTURE C0 
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rdx, %zmm1, 4), %zmm16{%k1} # LOAD C14 COL TO REGISTER
    vmovups %zmm16, (%rdx)                   # TEST LINE: REMOVE (STORE C)

    vmovdqu32 (%r9), %zmm1                   # LD A MATRIX INDICES

    # FUNCTION BODY ENDS
    # DEALLOCATE STACK SPACE
    addq $64, %rsp
    # FUNCTION EPILOG BEGINS HERE
    movq %rbp, %rsp        
    pop %rbp
    ret
