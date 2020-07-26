#	Assemble revision 001 of GEMM
#	15:38 JULY 25, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE GEMM USING TILING SIZE
# 15 B COLS AND 1 A COLS.
#
# CALLING SEQUENCE IS AS FOLLOWS:
#		RDI : MATRIX A PTR
#       RSI : MATRIX B PTR
#       RDX : MATRIX C PTR
#       RCX : MATRIX A_T PTR
#       R8  : MATRIX C_T PTR
#       R9  : M
# 0x10(EBP) : N
# 0x18(EBP) : K
#	
# FUNCTION DEFINITION TO BE DECLARED IS AS FOLLOWS:
#       extern "C" float asm_gemm(float *A, float *B, float *C, float *A_T,
#                                 float *C_T index_t m, index_t n, index_t k);
#                        
#

.global asm_gemm
    .text
asm_gemm:
    # FUNCTION PRELOG BEGINS HERE
    pushq %rbp              
    movq %rsp, %rbp
    # FUNC START
    # movq (%rdi), %rax              # A
    # movq (%rsi), %rax              # B
    # movq (%rdx), %rax              # C
    # movq (%rcx), %rax              # A_T
    # movq (%r8), %rax               # C_T
    # movq %r9, %rax                  # M
    # movq 0x10(%rbp), %rax           # N
    # movq 0x18(%rbp), %rax           # K
    # ALLOCATE STACK SPACE
    # subq $64, %rsp
    # MOVE TO TEMP REGISTERS
    movq %rdi, %r10
    movq %rsi, %r11
    # START MAT TRANSPOSE
    xorl %eax, %eax                 # i
.LPTPOSE_OUTER:
    cmpl %r9d, %eax                 # i < M
    jnb .EXITMAIN
    xorl %ebx, %ebx                 # j
.LPTPOSE_INNER:
    cmpl 0x18(%rbp), %ebx           # j < K
    jnb .LPTPOSE_INNER_END
    # INDEX COMPUTATION
    movl %eax, %edi
    movl %ebx, %esi  
    imul 0x18(%rbp), %edi           # i * k 
    imul %r9d, %esi                 # j * m 
    addl %ebx, %edi                 # i * k + j
    addl %eax, %esi                 # j * m + i
    leaq (%r10, %rdi, 0x4), %rdi    # 4 BYTE ALIGNED
    movq (%rdi), %rdi                
    leaq (%rcx, %rsi, 0x4), %rsi    # 4 BYTE ALIGNED
    # STORE
    movq %rdi, (%rsi)
    addl $1, %ebx
    jmp .LPTPOSE_INNER
.LPTPOSE_INNER_END:
    addl $1, %eax
    jmp .LPTPOSE_OUTER
.EXITMAIN:
    # DEALLOCATE STACK SPACE
    # addq $64, %rsp
    # FUNCTION EPILOG BEGINS HERE
    movq %rbp, %rsp        
    pop %rbp
    # movss (%rdi), %xmm0     # RETURN VALUE
    ret

