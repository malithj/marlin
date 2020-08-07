#	Assemble revision 001 of GEMM
#	15:38 JULY 25, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE MAT TRANSPOSE
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
#       extern "C" float asm_transpose(float *A, float *B, float *C, float *A_T,
#                                      float *C_T index_t m, index_t n,
#                                      index_t k);
#                        
#

.global asm_transpose
    .text
asm_transpose:
    # FUNCTION PRELOG BEGINS HERE
    pushq %rbp              
    movq %rsp, %rbp
    # ALLOCATE STACK SPACE
    subq $64, %rsp
    # SAVE TO STACK
    movq %r12, -0x8(%rbp)
    movq %r13, -0x10(%rbp)
    # FUNC START
    movq %r9, %rax                  # M
    movq 0x10(%rbp), %rax           # N
    movq 0x18(%rbp), %rax           # K
    # MOVE TO TEMP REGISTERS
    movq %rdi, %r10
    movq %rsi, %r11
    xorl %r12d, %r12d
    # START MAT TRANSPOSE
    xorl %eax, %eax                 # i
    xorl %r13d, %r13d 
.LPTPOSE_OUTER:
    cmpl %r9d, %eax                 # i < M
    jnb .EXITMAIN
    xorl %r13d, %r13d               # j
.LPTPOSE_INNER:
    cmpl 0x18(%rbp), %r13d          # j < K
    jnb .LPTPOSE_INNER_END
    # INDEX COMPUTATION
    movl %eax, %edi
    imul 0x18(%rbp), %edi           # i * k  
    addl %r13d, %edi                 # i * k + j
    leaq (%r10, %rdi, 0x4), %rdi    # 4 BYTE ALIGNED
    movq (%rdi), %rdi
    movl %r13d, %esi                         
    imul %r9d, %esi                 # j * m
    addl %eax, %esi                 # j * m + i
    leaq (%rcx, %rsi, 0x4), %rsi    # 4 BYTE ALIGNED
    # STORE
    movl %edi, (%rsi)
    addl $1, %r13d
    jmp .LPTPOSE_INNER
.LPTPOSE_INNER_END:
    addl $1, %eax
    jmp .LPTPOSE_OUTER
.EXITMAIN:
    # SAVE FROM STACK
    movq -0x8(%rbp), %r12
    movq -0x10(%rbp), %r13
    # DEALLOCATE STACK SPACE
    addq $64, %rsp
    # FUNCTION EPILOG BEGINS HERE
    movq %rbp, %rsp        
    pop %rbp
    ret

