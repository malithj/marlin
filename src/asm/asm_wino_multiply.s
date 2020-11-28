#	Assemble revision 001 of WINO MULTIPLY
#	13:47 NOVEMBER 27, 2020
#   @author: Malith Jayaweera

# THE FOLLOWING SUBROUTINE MAY BE CALLED TO COMPUTE ELEMENTWISE MULTIPLICATION
# IN WINOGRAD KERNELS
#
# CALLING SEQUENCE IS AS FOLLOWS:
#       RDI : A STRIDE
#       RSI : B STRIDE
#       RDX : C STRIDE
#       RCX : TILE COUNT
#       R8  : IN CHANNELS
#       R9  : MASK
# 0x10(EBP) : MATRIX A PTR
# 0x18(EBP) : MATRIX B PTR
# 0x20(EBP) : MATRIX C PTR
#
# FUNCTION DEFINITION TO BE DECLARED IS AS FOLLOWS:
#       extern "C" index_t asm_wino_multiply(index_t a_stride, index_t b_stride,
#                                            index_t c_stride,
#                                            index_t tile_count,
#                                            index_t in_channels, uint16_t mask,
#                                            float *a, float *b, void *c);
#                        
#
.text
.global asm_wino_multiply
asm_wino_multiply:
    # FUNCTION PRELOG BEGINS HERE
    pushq %rbp              
    movq %rsp, %rbp
    # ALLOCATE STACK SPACE
    subq $0x30, %rsp                         # [STACK ALLOCATE 32 BYTES]
    # SAVE VARIABLES
    movq %rbx, -0x8(%rbp)
    movq %r12, -0x10(%rbp)
    movq %r13, -0x18(%rbp)
    movq %r14, -0x20(%rbp)
    movq %r15, -0x28(%rbp)

    kmovw  %r9d, %k1                         # SET MASK
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
    movq 0x10(%rbp), %r11                    # A PTR ORG  
    movq 0x18(%rbp), %r12                    # B PTR ORG
    movq 0x20(%rbp), %r13                    # C PTR
.LOOPBEGIN:
    # LOOP INIT
    cmpl %r8d, %ebx                          # TEST i < in_channels
    jnb .LOOPEXIT
    # LOOP INIT END                       
    leaq (%r11, %r10, 4), %r14               # A PTR
    leaq (%r12, %rbx, 4), %r15               # B PTR
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
    # BROADCAST B    
    movl (%r15), %r9d
    vpbroadcastd %r9d, %zmm31  
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm30  
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm29 
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm28 
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm27
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm26 
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm25
    leaq (%r15, %rsi, 4), %r15 
    movl (%r15), %r9d 
    vpbroadcastd %r9d, %zmm24  
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
    addl %ecx, %r10d                         # tile_count * i
    jmp .LOOPBEGIN
    # LOOP CLEANUP END
.LOOPEXIT:
    # [STORE C MATRIX PTR]
    vmovups %zmm8, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm9, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm10, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm11, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm12, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm13, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm14, (%r13){%k1}
    leaq (%r13, %rdx, 4), %r13 
    vmovups %zmm15, (%r13){%k1}
    # FUNCTION BODY ENDS
    # DEALLOCATE STACK SPACE
    movq -0x8(%rbp), %rbx
    movq -0x10(%rbp), %r12
    movq -0x18(%rbp), %r13
    movq -0x20(%rbp), %r14 
    movq  -0x28(%rbp), %r15
    addq $0x30, %rsp
    # FUNCTION EPILOG BEGINS HERE
    movq %rbp, %rsp        
    pop %rbp
    ret
