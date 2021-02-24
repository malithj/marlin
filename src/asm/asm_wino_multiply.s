#	Assemble revision 001 of WINO MULTIPLY
#	13:47 NOVEMBER 27, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE ELEMENTWISE MULTIPLICATION
# IN WINOGRAD KERNELS
#
# CALLING SEQUENCE IS AS FOLLOWS:
#       RDI : A STRIDE
#       RSI : C STRIDE
#       RDX : TILE COUNT
#       RCX : IN CHANNELS
#       R8  : MASK
#       R9  : MATRIX A PTR
# 0x10(EBP) : MATRIX C PTR
# 0x18(EBP) : BASE PAGE ADDRESS
# 0x20(EBP) : PAGE OFFSET DATA
# 0x28(EBP) : B MATRIX IDX (CODE GEN INVOKER IDX)
#
# FUNCTION DEFINITION TO BE DECLARED IS AS FOLLOWS:
#       extern "C" index_t asm_wino_multiply(index_t a_stride, index_t b_stride,
#                                            index_t c_stride,
#                                            index_t tile_count,
#                                            index_t in_channels, uint16_t mask,
#                                            float *a, float *c, void *p_addr,
#                                            index_t *offset_data, index_t idx);
#                        
#
.text
.global asm_wino_multiply
asm_wino_multiply:
    # FUNCTION PRELOG BEGINS HERE
    pushq %rbp              
    movq %rsp, %rbp
    # ALLOCATE STACK SPACE
    subq $0x38, %rsp                         # [STACK ALLOCATE 32 BYTES]
    # SAVE VARIABLES
    movq %rbx, -0x8(%rbp)
    movq %r12, -0x10(%rbp)
    movq %r13, -0x18(%rbp)
    movq %r14, -0x20(%rbp)
    movq %r15, -0x28(%rbp)

    kmovw  %r8d, %k1                         # SET MASK
    # FUNCTION BODY  
    # INIT C
    vxorps %zmm8, %zmm8, %zmm8
    vxorps %zmm9, %zmm9, %zmm9
    vxorps %zmm10, %zmm10, %zmm10
    vxorps %zmm11, %zmm11, %zmm11
    vxorps %zmm12, %zmm12, %zmm12
    vxorps %zmm13, %zmm13, %zmm13
    vxorps %zmm14, %zmm14, %zmm14
    vxorps %zmm15, %zmm15, %zmm15

    xorl %ebx, %ebx                          # INDEX i
    xorl %r10d, %r10d                     
    movq %r9, %r11                           # A PTR ORG  
    movq 0x10(%rbp), %r13                    # C PTR ORG
    movq 0x18(%rbp), %r12                    # BASE PAGE ADDRESS
    movq 0x20(%rbp), %r8                     # OFFSET DATA
    movq 0x28(%rbp), %r15                    # IDX
.LOOPBEGIN:
    # LOOP INIT
    cmpl %ecx, %ebx                          # TEST i < in_channels
    jnb .LOOPEXIT
    # LOOP INIT END                       
    leaq (%r11, %r10, 4), %r14               # A PTR
    # LOAD A ROWS TO REGISTER
    vmovups (%r14), %zmm0{%k1}     
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm1{%k1}   
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm2{%k1} 
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm3{%k1} 
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm4{%k1} 
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm5{%k1} 
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm6{%k1} 
    leaq (%r14, %rdi, 4), %r14  
    vmovups (%r14), %zmm7{%k1}  
    # SET MATRIX B
    movl %eax, -0x30(%rbp)                   # CALLER SAVE
    movq 0x18(%rbp), %r12                    # MOV BASE PAGE ADDRESS
    movq 0x20(%rbp), %r8                     # OFFSET DATA
    lea (%r8, %r15, 0x8), %r8                # OFFSET
    movq (%r8), %r8
    addq %r8, %r12                           # CALLABLE ADDRESS
    callq *%r12                              # CALL FUNCTION TO SET MAT B
    movl -0x30(%rbp), %eax                   # CALLER RESTORE 
    # MATMUL
    vfmadd231ps %zmm0, %zmm31, %zmm8         # z8 += z0 * z31
    vfmadd231ps %zmm1, %zmm30, %zmm9         # z9 += z0 * z30
    vfmadd231ps %zmm2, %zmm29, %zmm10        # z10 += z0 * z29
    vfmadd231ps %zmm3, %zmm28, %zmm11        # z11 += z0 * z28
    vfmadd231ps %zmm4, %zmm27, %zmm12        # z12 += z0 * z27
    vfmadd231ps %zmm5, %zmm26, %zmm13        # z13 += z0 * z26
    vfmadd231ps %zmm6, %zmm25, %zmm14        # z14 += z0 * z25
    vfmadd231ps %zmm7, %zmm24, %zmm15        # z15 += z0 * z24
    # LOOP CLEANUP        
    addl $1, %ebx                            # i = i + 1
    addl %edx, %r10d                         # tile_count * i
    addl $1, %r15d                           # ID = ID + 1
    jmp .LOOPBEGIN
    # LOOP CLEANUP END
.LOOPEXIT:
    # [STORE C MATRIX PTR]
    vmovups %zmm8, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm9, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm10, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm11, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm12, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm13, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm14, (%r13){%k1}
    leaq (%r13, %rsi, 4), %r13 
    vmovups %zmm15, (%r13){%k1}
    # FUNCTION BODY ENDS
    # DEALLOCATE STACK SPACE
    movq -0x8(%rbp), %rbx
    movq -0x10(%rbp), %r12
    movq -0x18(%rbp), %r13
    movq -0x20(%rbp), %r14 
    movq  -0x28(%rbp), %r15
    addq $0x38, %rsp
    # FUNCTION EPILOG BEGINS HERE
    movq %rbp, %rsp        
    pop %rbp
    ret
