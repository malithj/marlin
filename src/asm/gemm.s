#	Assemble revision 001 of GEMM
#	15:38 JULY 25, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE GEMM USING TILING SIZE
# 15 B COLS AND 1 A COLS.
#
# CALLING SEQUENCE IS AS FOLLOWS:
#		EDI
#		
# FUNCTION DEFINITION TO BE DECLARED IS AS FOLLOWS:
#       extern "C" uint64_t asm_gemm(void);
#
#			

.global asm_gemm
    .text
asm_gemm:
    pushq %rbp               # FUNCTION PRELOG
    movq %rsp, %rbp
   # movq (%rdi), %rax       # A
   # movq (%rsi), %rax       # B
   # movq (%rdx), %rax       # C
    movq %rcx, %rax          # M
    movq %r8, %rax           # N
    movq %r9, %rax           # K
    # movq $0x7, %rax
    movq %rbp, %rsp         # FUNCTION EPILOG
    pop %rbp
    movss (%rdi), %xmm0     # RETURN VALUE
    ret
