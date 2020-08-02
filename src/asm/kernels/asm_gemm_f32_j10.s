#	Assemble revision 001 of GEMM
#	15:40 AUGUST 02, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE GEMM USING TILING SIZE
# 10 B COLS AND 1 A COLS.
#
# CALLING SEQUENCE IS AS FOLLOWS:
#       RDI : K
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
#       extern "C" index_t asm_gemm_f32_j10(index_t k, float* a, float* c,
#                                           void* p_addr, index_t* offset_data, 
#                                           uint32_t* arr_a, uint32_t* arr_c, 
#                                           uint16_t mask, index_t idx)
#                        
#

.global asm_gemm_f32_j10
    .text
asm_gemm_f32_j10:
    # FUNCTION PRELOG BEGINS HERE
    pushq %rbp              
    movq %rsp, %rbp
    # ALLOCATE STACK SPACE
    subq $0x28, %rsp                         # [STACK ALLOCATE 32 BYTES]
    # FUNCTION BODY
    vxorps %zmm0, %zmm0, %zmm0               # SET SRC REGISTER TO ZERO
    movq 0x10(%rbp), %r10                    # GATHER INDICES
    vmovdqu32 (%r10), %zmm1                  # LD C MATRIX INDICES [DSTRYBL:r10]
    movq %rdx, -0x8(%rbp)                    # [SAVE C MATRIX PTR TO STACK]
    movq %r12, -0x10(%rbp)                   # [SAVE R12 REG TO STACK]
    movq %r13, -0x18(%rbp)                   # [SAVE R13 REG TO STACK]
    movq %r14, -0x20(%rbp)                   # [SAVE R14 REG TO STACK]

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

    vmovdqu32 (%r9), %zmm1                   # LD A MATRIX INDICES
    # START MATRIX MULTIPLICATION
    xorl %eax, %eax                          # INDEX i
    movq 0x20(%rbp), %r10                    # ID
.LOOPBEGIN:
    # LOOP INIT
    cmpl %edi, %eax                          # TEST i < k
    jnb .LOOPEXIT
    # LOOP INIT END
    kmovw  %r11d, %k1                        # SET MASK
    vgatherdps (%rsi, %zmm1, 4), %zmm0{%k1}  # LOAD A COL TO REGISTER
                                             # SET MATRIX B
    movl %eax, %r14d                         # CALLER SAVE
    lea (%r8, %r10, 0x8), %r12               # OFFSET
    movq (%r12), %r12
    movq %rcx, %r13                          # MOV BASE PAGE ADDRESS
    addq %r12, %r13                          # CALLABLE ADDRESS
    callq *%r13                              # CALL FUNCTION TO SET MAT B
    movl %r14d, %eax                         # CALLER RESTORE
    # MATMUL
    vfmadd231ps %zmm0, %zmm31, %zmm2         # z2 += z0 * z31
    vfmadd231ps %zmm0, %zmm30, %zmm3         # z3 += z0 * z30
    vfmadd231ps %zmm0, %zmm29, %zmm4         # z4 += z0 * z29
    vfmadd231ps %zmm0, %zmm28, %zmm5         # z5 += z0 * z28
    vfmadd231ps %zmm0, %zmm27, %zmm6         # z6 += z0 * z27
    vfmadd231ps %zmm0, %zmm26, %zmm7         # z7 += z0 * z26
    vfmadd231ps %zmm0, %zmm25, %zmm8         # z8 += z0 * z25
    vfmadd231ps %zmm0, %zmm24, %zmm9         # z9 += z0 * z24
    vfmadd231ps %zmm0, %zmm23, %zmm10        # z10 += z0 * z23
    vfmadd231ps %zmm0, %zmm22, %zmm11        # z11 += z0 * z22
    # LOOP CLEANUP
    lea 0x4(%rsi), %rsi                      # INCREMENT A MATRIX PTR
    addl $1, %eax                            # i = i + 1
    addl $1, %r10d                           # ID = ID + 1
    jmp .LOOPBEGIN
    # LOOP CLEANUP END
.LOOPEXIT:
    vxorps %zmm0, %zmm0, %zmm0               # SET SRC REGISTER TO ZERO
    movq -0x8(%rbp), %rdx                    # [RESTORE C MATRIX PTR TO STACK]
    # vmovups %zmm2, (%rdx)                    # TEST LINE: REMOVE (STORE C)
    movq 0x10(%rbp), %r10                    # GATHER INDICES
    vmovdqu32 (%r10), %zmm1                  # LD C MATRIX INDICES [DSTRYBL:r10]
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm2, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm3, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm4, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm5, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm6, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm7, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm8, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm9, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm10, (%rdx, %zmm1, 0x4){%k1} 
    lea 0x4(%rdx), %rdx                      # INCREMENT C MATRIX PTR
    kmovw  %r11d, %k1                        # SET MASK
    vscatterdps %zmm11, (%rdx, %zmm1, 0x4){%k1} 
    movq $0x1, %rax                          # SET RETURN VALUE
    # FUNCTION BODY ENDS
    # DEALLOCATE STACK SPACE
    movq  -0x10(%rbp), %r12                  # [SAVE R12 REG FROM STACK]
    movq  -0x18(%rbp), %r13                  # [SAVE R13 REG FROM STACK]
    movq  -0x20(%rbp), %r14                  # [SAVE R14 REG FROM STACK]
    addq $0x28, %rsp
    # FUNCTION EPILOG BEGINS HERE
    movq %rbp, %rsp        
    pop %rbp
    ret
