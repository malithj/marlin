	.file	"test_gemm.cc"
	.text
	.section	.rodata
	.type	_ZStL19piecewise_construct, @object
	.size	_ZStL19piecewise_construct, 1
_ZStL19piecewise_construct:
	.zero	1
	.align 4
	.type	_ZN9__gnu_cxxL21__default_lock_policyE, @object
	.size	_ZN9__gnu_cxxL21__default_lock_policyE, 4
_ZN9__gnu_cxxL21__default_lock_policyE:
	.long	2
	.type	_ZStL13allocator_arg, @object
	.size	_ZStL13allocator_arg, 1
_ZStL13allocator_arg:
	.zero	1
	.section	.text._ZNSt11char_traitsIcE6lengthEPKc,"axG",@progbits,_ZNSt11char_traitsIcE6lengthEPKc,comdat
	.weak	_ZNSt11char_traitsIcE6lengthEPKc
	.type	_ZNSt11char_traitsIcE6lengthEPKc, @function
_ZNSt11char_traitsIcE6lengthEPKc:
.LFB4747:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	subq	$1, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4747:
	.size	_ZNSt11char_traitsIcE6lengthEPKc, .-_ZNSt11char_traitsIcE6lengthEPKc
	.section	.rodata
	.type	_ZStL6ignore, @object
	.size	_ZStL6ignore, 1
_ZStL6ignore:
	.zero	1
	.section	.text._ZStorSt13_Ios_OpenmodeS_,"axG",@progbits,_ZStorSt13_Ios_OpenmodeS_,comdat
	.weak	_ZStorSt13_Ios_OpenmodeS_
	.type	_ZStorSt13_Ios_OpenmodeS_, @function
_ZStorSt13_Ios_OpenmodeS_:
.LFB5946:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	orl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5946:
	.size	_ZStorSt13_Ios_OpenmodeS_, .-_ZStorSt13_Ios_OpenmodeS_
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.text._ZN7testing8internal8GTestLog9GetStreamEv,"axG",@progbits,_ZN7testing8internal8GTestLog9GetStreamEv,comdat
	.align 2
	.weak	_ZN7testing8internal8GTestLog9GetStreamEv
	.type	_ZN7testing8internal8GTestLog9GetStreamEv, @function
_ZN7testing8internal8GTestLog9GetStreamEv:
.LFB6928:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	leaq	_ZSt4cerr(%rip), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6928:
	.size	_ZN7testing8internal8GTestLog9GetStreamEv, .-_ZN7testing8internal8GTestLog9GetStreamEv
	.section	.rodata
	.align 8
	.type	_ZN7testing8internalL14kMaxBiggestIntE, @object
	.size	_ZN7testing8internalL14kMaxBiggestIntE, 8
_ZN7testing8internalL14kMaxBiggestIntE:
	.quad	9223372036854775807
	.section	.text._ZN7testing8internal15TestFactoryBaseD2Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryBaseD5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryBaseD2Ev
	.type	_ZN7testing8internal15TestFactoryBaseD2Ev, @function
_ZN7testing8internal15TestFactoryBaseD2Ev:
.LFB7629:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	leaq	16+_ZTVN7testing8internal15TestFactoryBaseE(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7629:
	.size	_ZN7testing8internal15TestFactoryBaseD2Ev, .-_ZN7testing8internal15TestFactoryBaseD2Ev
	.weak	_ZN7testing8internal15TestFactoryBaseD1Ev
	.set	_ZN7testing8internal15TestFactoryBaseD1Ev,_ZN7testing8internal15TestFactoryBaseD2Ev
	.section	.text._ZN7testing8internal15TestFactoryBaseD0Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryBaseD5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryBaseD0Ev
	.type	_ZN7testing8internal15TestFactoryBaseD0Ev, @function
_ZN7testing8internal15TestFactoryBaseD0Ev:
.LFB7631:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryBaseD1Ev
	movq	-8(%rbp), %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	_ZdlPvm@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7631:
	.size	_ZN7testing8internal15TestFactoryBaseD0Ev, .-_ZN7testing8internal15TestFactoryBaseD0Ev
	.section	.text._ZN7testing8internal15TestFactoryBaseC2Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryBaseC5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryBaseC2Ev
	.type	_ZN7testing8internal15TestFactoryBaseC2Ev, @function
_ZN7testing8internal15TestFactoryBaseC2Ev:
.LFB7633:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	leaq	16+_ZTVN7testing8internal15TestFactoryBaseE(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7633:
	.size	_ZN7testing8internal15TestFactoryBaseC2Ev, .-_ZN7testing8internal15TestFactoryBaseC2Ev
	.weak	_ZN7testing8internal15TestFactoryBaseC1Ev
	.set	_ZN7testing8internal15TestFactoryBaseC1Ev,_ZN7testing8internal15TestFactoryBaseC2Ev
	.section	.text._ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi,"axG",@progbits,_ZN7testing8internal12CodeLocationC5ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi,comdat
	.align 2
	.weak	_ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
	.type	_ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi, @function
_ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi:
.LFB7637:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_@PLT
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %edx
	movl	%edx, 32(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7637:
	.size	_ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi, .-_ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
	.weak	_ZN7testing8internal12CodeLocationC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
	.set	_ZN7testing8internal12CodeLocationC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi,_ZN7testing8internal12CodeLocationC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
	.section	.text._ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_,"axG",@progbits,_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_,comdat
	.weak	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_
	.type	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_, @function
_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_:
.LFB7639:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	je	.L12
	movq	-8(%rbp), %rax
	jmp	.L14
.L12:
	movl	$0, %eax
.L14:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7639:
	.size	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_, .-_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_
	.section	.text._ZN7testing8internal12CodeLocationD2Ev,"axG",@progbits,_ZN7testing8internal12CodeLocationD5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal12CodeLocationD2Ev
	.type	_ZN7testing8internal12CodeLocationD2Ev, @function
_ZN7testing8internal12CodeLocationD2Ev:
.LFB7662:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7662:
	.size	_ZN7testing8internal12CodeLocationD2Ev, .-_ZN7testing8internal12CodeLocationD2Ev
	.weak	_ZN7testing8internal12CodeLocationD1Ev
	.set	_ZN7testing8internal12CodeLocationD1Ev,_ZN7testing8internal12CodeLocationD2Ev
	.section	.rodata
	.align 16
	.type	_ZN7testing8internalL19kDeathTestStyleFlagE, @object
	.size	_ZN7testing8internalL19kDeathTestStyleFlagE, 17
_ZN7testing8internalL19kDeathTestStyleFlagE:
	.string	"death_test_style"
	.align 16
	.type	_ZN7testing8internalL17kDeathTestUseForkE, @object
	.size	_ZN7testing8internalL17kDeathTestUseForkE, 20
_ZN7testing8internalL17kDeathTestUseForkE:
	.string	"death_test_use_fork"
	.align 16
	.type	_ZN7testing8internalL25kInternalRunDeathTestFlagE, @object
	.size	_ZN7testing8internalL25kInternalRunDeathTestFlagE, 24
_ZN7testing8internalL25kInternalRunDeathTestFlagE:
	.string	"internal_run_death_test"
	.align 4
	.type	_ZN7testingL19kMaxStackTraceDepthE, @object
	.size	_ZN7testingL19kMaxStackTraceDepthE, 4
_ZN7testingL19kMaxStackTraceDepthE:
	.long	100
	.section	.text._ZNK7testing15AssertionResultcvbEv,"axG",@progbits,_ZNK7testing15AssertionResultcvbEv,comdat
	.align 2
	.weak	_ZNK7testing15AssertionResultcvbEv
	.type	_ZNK7testing15AssertionResultcvbEv, @function
_ZNK7testing15AssertionResultcvbEv:
.LFB8232:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8232:
	.size	_ZNK7testing15AssertionResultcvbEv, .-_ZNK7testing15AssertionResultcvbEv
	.section	.rodata
.LC1:
	.string	""
	.section	.text._ZNK7testing15AssertionResult7messageEv,"axG",@progbits,_ZNK7testing15AssertionResult7messageEv,comdat
	.align 2
	.weak	_ZNK7testing15AssertionResult7messageEv
	.type	_ZNK7testing15AssertionResult7messageEv, @function
_ZNK7testing15AssertionResult7messageEv:
.LFB8233:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	addq	$8, %rax
	movq	%rax, %rdi
	call	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv
	testq	%rax, %rax
	je	.L19
	movq	-8(%rbp), %rax
	addq	$8, %rax
	movq	%rax, %rdi
	call	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv
	movq	%rax, %rdi
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv@PLT
	jmp	.L21
.L19:
	leaq	.LC1(%rip), %rax
.L21:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8233:
	.size	_ZNK7testing15AssertionResult7messageEv, .-_ZNK7testing15AssertionResult7messageEv
	.section	.text._ZNK7testing15AssertionResult15failure_messageEv,"axG",@progbits,_ZNK7testing15AssertionResult15failure_messageEv,comdat
	.align 2
	.weak	_ZNK7testing15AssertionResult15failure_messageEv
	.type	_ZNK7testing15AssertionResult15failure_messageEv, @function
_ZNK7testing15AssertionResult15failure_messageEv:
.LFB8234:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK7testing15AssertionResult7messageEv
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8234:
	.size	_ZNK7testing15AssertionResult15failure_messageEv, .-_ZNK7testing15AssertionResult15failure_messageEv
	.section	.text._ZN7testing7MessageD2Ev,"axG",@progbits,_ZN7testing7MessageD5Ev,comdat
	.align 2
	.weak	_ZN7testing7MessageD2Ev
	.type	_ZN7testing7MessageD2Ev, @function
_ZN7testing7MessageD2Ev:
.LFB8238:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED1Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8238:
	.size	_ZN7testing7MessageD2Ev, .-_ZN7testing7MessageD2Ev
	.weak	_ZN7testing7MessageD1Ev
	.set	_ZN7testing7MessageD1Ev,_ZN7testing7MessageD2Ev
	.section	.text._ZN7testing4Test14SetUpTestSuiteEv,"axG",@progbits,_ZN7testing4Test14SetUpTestSuiteEv,comdat
	.weak	_ZN7testing4Test14SetUpTestSuiteEv
	.type	_ZN7testing4Test14SetUpTestSuiteEv, @function
_ZN7testing4Test14SetUpTestSuiteEv:
.LFB8246:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8246:
	.size	_ZN7testing4Test14SetUpTestSuiteEv, .-_ZN7testing4Test14SetUpTestSuiteEv
	.section	.text._ZN7testing4Test17TearDownTestSuiteEv,"axG",@progbits,_ZN7testing4Test17TearDownTestSuiteEv,comdat
	.weak	_ZN7testing4Test17TearDownTestSuiteEv
	.type	_ZN7testing4Test17TearDownTestSuiteEv, @function
_ZN7testing4Test17TearDownTestSuiteEv:
.LFB8247:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8247:
	.size	_ZN7testing4Test17TearDownTestSuiteEv, .-_ZN7testing4Test17TearDownTestSuiteEv
	.section	.text._ZN7testing4Test16TearDownTestCaseEv,"axG",@progbits,_ZN7testing4Test16TearDownTestCaseEv,comdat
	.weak	_ZN7testing4Test16TearDownTestCaseEv
	.type	_ZN7testing4Test16TearDownTestCaseEv, @function
_ZN7testing4Test16TearDownTestCaseEv:
.LFB8248:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8248:
	.size	_ZN7testing4Test16TearDownTestCaseEv, .-_ZN7testing4Test16TearDownTestCaseEv
	.section	.text._ZN7testing4Test13SetUpTestCaseEv,"axG",@progbits,_ZN7testing4Test13SetUpTestCaseEv,comdat
	.weak	_ZN7testing4Test13SetUpTestCaseEv
	.type	_ZN7testing4Test13SetUpTestCaseEv, @function
_ZN7testing4Test13SetUpTestCaseEv:
.LFB8249:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8249:
	.size	_ZN7testing4Test13SetUpTestCaseEv, .-_ZN7testing4Test13SetUpTestCaseEv
	.section	.text._ZN7testing4Test5SetupEv,"axG",@progbits,_ZN7testing4Test5SetupEv,comdat
	.align 2
	.weak	_ZN7testing4Test5SetupEv
	.type	_ZN7testing4Test5SetupEv, @function
_ZN7testing4Test5SetupEv:
.LFB8252:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8252:
	.size	_ZN7testing4Test5SetupEv, .-_ZN7testing4Test5SetupEv
	.section	.text._ZN7testing15AssertionResultD2Ev,"axG",@progbits,_ZN7testing15AssertionResultD5Ev,comdat
	.align 2
	.weak	_ZN7testing15AssertionResultD2Ev
	.type	_ZN7testing15AssertionResultD2Ev, @function
_ZN7testing15AssertionResultD2Ev:
.LFB8351:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	addq	$8, %rax
	movq	%rax, %rdi
	call	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED1Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8351:
	.size	_ZN7testing15AssertionResultD2Ev, .-_ZN7testing15AssertionResultD2Ev
	.weak	_ZN7testing15AssertionResultD1Ev
	.set	_ZN7testing15AssertionResultD1Ev,_ZN7testing15AssertionResultD2Ev
	.section	.text._ZN13GEMM_CPP_TestC2Ev,"axG",@progbits,_ZN13GEMM_CPP_TestC5Ev,comdat
	.align 2
	.weak	_ZN13GEMM_CPP_TestC2Ev
	.type	_ZN13GEMM_CPP_TestC2Ev, @function
_ZN13GEMM_CPP_TestC2Ev:
.LFB8380:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing4TestC2Ev@PLT
	leaq	16+_ZTV13GEMM_CPP_Test(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8380:
	.size	_ZN13GEMM_CPP_TestC2Ev, .-_ZN13GEMM_CPP_TestC2Ev
	.weak	_ZN13GEMM_CPP_TestC1Ev
	.set	_ZN13GEMM_CPP_TestC1Ev,_ZN13GEMM_CPP_TestC2Ev
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev:
.LFB8383:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryBaseC2Ev
	leaq	16+_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8383:
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev, .-_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC1Ev
	.set	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC1Ev,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC2Ev
	.globl	_ZN13GEMM_CPP_Test10test_info_E
	.bss
	.align 8
	.type	_ZN13GEMM_CPP_Test10test_info_E, @object
	.size	_ZN13GEMM_CPP_Test10test_info_E, 8
_ZN13GEMM_CPP_Test10test_info_E:
	.zero	8
	.section	.rodata
.LC4:
	.string	"C[i]"
.LC5:
	.string	"C_REF[i]"
.LC6:
	.string	"test/gemm/test_gemm.cc"
	.align 32
.LC0:
	.long	1162981376
	.long	1163206656
	.long	1163431936
	.long	1163657216
	.long	1163882496
	.long	1164107776
	.long	1164333056
	.long	1164558336
	.long	1164783616
	.long	1165008896
	.long	1173919744
	.long	1174237184
	.long	1174479872
	.long	1174638592
	.long	1174797312
	.long	1174956032
	.long	1175114752
	.long	1175273472
	.long	1175432192
	.long	1175590912
	.long	1178872832
	.long	1179133952
	.long	1179395072
	.long	1179656192
	.long	1179917312
	.long	1180178432
	.long	1180439552
	.long	1180700672
	.long	1180961792
	.long	1181222912
	.long	1183188480
	.long	1183370240
	.long	1183552000
	.long	1183733760
	.long	1183915520
	.long	1184097280
	.long	1184279040
	.long	1184460800
	.long	1184642560
	.long	1184824320
	.long	1185543680
	.long	1185776640
	.long	1186009600
	.long	1186242560
	.long	1186475520
	.long	1186708480
	.long	1186941440
	.long	1187174400
	.long	1187407360
	.long	1187640320
	.long	1187898880
	.long	1188183040
	.long	1188467200
	.long	1188751360
	.long	1189035520
	.long	1189319680
	.long	1189603840
	.long	1189888000
	.long	1190172160
	.long	1190456320
	.long	1190254080
	.long	1190589440
	.long	1190924800
	.long	1191221248
	.long	1191388928
	.long	1191556608
	.long	1191724288
	.long	1191891968
	.long	1192059648
	.long	1192227328
	.long	1191895808
	.long	1192089088
	.long	1192282368
	.long	1192475648
	.long	1192668928
	.long	1192862208
	.long	1193055488
	.long	1193248768
	.long	1193442048
	.long	1193635328
	.long	1193073408
	.long	1193292288
	.long	1193511168
	.long	1193730048
	.long	1193948928
	.long	1194167808
	.long	1194386688
	.long	1194605568
	.long	1194824448
	.long	1195043328
	.long	1194251008
	.long	1194495488
	.long	1194739968
	.long	1194984448
	.long	1195228928
	.long	1195473408
	.long	1195717888
	.long	1195962368
	.long	1196206848
	.long	1196451328
	.text
	.align 2
	.globl	_ZN13GEMM_CPP_Test8TestBodyEv
	.type	_ZN13GEMM_CPP_Test8TestBodyEv, @function
_ZN13GEMM_CPP_Test8TestBodyEv:
.LFB8388:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8388
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$568, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -568(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	$10, -504(%rbp)
	movq	$10, -496(%rbp)
	movq	$10, -488(%rbp)
	movq	-504(%rbp), %rax
	imulq	-488(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -480(%rbp)
	movq	-496(%rbp), %rax
	imulq	-488(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -472(%rbp)
	movq	-504(%rbp), %rax
	imulq	-496(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -464(%rbp)
	leaq	-432(%rbp), %rax
	leaq	.LC0(%rip), %rcx
	movl	$400, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	$0, -544(%rbp)
.L40:
	movq	-544(%rbp), %rax
	cmpq	-504(%rbp), %rax
	jnb	.L35
	movq	$0, -536(%rbp)
.L39:
	movq	-536(%rbp), %rax
	cmpq	-488(%rbp), %rax
	jnb	.L36
	movq	-544(%rbp), %rax
	imulq	-488(%rbp), %rax
	movq	%rax, %rdx
	movq	-536(%rbp), %rax
	addq	%rdx, %rax
	addq	$1, %rax
	movq	-544(%rbp), %rdx
	movq	%rdx, %rcx
	imulq	-488(%rbp), %rcx
	movq	-536(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-480(%rbp), %rdx
	addq	%rdx, %rcx
	testq	%rax, %rax
	js	.L37
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	jmp	.L38
.L37:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	vcvtsi2ssq	%rdx, %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
.L38:
	vmovss	%xmm0, (%rcx)
	addq	$1, -536(%rbp)
	jmp	.L39
.L36:
	addq	$1, -544(%rbp)
	jmp	.L40
.L35:
	movq	$0, -528(%rbp)
.L46:
	movq	-528(%rbp), %rax
	cmpq	-488(%rbp), %rax
	jnb	.L41
	movq	$0, -520(%rbp)
.L45:
	movq	-520(%rbp), %rax
	cmpq	-496(%rbp), %rax
	jnb	.L42
	movq	-528(%rbp), %rax
	imulq	-496(%rbp), %rax
	movq	%rax, %rdx
	movq	-520(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -456(%rbp)
	movq	-456(%rbp), %rax
	addq	$1, %rax
	movq	-528(%rbp), %rdx
	movq	%rdx, %rcx
	imulq	-496(%rbp), %rcx
	movq	-520(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-472(%rbp), %rdx
	addq	%rdx, %rcx
	testq	%rax, %rax
	js	.L43
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	jmp	.L44
.L43:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	vcvtsi2ssq	%rdx, %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
.L44:
	vmovss	%xmm0, (%rcx)
	addq	$1, -520(%rbp)
	jmp	.L45
.L42:
	addq	$1, -528(%rbp)
	jmp	.L46
.L41:
	movq	-480(%rbp), %rsi
	movq	-488(%rbp), %rcx
	movq	-496(%rbp), %rdx
	movq	-504(%rbp), %rax
	subq	$8, %rsp
	pushq	-496(%rbp)
	pushq	-464(%rbp)
	pushq	-496(%rbp)
	pushq	-472(%rbp)
	pushq	-488(%rbp)
	vxorps	%zmm1, %zmm1, %zmm1
	movq	%rsi, %r9
	vmovss	.LC3(%rip), %xmm0
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$78, %esi
	movl	$78, %edi
.LEHB0:
	call	_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m
	addq	$48, %rsp
	movq	$0, -512(%rbp)
.L49:
	movq	-504(%rbp), %rax
	imulq	-496(%rbp), %rax
	cmpq	%rax, -512(%rbp)
	jnb	.L47
	movq	-512(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-464(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	leaq	-432(%rbp), %rax
	movq	-512(%rbp), %rdx
	salq	$2, %rdx
	addq	%rax, %rdx
	leaq	-448(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	leaq	.LC4(%rip), %rdx
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_
.LEHE0:
	leaq	-448(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK7testing15AssertionResultcvbEv
	testb	%al, %al
	jne	.L48
	leaq	-552(%rbp), %rax
	movq	%rax, %rdi
.LEHB1:
	call	_ZN7testing7MessageC1Ev@PLT
.LEHE1:
	leaq	-448(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK7testing15AssertionResult15failure_messageEv
	movq	%rax, %rdx
	leaq	-560(%rbp), %rax
	movq	%rdx, %r8
	movl	$45, %ecx
	leaq	.LC6(%rip), %rdx
	movl	$1, %esi
	movq	%rax, %rdi
.LEHB2:
	call	_ZN7testing8internal12AssertHelperC1ENS_14TestPartResult4TypeEPKciS5_@PLT
.LEHE2:
	leaq	-552(%rbp), %rdx
	leaq	-560(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB3:
	call	_ZNK7testing8internal12AssertHelperaSERKNS_7MessageE@PLT
.LEHE3:
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal12AssertHelperD1Ev@PLT
	leaq	-552(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing7MessageD1Ev
.L48:
	leaq	-448(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing15AssertionResultD1Ev
	addq	$1, -512(%rbp)
	jmp	.L49
.L47:
	movq	-480(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-472(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-464(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	movq	-24(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L53
	jmp	.L57
.L56:
	movq	%rax, %rbx
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal12AssertHelperD1Ev@PLT
	jmp	.L51
.L55:
	movq	%rax, %rbx
.L51:
	leaq	-552(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing7MessageD1Ev
	jmp	.L52
.L54:
	movq	%rax, %rbx
.L52:
	leaq	-448(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing15AssertionResultD1Ev
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB4:
	call	_Unwind_Resume@PLT
.LEHE4:
.L57:
	call	__stack_chk_fail@PLT
.L53:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8388:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA8388:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8388-.LLSDACSB8388
.LLSDACSB8388:
	.uleb128 .LEHB0-.LFB8388
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB8388
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L54-.LFB8388
	.uleb128 0
	.uleb128 .LEHB2-.LFB8388
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L55-.LFB8388
	.uleb128 0
	.uleb128 .LEHB3-.LFB8388
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L56-.LFB8388
	.uleb128 0
	.uleb128 .LEHB4-.LFB8388
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSE8388:
	.text
	.size	_ZN13GEMM_CPP_Test8TestBodyEv, .-_ZN13GEMM_CPP_Test8TestBodyEv
	.section	.text._ZN13GEMM_ASM_TestC2Ev,"axG",@progbits,_ZN13GEMM_ASM_TestC5Ev,comdat
	.align 2
	.weak	_ZN13GEMM_ASM_TestC2Ev
	.type	_ZN13GEMM_ASM_TestC2Ev, @function
_ZN13GEMM_ASM_TestC2Ev:
.LFB8390:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing4TestC2Ev@PLT
	leaq	16+_ZTV13GEMM_ASM_Test(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8390:
	.size	_ZN13GEMM_ASM_TestC2Ev, .-_ZN13GEMM_ASM_TestC2Ev
	.weak	_ZN13GEMM_ASM_TestC1Ev
	.set	_ZN13GEMM_ASM_TestC1Ev,_ZN13GEMM_ASM_TestC2Ev
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev:
.LFB8393:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryBaseC2Ev
	leaq	16+_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8393:
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev, .-_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC1Ev
	.set	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC1Ev,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC2Ev
	.globl	_ZN13GEMM_ASM_Test10test_info_E
	.bss
	.align 8
	.type	_ZN13GEMM_ASM_Test10test_info_E, @object
	.size	_ZN13GEMM_ASM_Test10test_info_E, 8
_ZN13GEMM_ASM_Test10test_info_E:
	.zero	8
	.text
	.align 2
	.globl	_ZN13GEMM_ASM_Test8TestBodyEv
	.type	_ZN13GEMM_ASM_Test8TestBodyEv, @function
_ZN13GEMM_ASM_Test8TestBodyEv:
.LFB8395:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -120(%rbp)
	movq	$10, -72(%rbp)
	movq	$11, -64(%rbp)
	movq	$12, -56(%rbp)
	movq	-72(%rbp), %rax
	imulq	-56(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -48(%rbp)
	movq	-64(%rbp), %rax
	imulq	-56(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -40(%rbp)
	movq	-72(%rbp), %rax
	imulq	-64(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	movq	-72(%rbp), %rax
	imulq	-56(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movq	-72(%rbp), %rax
	imulq	-64(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	movq	$0, -104(%rbp)
.L66:
	movq	-104(%rbp), %rax
	cmpq	-72(%rbp), %rax
	jnb	.L61
	movq	$0, -96(%rbp)
.L65:
	movq	-96(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jnb	.L62
	movq	-104(%rbp), %rax
	imulq	-64(%rbp), %rax
	movq	%rax, %rdx
	movq	-96(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	-104(%rbp), %rdx
	movq	%rdx, %rcx
	imulq	-56(%rbp), %rcx
	movq	-96(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-48(%rbp), %rdx
	addq	%rdx, %rcx
	testq	%rax, %rax
	js	.L63
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	jmp	.L64
.L63:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	vcvtsi2ssq	%rdx, %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
.L64:
	vmovss	%xmm0, (%rcx)
	addq	$1, -96(%rbp)
	jmp	.L65
.L62:
	addq	$1, -104(%rbp)
	jmp	.L66
.L61:
	movq	$0, -88(%rbp)
.L72:
	movq	-88(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jnb	.L67
	movq	$0, -80(%rbp)
.L71:
	movq	-80(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jnb	.L68
	movq	-88(%rbp), %rax
	imulq	-64(%rbp), %rax
	movq	%rax, %rdx
	movq	-80(%rbp), %rax
	addq	%rdx, %rax
	testq	%rax, %rax
	js	.L69
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	jmp	.L70
.L69:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	vcvtsi2ssq	%rdx, %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
.L70:
	vmovss	%xmm0, -108(%rbp)
	movq	-88(%rbp), %rax
	imulq	-64(%rbp), %rax
	movq	%rax, %rdx
	movq	-80(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	vmovss	-108(%rbp), %xmm1
	vmovss	.LC3(%rip), %xmm0
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, (%rax)
	addq	$1, -80(%rbp)
	jmp	.L71
.L68:
	addq	$1, -88(%rbp)
	jmp	.L72
.L67:
	movq	-48(%rbp), %rax
	movl	(%rax), %eax
	vmovd	%eax, %xmm0
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEf@PLT
	movq	%rax, %rdx
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	movq	-72(%rbp), %r8
	movq	-16(%rbp), %rdi
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-48(%rbp), %rax
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	asm_gemm@PLT
	addq	$16, %rsp
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEm@PLT
	movq	%rax, %rdx
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8395:
	.size	_ZN13GEMM_ASM_Test8TestBodyEv, .-_ZN13GEMM_ASM_Test8TestBodyEv
	.section	.text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_,"axG",@progbits,_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_,comdat
	.weak	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_
	.type	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_, @function
_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_:
.LFB8674:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8674
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11char_traitsIcE6lengthEPKc
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev@PLT
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4sizeEv@PLT
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	addq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB5:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7reserveEm@PLT
	movq	-32(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendEPKcm@PLT
	movq	-56(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6appendERKS4_@PLT
.LEHE5:
	jmp	.L78
.L77:
	movq	%rax, %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB6:
	call	_Unwind_Resume@PLT
.LEHE6:
.L78:
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L76
	call	__stack_chk_fail@PLT
.L76:
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8674:
	.section	.gcc_except_table
.LLSDA8674:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8674-.LLSDACSB8674
.LLSDACSB8674:
	.uleb128 .LEHB5-.LFB8674
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L77-.LFB8674
	.uleb128 0
	.uleb128 .LEHB6-.LFB8674
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE8674:
	.section	.text._ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_,"axG",@progbits,_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_,comdat
	.size	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_, .-_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_
	.section	.text._ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev,"axG",@progbits,_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED5Ev,comdat
	.align 2
	.weak	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev
	.type	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev, @function
_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev:
.LFB8712:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L80
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_
.L80:
	movq	-8(%rbp), %rax
	movq	$0, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8712:
	.size	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev, .-_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev
	.weak	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED1Ev
	.set	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED1Ev,_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev
	.section	.text._ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv,"axG",@progbits,_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv,comdat
	.align 2
	.weak	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv
	.type	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv, @function
_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv:
.LFB8852:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8852:
	.size	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv, .-_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv
	.section	.text._ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv,"axG",@progbits,_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv,comdat
	.align 2
	.weak	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv
	.type	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv, @function
_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv:
.LFB8853:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE3getEv
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8853:
	.size	_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv, .-_ZNKSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEptEv
	.section	.text._ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev,"axG",@progbits,_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED5Ev,comdat
	.align 2
	.weak	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev
	.type	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev, @function
_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev:
.LFB8858:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L86
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_
.L86:
	movq	-8(%rbp), %rax
	movq	$0, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8858:
	.size	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev, .-_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev
	.weak	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED1Ev
	.set	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED1Ev,_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EED2Ev
	.section	.rodata
	.align 8
.LC7:
	.string	"googletest/googletest/include/gtest/internal/gtest-internal.h"
	.align 8
.LC8:
	.string	"Condition !test_case_fp || !test_suite_fp failed. "
	.align 8
.LC9:
	.string	"Test can not provide both SetUpTestSuite and SetUpTestCase, please make sure there is only one present at "
.LC10:
	.string	":"
	.section	.text._ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci,"axG",@progbits,_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci,comdat
	.weak	_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci
	.type	_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci, @function
_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci:
.LFB8860:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8860
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	_ZN7testing4Test13SetUpTestCaseEv(%rip), %rsi
	leaq	_ZN7testing4Test13SetUpTestCaseEv(%rip), %rdi
	call	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_
	movq	%rax, -40(%rbp)
	leaq	_ZN7testing4Test14SetUpTestSuiteEv(%rip), %rsi
	leaq	_ZN7testing4Test14SetUpTestSuiteEv(%rip), %rdi
	call	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_
	movq	%rax, -32(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L88
	cmpq	$0, -32(%rbp)
	jne	.L89
.L88:
	movl	$1, %eax
	jmp	.L90
.L89:
	movl	$0, %eax
.L90:
	movzbl	%al, %eax
	movl	%eax, %edi
.LEHB7:
	call	_ZN7testing8internal6IsTrueEb@PLT
	testb	%al, %al
	jne	.L91
	leaq	-44(%rbp), %rax
	movl	$528, %ecx
	leaq	.LC7(%rip), %rdx
	movl	$3, %esi
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLogC1ENS0_16GTestLogSeverityEPKci@PLT
.LEHE7:
	leaq	-44(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLog9GetStreamEv
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
.LEHB8:
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	leaq	.LC9(%rip), %rsi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-60(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
.LEHE8:
	leaq	-44(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLogD1Ev@PLT
.L91:
	cmpq	$0, -40(%rbp)
	je	.L92
	movq	-40(%rbp), %rax
	jmp	.L94
.L92:
	movq	-32(%rbp), %rax
.L94:
	movq	-24(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L96
	jmp	.L98
.L97:
	movq	%rax, %rbx
	leaq	-44(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLogD1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB9:
	call	_Unwind_Resume@PLT
.LEHE9:
.L98:
	call	__stack_chk_fail@PLT
.L96:
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8860:
	.section	.gcc_except_table
.LLSDA8860:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8860-.LLSDACSB8860
.LLSDACSB8860:
	.uleb128 .LEHB7-.LFB8860
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LFB8860
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L97-.LFB8860
	.uleb128 0
	.uleb128 .LEHB9-.LFB8860
	.uleb128 .LEHE9-.LEHB9
	.uleb128 0
	.uleb128 0
.LLSDACSE8860:
	.section	.text._ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci,"axG",@progbits,_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci,comdat
	.size	_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci, .-_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci
	.section	.rodata
	.align 8
.LC11:
	.string	"Test can not provide both TearDownTestSuite and TearDownTestCase, please make sure there is only one present at"
	.section	.text._ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci,"axG",@progbits,_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci,comdat
	.weak	_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci
	.type	_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci, @function
_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci:
.LFB8861:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8861
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	_ZN7testing4Test16TearDownTestCaseEv(%rip), %rsi
	leaq	_ZN7testing4Test16TearDownTestCaseEv(%rip), %rdi
	call	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_
	movq	%rax, -40(%rbp)
	leaq	_ZN7testing4Test17TearDownTestSuiteEv(%rip), %rsi
	leaq	_ZN7testing4Test17TearDownTestSuiteEv(%rip), %rdi
	call	_ZN7testing8internal19GetNotDefaultOrNullEPFvvES2_
	movq	%rax, -32(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L100
	cmpq	$0, -32(%rbp)
	jne	.L101
.L100:
	movl	$1, %eax
	jmp	.L102
.L101:
	movl	$0, %eax
.L102:
	movzbl	%al, %eax
	movl	%eax, %edi
.LEHB10:
	call	_ZN7testing8internal6IsTrueEb@PLT
	testb	%al, %al
	jne	.L103
	leaq	-44(%rbp), %rax
	movl	$543, %ecx
	leaq	.LC7(%rip), %rdx
	movl	$3, %esi
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLogC1ENS0_16GTestLogSeverityEPKci@PLT
.LEHE10:
	leaq	-44(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLog9GetStreamEv
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
.LEHB11:
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-60(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
.LEHE11:
	leaq	-44(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLogD1Ev@PLT
.L103:
	cmpq	$0, -40(%rbp)
	je	.L104
	movq	-40(%rbp), %rax
	jmp	.L106
.L104:
	movq	-32(%rbp), %rax
.L106:
	movq	-24(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L108
	jmp	.L110
.L109:
	movq	%rax, %rbx
	leaq	-44(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal8GTestLogD1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB12:
	call	_Unwind_Resume@PLT
.LEHE12:
.L110:
	call	__stack_chk_fail@PLT
.L108:
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8861:
	.section	.gcc_except_table
.LLSDA8861:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8861-.LLSDACSB8861
.LLSDACSB8861:
	.uleb128 .LEHB10-.LFB8861
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB11-.LFB8861
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L109-.LFB8861
	.uleb128 0
	.uleb128 .LEHB12-.LFB8861
	.uleb128 .LEHE12-.LEHB12
	.uleb128 0
	.uleb128 0
.LLSDACSE8861:
	.section	.text._ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci,"axG",@progbits,_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci,comdat
	.size	_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci, .-_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci
	.section	.rodata
	.align 8
.LC12:
	.string	"unknown matrix mode provided: "
	.section	.text._Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m,"axG",@progbits,_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m,comdat
	.weak	_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m
	.type	_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m, @function
_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m:
.LFB8862:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8862
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x70,0x6
	.cfi_escape 0x10,0xc,0x2,0x76,0x78
	pushq	%rbx
	subq	$7256, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x68
	movq	%r10, %rax
	movq	%rdx, -7232(%rbp)
	movq	%rcx, -7240(%rbp)
	movq	%r8, -7248(%rbp)
	vmovss	%xmm0, -7252(%rbp)
	movq	%r9, -7264(%rbp)
	vmovss	%xmm1, -7256(%rbp)
	movl	%edi, %edx
	movb	%dl, -7220(%rbp)
	movl	%esi, %edx
	movb	%dl, -7224(%rbp)
	movq	8(%rax), %rdx
	movq	%rdx, -7272(%rbp)
	movq	24(%rax), %rax
	movq	%rax, -7280(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	movq	$0, -6856(%rbp)
	movq	$0, -6848(%rbp)
	cmpb	$78, -7220(%rbp)
	je	.L112
	cmpb	$110, -7220(%rbp)
	je	.L112
	cmpb	$84, -7220(%rbp)
	je	.L113
	cmpb	$84, -7220(%rbp)
	jne	.L114
.L113:
	movq	$1, -6856(%rbp)
	jmp	.L112
.L114:
	leaq	-7203(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcEC1Ev@PLT
	movsbl	-7220(%rbp), %edx
	leaq	-7203(%rbp), %rcx
	leaq	-128(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
.LEHB13:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EmcRKS3_@PLT
.LEHE13:
	leaq	-7203(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	leaq	-96(%rbp), %rax
	leaq	-128(%rbp), %rdx
	leaq	.LC12(%rip), %rsi
	movq	%rax, %rdi
.LEHB14:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_
.LEHE14:
	leaq	-96(%rbp), %rax
	movq	%rax, %rsi
	movq	%rbx, %rdi
.LEHB15:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE15:
	leaq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%rbx, %rdi
.LEHB16:
	call	__cxa_throw@PLT
.LEHE16:
.L112:
	cmpb	$78, -7224(%rbp)
	je	.L115
	cmpb	$110, -7224(%rbp)
	je	.L115
	cmpb	$84, -7224(%rbp)
	je	.L116
	cmpb	$84, -7224(%rbp)
	jne	.L117
.L116:
	movq	$1, -6848(%rbp)
	jmp	.L115
.L117:
	leaq	-7203(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcEC1Ev@PLT
	movsbl	-7224(%rbp), %edx
	leaq	-7203(%rbp), %rcx
	leaq	-128(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
.LEHB17:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EmcRKS3_@PLT
.LEHE17:
	leaq	-7203(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movl	$16, %edi
	call	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	leaq	-96(%rbp), %rax
	leaq	-128(%rbp), %rdx
	leaq	.LC12(%rip), %rsi
	movq	%rax, %rdi
.LEHB18:
	call	_ZStplIcSt11char_traitsIcESaIcEENSt7__cxx1112basic_stringIT_T0_T1_EEPKS5_RKS8_
.LEHE18:
	leaq	-96(%rbp), %rax
	movq	%rax, %rsi
	movq	%rbx, %rdi
.LEHB19:
	call	_ZNSt13runtime_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE19:
	leaq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	_ZNSt13runtime_errorD1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdx
	leaq	_ZTISt13runtime_error(%rip), %rsi
	movq	%rbx, %rdi
.LEHB20:
	call	__cxa_throw@PLT
.LEHE20:
.L115:
	movq	-7232(%rbp), %rax
	imulq	-7240(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-7280(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	cmpq	$0, -6848(%rbp)
	je	.L118
	movq	-7248(%rbp), %rax
	imulq	-7240(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -6840(%rbp)
	movq	$0, -6832(%rbp)
.L122:
	movq	-6832(%rbp), %rax
	cmpq	-7240(%rbp), %rax
	jnb	.L123
	movq	$0, -6824(%rbp)
.L121:
	movq	-6824(%rbp), %rax
	cmpq	-7248(%rbp), %rax
	jnb	.L120
	movq	-6832(%rbp), %rax
	imulq	-7248(%rbp), %rax
	movq	%rax, %rdx
	movq	-6824(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-7272(%rbp), %rax
	addq	%rax, %rdx
	movq	-6824(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rcx
	movq	-6832(%rbp), %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rcx
	movq	-6840(%rbp), %rax
	addq	%rcx, %rax
	vmovss	(%rdx), %xmm0
	vmovss	%xmm0, (%rax)
	addq	$1, -6824(%rbp)
	jmp	.L121
.L120:
	addq	$1, -6832(%rbp)
	jmp	.L122
.L118:
	movq	-7272(%rbp), %rax
	movq	%rax, -6840(%rbp)
.L123:
	cmpq	$0, -6856(%rbp)
	jne	.L124
	movq	-7232(%rbp), %rax
	imulq	-7248(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -6816(%rbp)
	movq	$0, -6808(%rbp)
.L128:
	movq	-6808(%rbp), %rax
	cmpq	-7232(%rbp), %rax
	jnb	.L129
	movq	$0, -6800(%rbp)
.L127:
	movq	-6800(%rbp), %rax
	cmpq	-7248(%rbp), %rax
	jnb	.L126
	movq	-6808(%rbp), %rax
	imulq	-7248(%rbp), %rax
	movq	%rax, %rdx
	movq	-6800(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-7264(%rbp), %rax
	addq	%rax, %rdx
	movq	-6800(%rbp), %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rcx
	movq	-6808(%rbp), %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rcx
	movq	-6816(%rbp), %rax
	addq	%rcx, %rax
	vmovss	(%rdx), %xmm0
	vmovss	%xmm0, (%rax)
	addq	$1, -6800(%rbp)
	jmp	.L127
.L126:
	addq	$1, -6808(%rbp)
	jmp	.L128
.L124:
	movq	-7272(%rbp), %rax
	movq	%rax, -6840(%rbp)
.L129:
	movq	-7232(%rbp), %rax
	imulq	-7240(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -6752(%rbp)
	movq	-7232(%rbp), %rax
	imulq	-7240(%rbp), %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	$0, -6792(%rbp)
.L397:
	movq	-6792(%rbp), %rax
	cmpq	-7248(%rbp), %rax
	jnb	.L130
	movq	$0, -6784(%rbp)
.L396:
	movq	-6784(%rbp), %rax
	cmpq	-7232(%rbp), %rax
	jnb	.L131
	movq	-7232(%rbp), %rax
	subq	-6784(%rbp), %rax
	cmpq	$15, %rax
	ja	.L132
	movq	-7232(%rbp), %rax
	movl	%eax, %edx
	movq	-6784(%rbp), %rax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	$65535, %edx
	shlx	%eax, %edx, %eax
	notl	%eax
	jmp	.L133
.L132:
	movl	$-1, %eax
.L133:
	movw	%ax, -7202(%rbp)
	movzwl	-7202(%rbp), %eax
	movl	%eax, -7100(%rbp)
	movl	-7100(%rbp), %eax
	movw	%ax, -7200(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6816(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7200(%rbp), %eax
	movw	%ax, -7192(%rbp)
	movq	%rdx, -6744(%rbp)
	movzwl	-7192(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6744(%rbp), %rax
	kmovw	%edx, %k1
	vmovups	(%rax), %zmm0{%k1}
	vmovaps	%zmm0, -6000(%rbp)
	movq	$0, -6776(%rbp)
.L395:
	movq	-6776(%rbp), %rax
	cmpq	-7240(%rbp), %rax
	jnb	.L137
	movq	-7240(%rbp), %rax
	subq	-6776(%rbp), %rax
	cmpq	$14, %rax
	ja	.L138
	movq	-7240(%rbp), %rax
	movl	%eax, %edx
	movq	-6776(%rbp), %rax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	$65535, %edx
	shlx	%eax, %edx, %eax
	notl	%eax
	jmp	.L139
.L138:
	movl	$32767, %eax
.L139:
	movw	%ax, -7198(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L140
	movzwl	-7202(%rbp), %eax
	jmp	.L141
.L140:
	movl	$0, %eax
.L141:
	movl	%eax, -7092(%rbp)
	movl	-7092(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6736(%rbp)
	movq	-6736(%rbp), %rax
	movq	%rax, -6728(%rbp)
	movq	-6728(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7096(%rbp)
	vbroadcastss	-7096(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7190(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6240(%rbp)
	movzwl	-7190(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k2
	vbroadcastss	-6240(%rbp), %zmm0{%k2}
	vmovaps	%zmm0, -5936(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L148
	movzwl	-7202(%rbp), %eax
	jmp	.L149
.L148:
	movl	$0, %eax
.L149:
	movl	%eax, -7084(%rbp)
	movl	-7084(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6720(%rbp)
	movq	-6720(%rbp), %rax
	movq	%rax, -6712(%rbp)
	movq	-6712(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7088(%rbp)
	vbroadcastss	-7088(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7188(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6224(%rbp)
	movzwl	-7188(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k3
	vbroadcastss	-6224(%rbp), %zmm0{%k3}
	vmovaps	%zmm0, -5872(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L156
	movzwl	-7202(%rbp), %eax
	jmp	.L157
.L156:
	movl	$0, %eax
.L157:
	movl	%eax, -7076(%rbp)
	movl	-7076(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$2, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6704(%rbp)
	movq	-6704(%rbp), %rax
	movq	%rax, -6696(%rbp)
	movq	-6696(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7080(%rbp)
	vbroadcastss	-7080(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7186(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6208(%rbp)
	movzwl	-7186(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k4
	vbroadcastss	-6208(%rbp), %zmm0{%k4}
	vmovaps	%zmm0, -5808(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L164
	movzwl	-7202(%rbp), %eax
	jmp	.L165
.L164:
	movl	$0, %eax
.L165:
	movl	%eax, -7068(%rbp)
	movl	-7068(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$3, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6688(%rbp)
	movq	-6688(%rbp), %rax
	movq	%rax, -6680(%rbp)
	movq	-6680(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7072(%rbp)
	vbroadcastss	-7072(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7184(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6192(%rbp)
	movzwl	-7184(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k5
	vbroadcastss	-6192(%rbp), %zmm0{%k5}
	vmovaps	%zmm0, -5744(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L172
	movzwl	-7202(%rbp), %eax
	jmp	.L173
.L172:
	movl	$0, %eax
.L173:
	movl	%eax, -7060(%rbp)
	movl	-7060(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$4, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6672(%rbp)
	movq	-6672(%rbp), %rax
	movq	%rax, -6664(%rbp)
	movq	-6664(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7064(%rbp)
	vbroadcastss	-7064(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7182(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6176(%rbp)
	movzwl	-7182(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k6
	vbroadcastss	-6176(%rbp), %zmm0{%k6}
	vmovaps	%zmm0, -5680(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L180
	movzwl	-7202(%rbp), %eax
	jmp	.L181
.L180:
	movl	$0, %eax
.L181:
	movl	%eax, -7052(%rbp)
	movl	-7052(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$5, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6656(%rbp)
	movq	-6656(%rbp), %rax
	movq	%rax, -6648(%rbp)
	movq	-6648(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7056(%rbp)
	vbroadcastss	-7056(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7180(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6160(%rbp)
	movzwl	-7180(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k7
	vbroadcastss	-6160(%rbp), %zmm0{%k7}
	vmovaps	%zmm0, -5616(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L188
	movzwl	-7202(%rbp), %eax
	jmp	.L189
.L188:
	movl	$0, %eax
.L189:
	movl	%eax, -7044(%rbp)
	movl	-7044(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$6, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6640(%rbp)
	movq	-6640(%rbp), %rax
	movq	%rax, -6632(%rbp)
	movq	-6632(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7048(%rbp)
	vbroadcastss	-7048(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7178(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6144(%rbp)
	movzwl	-7178(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k1
	vbroadcastss	-6144(%rbp), %zmm0{%k1}
	vmovaps	%zmm0, -5552(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L196
	movzwl	-7202(%rbp), %eax
	jmp	.L197
.L196:
	movl	$0, %eax
.L197:
	movl	%eax, -7036(%rbp)
	movl	-7036(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$7, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6624(%rbp)
	movq	-6624(%rbp), %rax
	movq	%rax, -6616(%rbp)
	movq	-6616(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7040(%rbp)
	vbroadcastss	-7040(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7176(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6128(%rbp)
	movzwl	-7176(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k2
	vbroadcastss	-6128(%rbp), %zmm0{%k2}
	vmovaps	%zmm0, -5488(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$256, %eax
	testl	%eax, %eax
	je	.L204
	movzwl	-7202(%rbp), %eax
	jmp	.L205
.L204:
	movl	$0, %eax
.L205:
	movl	%eax, -7028(%rbp)
	movl	-7028(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$8, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6608(%rbp)
	movq	-6608(%rbp), %rax
	movq	%rax, -6600(%rbp)
	movq	-6600(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7032(%rbp)
	vbroadcastss	-7032(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7174(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6112(%rbp)
	movzwl	-7174(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k3
	vbroadcastss	-6112(%rbp), %zmm0{%k3}
	vmovaps	%zmm0, -5424(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	.L212
	movzwl	-7202(%rbp), %eax
	jmp	.L213
.L212:
	movl	$0, %eax
.L213:
	movl	%eax, -7020(%rbp)
	movl	-7020(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$9, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6592(%rbp)
	movq	-6592(%rbp), %rax
	movq	%rax, -6584(%rbp)
	movq	-6584(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7024(%rbp)
	vbroadcastss	-7024(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7172(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6096(%rbp)
	movzwl	-7172(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k4
	vbroadcastss	-6096(%rbp), %zmm0{%k4}
	vmovaps	%zmm0, -5360(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	.L220
	movzwl	-7202(%rbp), %eax
	jmp	.L221
.L220:
	movl	$0, %eax
.L221:
	movl	%eax, -7012(%rbp)
	movl	-7012(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$10, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6576(%rbp)
	movq	-6576(%rbp), %rax
	movq	%rax, -6568(%rbp)
	movq	-6568(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7016(%rbp)
	vbroadcastss	-7016(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7170(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6080(%rbp)
	movzwl	-7170(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k5
	vbroadcastss	-6080(%rbp), %zmm0{%k5}
	vmovaps	%zmm0, -5296(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	je	.L228
	movzwl	-7202(%rbp), %eax
	jmp	.L229
.L228:
	movl	$0, %eax
.L229:
	movl	%eax, -7004(%rbp)
	movl	-7004(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$11, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6560(%rbp)
	movq	-6560(%rbp), %rax
	movq	%rax, -6552(%rbp)
	movq	-6552(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7008(%rbp)
	vbroadcastss	-7008(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7168(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6064(%rbp)
	movzwl	-7168(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k6
	vbroadcastss	-6064(%rbp), %zmm0{%k6}
	vmovaps	%zmm0, -5232(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$4096, %eax
	testl	%eax, %eax
	je	.L236
	movzwl	-7202(%rbp), %eax
	jmp	.L237
.L236:
	movl	$0, %eax
.L237:
	movl	%eax, -6996(%rbp)
	movl	-6996(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$12, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6544(%rbp)
	movq	-6544(%rbp), %rax
	movq	%rax, -6536(%rbp)
	movq	-6536(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -7000(%rbp)
	vbroadcastss	-7000(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7166(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6048(%rbp)
	movzwl	-7166(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k7
	vbroadcastss	-6048(%rbp), %zmm0{%k7}
	vmovaps	%zmm0, -5168(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L244
	movzwl	-7202(%rbp), %eax
	jmp	.L245
.L244:
	movl	$0, %eax
.L245:
	movl	%eax, -6988(%rbp)
	movl	-6988(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$13, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6528(%rbp)
	movq	-6528(%rbp), %rax
	movq	%rax, -6520(%rbp)
	movq	-6520(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -6992(%rbp)
	vbroadcastss	-6992(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7164(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6032(%rbp)
	movzwl	-7164(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k1
	vbroadcastss	-6032(%rbp), %zmm0{%k1}
	vmovaps	%zmm0, -5104(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	.L252
	movzwl	-7202(%rbp), %eax
	jmp	.L253
.L252:
	movl	$0, %eax
.L253:
	movl	%eax, -6980(%rbp)
	movl	-6980(%rbp), %eax
	movw	%ax, -7196(%rbp)
	movq	-6792(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rdx
	movq	-6776(%rbp), %rax
	addq	%rdx, %rax
	addq	$14, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6840(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -6512(%rbp)
	movq	-6512(%rbp), %rax
	movq	%rax, -6504(%rbp)
	movq	-6504(%rbp), %rax
	vmovss	(%rax), %xmm0
	vmovss	%xmm0, -6984(%rbp)
	vbroadcastss	-6984(%rbp), %xmm0
	vmovaps	%xmm0, -6256(%rbp)
	movzwl	-7196(%rbp), %eax
	movw	%ax, -7162(%rbp)
	vmovaps	-6256(%rbp), %xmm0
	vmovaps	%xmm0, -6016(%rbp)
	movzwl	-7162(%rbp), %eax
	vxorps	%zmm0, %zmm0, %zmm0
	kmovw	%eax, %k2
	vbroadcastss	-6016(%rbp), %zmm0{%k2}
	vmovaps	%zmm0, -5040(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L260
	movzwl	-7202(%rbp), %eax
	jmp	.L261
.L260:
	movl	$0, %eax
.L261:
	movl	%eax, -6976(%rbp)
	movl	-6976(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7160(%rbp)
	movq	%rdx, -6496(%rbp)
	movzwl	-7160(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6496(%rbp), %rax
	kmovw	%edx, %k3
	vmovups	(%rax), %zmm0{%k3}
	vmovaps	%zmm0, -4976(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L265
	movzwl	-7202(%rbp), %eax
	jmp	.L266
.L265:
	movl	$0, %eax
.L266:
	movl	%eax, -6972(%rbp)
	movl	-6972(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$1, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7158(%rbp)
	movq	%rdx, -6488(%rbp)
	movzwl	-7158(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6488(%rbp), %rax
	kmovw	%edx, %k4
	vmovups	(%rax), %zmm0{%k4}
	vmovaps	%zmm0, -4912(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L270
	movzwl	-7202(%rbp), %eax
	jmp	.L271
.L270:
	movl	$0, %eax
.L271:
	movl	%eax, -6968(%rbp)
	movl	-6968(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$2, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7156(%rbp)
	movq	%rdx, -6480(%rbp)
	movzwl	-7156(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6480(%rbp), %rax
	kmovw	%edx, %k5
	vmovups	(%rax), %zmm0{%k5}
	vmovaps	%zmm0, -4848(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L275
	movzwl	-7202(%rbp), %eax
	jmp	.L276
.L275:
	movl	$0, %eax
.L276:
	movl	%eax, -6964(%rbp)
	movl	-6964(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$3, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7154(%rbp)
	movq	%rdx, -6472(%rbp)
	movzwl	-7154(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6472(%rbp), %rax
	kmovw	%edx, %k6
	vmovups	(%rax), %zmm0{%k6}
	vmovaps	%zmm0, -4784(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L280
	movzwl	-7202(%rbp), %eax
	jmp	.L281
.L280:
	movl	$0, %eax
.L281:
	movl	%eax, -6960(%rbp)
	movl	-6960(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$4, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7152(%rbp)
	movq	%rdx, -6464(%rbp)
	movzwl	-7152(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6464(%rbp), %rax
	kmovw	%edx, %k7
	vmovups	(%rax), %zmm0{%k7}
	vmovaps	%zmm0, -4720(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L285
	movzwl	-7202(%rbp), %eax
	jmp	.L286
.L285:
	movl	$0, %eax
.L286:
	movl	%eax, -6956(%rbp)
	movl	-6956(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$5, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7150(%rbp)
	movq	%rdx, -6456(%rbp)
	movzwl	-7150(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6456(%rbp), %rax
	kmovw	%edx, %k1
	vmovups	(%rax), %zmm0{%k1}
	vmovaps	%zmm0, -4656(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L290
	movzwl	-7202(%rbp), %eax
	jmp	.L291
.L290:
	movl	$0, %eax
.L291:
	movl	%eax, -6952(%rbp)
	movl	-6952(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$6, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7148(%rbp)
	movq	%rdx, -6448(%rbp)
	movzwl	-7148(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6448(%rbp), %rax
	kmovw	%edx, %k2
	vmovups	(%rax), %zmm0{%k2}
	vmovaps	%zmm0, -4592(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L295
	movzwl	-7202(%rbp), %eax
	jmp	.L296
.L295:
	movl	$0, %eax
.L296:
	movl	%eax, -6948(%rbp)
	movl	-6948(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$7, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7146(%rbp)
	movq	%rdx, -6440(%rbp)
	movzwl	-7146(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6440(%rbp), %rax
	kmovw	%edx, %k3
	vmovups	(%rax), %zmm0{%k3}
	vmovaps	%zmm0, -4528(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$256, %eax
	testl	%eax, %eax
	je	.L300
	movzwl	-7202(%rbp), %eax
	jmp	.L301
.L300:
	movl	$0, %eax
.L301:
	movl	%eax, -6944(%rbp)
	movl	-6944(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$8, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7144(%rbp)
	movq	%rdx, -6432(%rbp)
	movzwl	-7144(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6432(%rbp), %rax
	kmovw	%edx, %k4
	vmovups	(%rax), %zmm0{%k4}
	vmovaps	%zmm0, -4464(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	.L305
	movzwl	-7202(%rbp), %eax
	jmp	.L306
.L305:
	movl	$0, %eax
.L306:
	movl	%eax, -6940(%rbp)
	movl	-6940(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$9, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7142(%rbp)
	movq	%rdx, -6424(%rbp)
	movzwl	-7142(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6424(%rbp), %rax
	kmovw	%edx, %k5
	vmovups	(%rax), %zmm0{%k5}
	vmovaps	%zmm0, -4400(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	.L310
	movzwl	-7202(%rbp), %eax
	jmp	.L311
.L310:
	movl	$0, %eax
.L311:
	movl	%eax, -6936(%rbp)
	movl	-6936(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$10, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7140(%rbp)
	movq	%rdx, -6416(%rbp)
	movzwl	-7140(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6416(%rbp), %rax
	kmovw	%edx, %k6
	vmovups	(%rax), %zmm0{%k6}
	vmovaps	%zmm0, -4336(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	je	.L315
	movzwl	-7202(%rbp), %eax
	jmp	.L316
.L315:
	movl	$0, %eax
.L316:
	movl	%eax, -6932(%rbp)
	movl	-6932(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$11, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7138(%rbp)
	movq	%rdx, -6408(%rbp)
	movzwl	-7138(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6408(%rbp), %rax
	kmovw	%edx, %k7
	vmovups	(%rax), %zmm0{%k7}
	vmovaps	%zmm0, -4272(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$4096, %eax
	testl	%eax, %eax
	je	.L320
	movzwl	-7202(%rbp), %eax
	jmp	.L321
.L320:
	movl	$0, %eax
.L321:
	movl	%eax, -6928(%rbp)
	movl	-6928(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$12, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7136(%rbp)
	movq	%rdx, -6400(%rbp)
	movzwl	-7136(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6400(%rbp), %rax
	kmovw	%edx, %k1
	vmovups	(%rax), %zmm0{%k1}
	vmovaps	%zmm0, -4208(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L325
	movzwl	-7202(%rbp), %eax
	jmp	.L326
.L325:
	movl	$0, %eax
.L326:
	movl	%eax, -6924(%rbp)
	movl	-6924(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$13, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7134(%rbp)
	movq	%rdx, -6392(%rbp)
	movzwl	-7134(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6392(%rbp), %rax
	kmovw	%edx, %k2
	vmovups	(%rax), %zmm0{%k2}
	vmovaps	%zmm0, -4144(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	.L330
	movzwl	-7202(%rbp), %eax
	jmp	.L331
.L330:
	movl	$0, %eax
.L331:
	movl	%eax, -6920(%rbp)
	movl	-6920(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movq	-6776(%rbp), %rax
	addq	$14, %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6784(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-7194(%rbp), %eax
	movw	%ax, -7132(%rbp)
	movq	%rdx, -6384(%rbp)
	movzwl	-7132(%rbp), %edx
	vxorps	%zmm0, %zmm0, %zmm0
	movq	-6384(%rbp), %rax
	kmovw	%edx, %k3
	vmovups	(%rax), %zmm0{%k3}
	vmovaps	%zmm0, -4080(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -1328(%rbp)
	vmovaps	-5936(%rbp), %zmm0
	vmovaps	%zmm0, -1264(%rbp)
	vmovaps	-4976(%rbp), %zmm0
	vmovaps	%zmm0, -1200(%rbp)
	vmovaps	-1328(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-1200(%rbp), %zmm2
	kmovw	%eax, %k4
	vfmadd132ps	-1264(%rbp), %zmm2, %zmm0{%k4}
	vmovaps	%zmm0, -4976(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -1520(%rbp)
	vmovaps	-5872(%rbp), %zmm0
	vmovaps	%zmm0, -1456(%rbp)
	vmovaps	-4912(%rbp), %zmm0
	vmovaps	%zmm0, -1392(%rbp)
	vmovaps	-1520(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-1392(%rbp), %zmm3
	kmovw	%eax, %k5
	vfmadd132ps	-1456(%rbp), %zmm3, %zmm0{%k5}
	vmovaps	%zmm0, -4912(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -1712(%rbp)
	vmovaps	-5808(%rbp), %zmm0
	vmovaps	%zmm0, -1648(%rbp)
	vmovaps	-4848(%rbp), %zmm0
	vmovaps	%zmm0, -1584(%rbp)
	vmovaps	-1712(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-1584(%rbp), %zmm4
	kmovw	%eax, %k6
	vfmadd132ps	-1648(%rbp), %zmm4, %zmm0{%k6}
	vmovaps	%zmm0, -4848(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -1904(%rbp)
	vmovaps	-5744(%rbp), %zmm0
	vmovaps	%zmm0, -1840(%rbp)
	vmovaps	-4784(%rbp), %zmm0
	vmovaps	%zmm0, -1776(%rbp)
	vmovaps	-1904(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-1776(%rbp), %zmm5
	kmovw	%eax, %k7
	vfmadd132ps	-1840(%rbp), %zmm5, %zmm0{%k7}
	vmovaps	%zmm0, -4784(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -2096(%rbp)
	vmovaps	-5680(%rbp), %zmm0
	vmovaps	%zmm0, -2032(%rbp)
	vmovaps	-4720(%rbp), %zmm0
	vmovaps	%zmm0, -1968(%rbp)
	vmovaps	-2096(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-1968(%rbp), %zmm6
	kmovw	%eax, %k1
	vfmadd132ps	-2032(%rbp), %zmm6, %zmm0{%k1}
	vmovaps	%zmm0, -4720(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -2288(%rbp)
	vmovaps	-5616(%rbp), %zmm0
	vmovaps	%zmm0, -2224(%rbp)
	vmovaps	-4656(%rbp), %zmm0
	vmovaps	%zmm0, -2160(%rbp)
	vmovaps	-2288(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-2160(%rbp), %zmm7
	kmovw	%eax, %k2
	vfmadd132ps	-2224(%rbp), %zmm7, %zmm0{%k2}
	vmovaps	%zmm0, -4656(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -2480(%rbp)
	vmovaps	-5552(%rbp), %zmm0
	vmovaps	%zmm0, -2416(%rbp)
	vmovaps	-4592(%rbp), %zmm0
	vmovaps	%zmm0, -2352(%rbp)
	vmovaps	-2480(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-2352(%rbp), %zmm16
	kmovw	%eax, %k3
	vfmadd132ps	-2416(%rbp), %zmm16, %zmm0{%k3}
	vmovaps	%zmm0, -4592(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -2672(%rbp)
	vmovaps	-5488(%rbp), %zmm0
	vmovaps	%zmm0, -2608(%rbp)
	vmovaps	-4528(%rbp), %zmm0
	vmovaps	%zmm0, -2544(%rbp)
	vmovaps	-2672(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-2544(%rbp), %zmm17
	kmovw	%eax, %k4
	vfmadd132ps	-2608(%rbp), %zmm17, %zmm0{%k4}
	vmovaps	%zmm0, -4528(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -2864(%rbp)
	vmovaps	-5424(%rbp), %zmm0
	vmovaps	%zmm0, -2800(%rbp)
	vmovaps	-4464(%rbp), %zmm0
	vmovaps	%zmm0, -2736(%rbp)
	vmovaps	-2864(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-2736(%rbp), %zmm18
	kmovw	%eax, %k5
	vfmadd132ps	-2800(%rbp), %zmm18, %zmm0{%k5}
	vmovaps	%zmm0, -4464(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -3056(%rbp)
	vmovaps	-5360(%rbp), %zmm0
	vmovaps	%zmm0, -2992(%rbp)
	vmovaps	-4400(%rbp), %zmm0
	vmovaps	%zmm0, -2928(%rbp)
	vmovaps	-3056(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-2928(%rbp), %zmm19
	kmovw	%eax, %k6
	vfmadd132ps	-2992(%rbp), %zmm19, %zmm0{%k6}
	vmovaps	%zmm0, -4400(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -3248(%rbp)
	vmovaps	-5296(%rbp), %zmm0
	vmovaps	%zmm0, -3184(%rbp)
	vmovaps	-4336(%rbp), %zmm0
	vmovaps	%zmm0, -3120(%rbp)
	vmovaps	-3248(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-3120(%rbp), %zmm20
	kmovw	%eax, %k7
	vfmadd132ps	-3184(%rbp), %zmm20, %zmm0{%k7}
	vmovaps	%zmm0, -4336(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -3440(%rbp)
	vmovaps	-5232(%rbp), %zmm0
	vmovaps	%zmm0, -3376(%rbp)
	vmovaps	-4272(%rbp), %zmm0
	vmovaps	%zmm0, -3312(%rbp)
	vmovaps	-3440(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-3312(%rbp), %zmm21
	kmovw	%eax, %k1
	vfmadd132ps	-3376(%rbp), %zmm21, %zmm0{%k1}
	vmovaps	%zmm0, -4272(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -3632(%rbp)
	vmovaps	-5168(%rbp), %zmm0
	vmovaps	%zmm0, -3568(%rbp)
	vmovaps	-4208(%rbp), %zmm0
	vmovaps	%zmm0, -3504(%rbp)
	vmovaps	-3632(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-3504(%rbp), %zmm22
	kmovw	%eax, %k2
	vfmadd132ps	-3568(%rbp), %zmm22, %zmm0{%k2}
	vmovaps	%zmm0, -4208(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -3824(%rbp)
	vmovaps	-5104(%rbp), %zmm0
	vmovaps	%zmm0, -3760(%rbp)
	vmovaps	-4144(%rbp), %zmm0
	vmovaps	%zmm0, -3696(%rbp)
	vmovaps	-3824(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-3696(%rbp), %zmm23
	kmovw	%eax, %k3
	vfmadd132ps	-3760(%rbp), %zmm23, %zmm0{%k3}
	vmovaps	%zmm0, -4144(%rbp)
	vmovaps	-6000(%rbp), %zmm0
	vmovaps	%zmm0, -4016(%rbp)
	vmovaps	-5040(%rbp), %zmm0
	vmovaps	%zmm0, -3952(%rbp)
	vmovaps	-4080(%rbp), %zmm0
	vmovaps	%zmm0, -3888(%rbp)
	vmovaps	-4016(%rbp), %zmm0
	movl	$-1, %eax
	vmovaps	-3888(%rbp), %zmm24
	kmovw	%eax, %k4
	vfmadd132ps	-3952(%rbp), %zmm24, %zmm0{%k4}
	vmovaps	%zmm0, -4080(%rbp)
	movzwl	-7198(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L350
	movzwl	-7202(%rbp), %eax
	jmp	.L351
.L350:
	movl	$0, %eax
.L351:
	movl	%eax, -6916(%rbp)
	movl	-6916(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6376(%rbp)
	movw	%ax, -7130(%rbp)
	vmovaps	-4976(%rbp), %zmm0
	vmovaps	%zmm0, -1136(%rbp)
	movzwl	-7130(%rbp), %edx
	movq	-6376(%rbp), %rax
	vmovaps	-1136(%rbp), %zmm0
	kmovw	%edx, %k5
	vmovups	%zmm0, (%rax){%k5}
	movzwl	-7198(%rbp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L353
	movzwl	-7202(%rbp), %eax
	jmp	.L354
.L353:
	movl	$0, %eax
.L354:
	movl	%eax, -6912(%rbp)
	movl	-6912(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$1, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6368(%rbp)
	movw	%ax, -7128(%rbp)
	vmovaps	-4912(%rbp), %zmm0
	vmovaps	%zmm0, -1072(%rbp)
	movzwl	-7128(%rbp), %edx
	movq	-6368(%rbp), %rax
	vmovaps	-1072(%rbp), %zmm0
	kmovw	%edx, %k6
	vmovups	%zmm0, (%rax){%k6}
	movzwl	-7198(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L356
	movzwl	-7202(%rbp), %eax
	jmp	.L357
.L356:
	movl	$0, %eax
.L357:
	movl	%eax, -6908(%rbp)
	movl	-6908(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$2, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6360(%rbp)
	movw	%ax, -7126(%rbp)
	vmovaps	-4848(%rbp), %zmm0
	vmovaps	%zmm0, -1008(%rbp)
	movzwl	-7126(%rbp), %edx
	movq	-6360(%rbp), %rax
	vmovaps	-1008(%rbp), %zmm0
	kmovw	%edx, %k7
	vmovups	%zmm0, (%rax){%k7}
	movzwl	-7198(%rbp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L359
	movzwl	-7202(%rbp), %eax
	jmp	.L360
.L359:
	movl	$0, %eax
.L360:
	movl	%eax, -6904(%rbp)
	movl	-6904(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$3, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6352(%rbp)
	movw	%ax, -7124(%rbp)
	vmovaps	-4784(%rbp), %zmm0
	vmovaps	%zmm0, -944(%rbp)
	movzwl	-7124(%rbp), %edx
	movq	-6352(%rbp), %rax
	vmovaps	-944(%rbp), %zmm0
	kmovw	%edx, %k1
	vmovups	%zmm0, (%rax){%k1}
	movzwl	-7198(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L362
	movzwl	-7202(%rbp), %eax
	jmp	.L363
.L362:
	movl	$0, %eax
.L363:
	movl	%eax, -6900(%rbp)
	movl	-6900(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$4, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6344(%rbp)
	movw	%ax, -7122(%rbp)
	vmovaps	-4720(%rbp), %zmm0
	vmovaps	%zmm0, -880(%rbp)
	movzwl	-7122(%rbp), %edx
	movq	-6344(%rbp), %rax
	vmovaps	-880(%rbp), %zmm0
	kmovw	%edx, %k2
	vmovups	%zmm0, (%rax){%k2}
	movzwl	-7198(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L365
	movzwl	-7202(%rbp), %eax
	jmp	.L366
.L365:
	movl	$0, %eax
.L366:
	movl	%eax, -6896(%rbp)
	movl	-6896(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$5, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6336(%rbp)
	movw	%ax, -7120(%rbp)
	vmovaps	-4656(%rbp), %zmm0
	vmovaps	%zmm0, -816(%rbp)
	movzwl	-7120(%rbp), %edx
	movq	-6336(%rbp), %rax
	vmovaps	-816(%rbp), %zmm0
	kmovw	%edx, %k3
	vmovups	%zmm0, (%rax){%k3}
	movzwl	-7198(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L368
	movzwl	-7202(%rbp), %eax
	jmp	.L369
.L368:
	movl	$0, %eax
.L369:
	movl	%eax, -6892(%rbp)
	movl	-6892(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$6, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6328(%rbp)
	movw	%ax, -7118(%rbp)
	vmovaps	-4592(%rbp), %zmm0
	vmovaps	%zmm0, -752(%rbp)
	movzwl	-7118(%rbp), %edx
	movq	-6328(%rbp), %rax
	vmovaps	-752(%rbp), %zmm0
	kmovw	%edx, %k4
	vmovups	%zmm0, (%rax){%k4}
	movzwl	-7198(%rbp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L371
	movzwl	-7202(%rbp), %eax
	jmp	.L372
.L371:
	movl	$0, %eax
.L372:
	movl	%eax, -6888(%rbp)
	movl	-6888(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$7, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6320(%rbp)
	movw	%ax, -7116(%rbp)
	vmovaps	-4528(%rbp), %zmm0
	vmovaps	%zmm0, -688(%rbp)
	movzwl	-7116(%rbp), %edx
	movq	-6320(%rbp), %rax
	vmovaps	-688(%rbp), %zmm0
	kmovw	%edx, %k5
	vmovups	%zmm0, (%rax){%k5}
	movzwl	-7198(%rbp), %eax
	andl	$256, %eax
	testl	%eax, %eax
	je	.L374
	movzwl	-7202(%rbp), %eax
	jmp	.L375
.L374:
	movl	$0, %eax
.L375:
	movl	%eax, -6884(%rbp)
	movl	-6884(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$8, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6312(%rbp)
	movw	%ax, -7114(%rbp)
	vmovaps	-4464(%rbp), %zmm0
	vmovaps	%zmm0, -624(%rbp)
	movzwl	-7114(%rbp), %edx
	movq	-6312(%rbp), %rax
	vmovaps	-624(%rbp), %zmm0
	kmovw	%edx, %k6
	vmovups	%zmm0, (%rax){%k6}
	movzwl	-7198(%rbp), %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	.L377
	movzwl	-7202(%rbp), %eax
	jmp	.L378
.L377:
	movl	$0, %eax
.L378:
	movl	%eax, -6880(%rbp)
	movl	-6880(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$9, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6304(%rbp)
	movw	%ax, -7112(%rbp)
	vmovaps	-4400(%rbp), %zmm0
	vmovaps	%zmm0, -560(%rbp)
	movzwl	-7112(%rbp), %edx
	movq	-6304(%rbp), %rax
	vmovaps	-560(%rbp), %zmm0
	kmovw	%edx, %k7
	vmovups	%zmm0, (%rax){%k7}
	movzwl	-7198(%rbp), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	.L380
	movzwl	-7202(%rbp), %eax
	jmp	.L381
.L380:
	movl	$0, %eax
.L381:
	movl	%eax, -6876(%rbp)
	movl	-6876(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$10, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6296(%rbp)
	movw	%ax, -7110(%rbp)
	vmovaps	-4336(%rbp), %zmm0
	vmovaps	%zmm0, -496(%rbp)
	movzwl	-7110(%rbp), %edx
	movq	-6296(%rbp), %rax
	vmovaps	-496(%rbp), %zmm0
	kmovw	%edx, %k1
	vmovups	%zmm0, (%rax){%k1}
	movzwl	-7198(%rbp), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	je	.L383
	movzwl	-7202(%rbp), %eax
	jmp	.L384
.L383:
	movl	$0, %eax
.L384:
	movl	%eax, -6872(%rbp)
	movl	-6872(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$11, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6288(%rbp)
	movw	%ax, -7108(%rbp)
	vmovaps	-4272(%rbp), %zmm0
	vmovaps	%zmm0, -432(%rbp)
	movzwl	-7108(%rbp), %edx
	movq	-6288(%rbp), %rax
	vmovaps	-432(%rbp), %zmm0
	kmovw	%edx, %k2
	vmovups	%zmm0, (%rax){%k2}
	movzwl	-7198(%rbp), %eax
	andl	$4096, %eax
	testl	%eax, %eax
	je	.L386
	movzwl	-7202(%rbp), %eax
	jmp	.L387
.L386:
	movl	$0, %eax
.L387:
	movl	%eax, -6868(%rbp)
	movl	-6868(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$12, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6280(%rbp)
	movw	%ax, -7106(%rbp)
	vmovaps	-4208(%rbp), %zmm0
	vmovaps	%zmm0, -368(%rbp)
	movzwl	-7106(%rbp), %edx
	movq	-6280(%rbp), %rax
	vmovaps	-368(%rbp), %zmm0
	kmovw	%edx, %k3
	vmovups	%zmm0, (%rax){%k3}
	movzwl	-7198(%rbp), %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L389
	movzwl	-7202(%rbp), %eax
	jmp	.L390
.L389:
	movl	$0, %eax
.L390:
	movl	%eax, -6864(%rbp)
	movl	-6864(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$13, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6272(%rbp)
	movw	%ax, -7104(%rbp)
	vmovaps	-4144(%rbp), %zmm0
	vmovaps	%zmm0, -304(%rbp)
	movzwl	-7104(%rbp), %edx
	movq	-6272(%rbp), %rax
	vmovaps	-304(%rbp), %zmm0
	kmovw	%edx, %k4
	vmovups	%zmm0, (%rax){%k4}
	movzwl	-7198(%rbp), %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	.L392
	movzwl	-7202(%rbp), %eax
	jmp	.L393
.L392:
	movl	$0, %eax
.L393:
	movl	%eax, -6860(%rbp)
	movl	-6860(%rbp), %eax
	movw	%ax, -7194(%rbp)
	movzwl	-7194(%rbp), %eax
	movq	-6776(%rbp), %rdx
	addq	$14, %rdx
	movq	%rdx, %rcx
	imulq	-7232(%rbp), %rcx
	movq	-6784(%rbp), %rdx
	addq	%rcx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-6752(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, -6264(%rbp)
	movw	%ax, -7102(%rbp)
	vmovaps	-4080(%rbp), %zmm0
	vmovaps	%zmm0, -240(%rbp)
	movzwl	-7102(%rbp), %edx
	movq	-6264(%rbp), %rax
	vmovaps	-240(%rbp), %zmm0
	kmovw	%edx, %k5
	vmovups	%zmm0, (%rax){%k5}
	addq	$15, -6776(%rbp)
	jmp	.L395
.L137:
	addq	$16, -6784(%rbp)
	jmp	.L396
.L131:
	addq	$1, -6792(%rbp)
	jmp	.L397
.L130:
	movq	$0, -6768(%rbp)
.L401:
	movq	-6768(%rbp), %rax
	cmpq	-7240(%rbp), %rax
	jnb	.L398
	movq	$0, -6760(%rbp)
.L400:
	movq	-6760(%rbp), %rax
	cmpq	-7232(%rbp), %rax
	jnb	.L399
	movq	-6768(%rbp), %rax
	imulq	-7232(%rbp), %rax
	movq	%rax, %rdx
	movq	-6760(%rbp), %rax
	addq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movq	-6752(%rbp), %rax
	addq	%rax, %rdx
	movq	-6760(%rbp), %rax
	imulq	-7240(%rbp), %rax
	movq	%rax, %rcx
	movq	-6768(%rbp), %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rcx
	movq	-7280(%rbp), %rax
	addq	%rcx, %rax
	vmovss	(%rdx), %xmm0
	vmovss	%xmm0, (%rax)
	addq	$1, -6760(%rbp)
	jmp	.L400
.L399:
	addq	$1, -6768(%rbp)
	jmp	.L401
.L398:
	cmpq	$0, -6856(%rbp)
	jne	.L402
	movq	-6816(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
.L402:
	movq	-6752(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-56(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L411
	jmp	.L420
.L412:
	movq	%rax, %rbx
	leaq	-7203(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB21:
	call	_Unwind_Resume@PLT
.L414:
	movq	%rax, %r12
	leaq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	jmp	.L405
.L413:
	movq	%rax, %r12
.L405:
	movq	%rbx, %rdi
	call	__cxa_free_exception@PLT
	movq	%r12, %rbx
	jmp	.L406
.L415:
	movq	%rax, %rbx
.L406:
	leaq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
	call	_Unwind_Resume@PLT
.L416:
	movq	%rax, %rbx
	leaq	-7203(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
	call	_Unwind_Resume@PLT
.L418:
	movq	%rax, %r12
	leaq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	jmp	.L409
.L417:
	movq	%rax, %r12
.L409:
	movq	%rbx, %rdi
	call	__cxa_free_exception@PLT
	movq	%r12, %rbx
	jmp	.L410
.L419:
	movq	%rax, %rbx
.L410:
	leaq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
	call	_Unwind_Resume@PLT
.LEHE21:
.L420:
	call	__stack_chk_fail@PLT
.L411:
	addq	$7256, %rsp
	popq	%rbx
	popq	%r10
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8862:
	.section	.gcc_except_table
.LLSDA8862:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8862-.LLSDACSB8862
.LLSDACSB8862:
	.uleb128 .LEHB13-.LFB8862
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L412-.LFB8862
	.uleb128 0
	.uleb128 .LEHB14-.LFB8862
	.uleb128 .LEHE14-.LEHB14
	.uleb128 .L413-.LFB8862
	.uleb128 0
	.uleb128 .LEHB15-.LFB8862
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L414-.LFB8862
	.uleb128 0
	.uleb128 .LEHB16-.LFB8862
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L415-.LFB8862
	.uleb128 0
	.uleb128 .LEHB17-.LFB8862
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L416-.LFB8862
	.uleb128 0
	.uleb128 .LEHB18-.LFB8862
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L417-.LFB8862
	.uleb128 0
	.uleb128 .LEHB19-.LFB8862
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L418-.LFB8862
	.uleb128 0
	.uleb128 .LEHB20-.LFB8862
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L419-.LFB8862
	.uleb128 0
	.uleb128 .LEHB21-.LFB8862
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
.LLSDACSE8862:
	.section	.text._Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m,"axG",@progbits,_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m,comdat
	.size	_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m, .-_Z4gemmIfEmccmmmT_PS0_mS1_mS0_S1_m
	.section	.text._ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_,"axG",@progbits,_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_,comdat
	.weak	_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_
	.type	_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_, @function
_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_:
.LFB8863:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L423
	call	__stack_chk_fail@PLT
.L423:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8863:
	.size	_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_, .-_ZN7testing8internal8EqHelper7CompareIffLPv0EEENS_15AssertionResultEPKcS6_RKT_RKT0_
	.section	.text._ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv,"axG",@progbits,_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv,comdat
	.align 2
	.weak	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	.type	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv, @function
_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv:
.LFB9040:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9040:
	.size	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv, .-_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	.section	.text._ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv,"axG",@progbits,_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv,comdat
	.align 2
	.weak	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv
	.type	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv, @function
_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv:
.LFB9041:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9041:
	.size	_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv, .-_ZNSt10unique_ptrINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv
	.section	.text._ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_,"axG",@progbits,_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_,comdat
	.align 2
	.weak	_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_
	.type	_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_, @function
_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_:
.LFB9042:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L430
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rdi
	call	*%rax
.L430:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9042:
	.size	_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_, .-_ZNKSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEclEPS5_
	.section	.text._ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv,"axG",@progbits,_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv,comdat
	.align 2
	.weak	_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	.type	_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv, @function
_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv:
.LFB9159:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_
	movq	(%rax), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9159:
	.size	_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv, .-_ZNKSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	.section	.text._ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv,"axG",@progbits,_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv,comdat
	.align 2
	.weak	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	.type	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv, @function
_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv:
.LFB9160:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9160:
	.size	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv, .-_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE6_M_ptrEv
	.section	.text._ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv,"axG",@progbits,_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv,comdat
	.align 2
	.weak	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv
	.type	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv, @function
_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv:
.LFB9163:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9163:
	.size	_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv, .-_ZNSt10unique_ptrINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE11get_deleterEv
	.section	.text._ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_,"axG",@progbits,_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_,comdat
	.align 2
	.weak	_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_
	.type	_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_, @function
_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_:
.LFB9164:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rbx
	testq	%rbx, %rbx
	je	.L439
	movq	%rbx, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movl	$32, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L439:
	nop
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9164:
	.size	_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_, .-_ZNKSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEclEPS5_
	.section	.text._ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_,"axG",@progbits,_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_,comdat
	.weak	_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_
	.type	_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_, @function
_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_:
.LFB9169:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-48(%rbp), %rax
	vmovss	(%rax), %xmm0
	movq	-56(%rbp), %rax
	vmovss	(%rax), %xmm1
	vucomiss	%xmm1, %xmm0
	jp	.L441
	vucomiss	%xmm1, %xmm0
	jne	.L441
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing16AssertionSuccessEv@PLT
	jmp	.L440
.L441:
	movq	-24(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rsi
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_
.L440:
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L444
	call	__stack_chk_fail@PLT
.L444:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9169:
	.size	_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_, .-_ZN7testing8internal11CmpHelperEQIffEENS_15AssertionResultEPKcS4_RKT_RKT0_
	.section	.text._ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,"axG",@progbits,_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,comdat
	.weak	_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.type	_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, @function
_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_:
.LFB9222:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9222:
	.size	_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, .-_ZSt3getILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.section	.text._ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv,"axG",@progbits,_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv,comdat
	.align 2
	.weak	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv
	.type	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv, @function
_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv:
.LFB9223:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9223:
	.size	_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv, .-_ZNSt15__uniq_ptr_implINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv
	.section	.text._ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_,"axG",@progbits,_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_,comdat
	.weak	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_
	.type	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_, @function
_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_:
.LFB9340:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9340:
	.size	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_, .-_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKSD_
	.section	.text._ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,"axG",@progbits,_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,comdat
	.weak	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.type	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, @function
_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_:
.LFB9341:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9341:
	.size	_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, .-_ZSt3getILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.section	.text._ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv,"axG",@progbits,_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv,comdat
	.align 2
	.weak	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv
	.type	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv, @function
_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv:
.LFB9342:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9342:
	.size	_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv, .-_ZNSt15__uniq_ptr_implINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EE10_M_deleterEv
	.section	.text._ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_,"axG",@progbits,_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_,comdat
	.weak	_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_
	.type	_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_, @function
_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_:
.LFB9344:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA9344
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$136, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rdx, -120(%rbp)
	movq	%rcx, -128(%rbp)
	movq	%r8, -136(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	-64(%rbp), %rax
	movq	-128(%rbp), %rdx
	movq	-136(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB22:
	call	_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_
.LEHE22:
	leaq	-96(%rbp), %rax
	movq	-136(%rbp), %rdx
	movq	-128(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB23:
	call	_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_
.LEHE23:
	movq	-104(%rbp), %rax
	leaq	-64(%rbp), %rdi
	leaq	-96(%rbp), %rcx
	movq	-120(%rbp), %rdx
	movq	-112(%rbp), %rsi
	movl	$0, %r9d
	movq	%rdi, %r8
	movq	%rax, %rdi
.LEHB24:
	call	_ZN7testing8internal9EqFailureEPKcS2_RKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESA_b@PLT
.LEHE24:
	leaq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	-104(%rbp), %rax
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L460
	jmp	.L463
.L462:
	movq	%rax, %rbx
	leaq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	jmp	.L459
.L461:
	movq	%rax, %rbx
.L459:
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB25:
	call	_Unwind_Resume@PLT
.LEHE25:
.L463:
	call	__stack_chk_fail@PLT
.L460:
	addq	$136, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9344:
	.section	.gcc_except_table
.LLSDA9344:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE9344-.LLSDACSB9344
.LLSDACSB9344:
	.uleb128 .LEHB22-.LFB9344
	.uleb128 .LEHE22-.LEHB22
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB23-.LFB9344
	.uleb128 .LEHE23-.LEHB23
	.uleb128 .L461-.LFB9344
	.uleb128 0
	.uleb128 .LEHB24-.LFB9344
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L462-.LFB9344
	.uleb128 0
	.uleb128 .LEHB25-.LFB9344
	.uleb128 .LEHE25-.LEHB25
	.uleb128 0
	.uleb128 0
.LLSDACSE9344:
	.section	.text._ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_,"axG",@progbits,_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_,comdat
	.size	_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_, .-_ZN7testing8internal18CmpHelperEQFailureIffEENS_15AssertionResultEPKcS4_RKT_RKT0_
	.section	.text._ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE,"axG",@progbits,_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE,comdat
	.weak	_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE
	.type	_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE, @function
_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE:
.LFB9377:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9377:
	.size	_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE, .-_ZSt12__get_helperILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE
	.section	.text._ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,"axG",@progbits,_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,comdat
	.weak	_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.type	_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, @function
_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_:
.LFB9378:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9378:
	.size	_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, .-_ZSt3getILm1EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.section	.text._ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE,"axG",@progbits,_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE,comdat
	.weak	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE
	.type	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE, @function
_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE:
.LFB9465:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9465:
	.size	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE, .-_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERKT0_RKSt11_Tuple_implIXT_EJS9_DpT1_EE
	.section	.text._ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE,"axG",@progbits,_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE,comdat
	.weak	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE
	.type	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE, @function
_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE:
.LFB9466:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9466:
	.size	_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE, .-_ZSt12__get_helperILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEJSt14default_deleteIS5_EEERT0_RSt11_Tuple_implIXT_EJS9_DpT1_EE
	.section	.text._ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,"axG",@progbits,_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_,comdat
	.weak	_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.type	_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, @function
_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_:
.LFB9467:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9467:
	.size	_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_, .-_ZSt3getILm1EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERSD_
	.section	.text._ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_,"axG",@progbits,_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_,comdat
	.weak	_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_
	.type	_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_, @function
_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_:
.LFB9469:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L476
	call	__stack_chk_fail@PLT
.L476:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9469:
	.size	_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_, .-_ZN7testing8internal33FormatForComparisonFailureMessageIffEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_RKT0_
	.section	.text._ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_,"axG",@progbits,_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_,comdat
	.weak	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_
	.type	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_, @function
_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_:
.LFB9510:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9510:
	.size	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_, .-_ZNSt11_Tuple_implILm0EJPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_
	.section	.text._ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE,"axG",@progbits,_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE,comdat
	.weak	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE
	.type	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE, @function
_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE:
.LFB9511:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9511:
	.size	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE, .-_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE
	.section	.text._ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_,"axG",@progbits,_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_,comdat
	.weak	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_
	.type	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_, @function
_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_:
.LFB9575:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9575:
	.size	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_, .-_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERKS9_
	.section	.text._ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_,"axG",@progbits,_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_,comdat
	.weak	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_
	.type	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_, @function
_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_:
.LFB9576:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9576:
	.size	_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_, .-_ZNSt11_Tuple_implILm0EJPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt14default_deleteIS5_EEE7_M_headERS9_
	.section	.text._ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE,"axG",@progbits,_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE,comdat
	.weak	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE
	.type	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE, @function
_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE:
.LFB9577:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9577:
	.size	_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE, .-_ZSt12__get_helperILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEJEERT0_RSt11_Tuple_implIXT_EJS8_DpT1_EE
	.section	.text._ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf,"axG",@progbits,_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf,comdat
	.weak	_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf
	.type	_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf, @function
_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf:
.LFB9579:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L489
	call	__stack_chk_fail@PLT
.L489:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9579:
	.size	_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf, .-_ZN7testing8internal19FormatForComparisonIffE6FormatB5cxx11ERKf
	.section	.text._ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_,"axG",@progbits,_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_,comdat
	.weak	_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_
	.type	_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_, @function
_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_:
.LFB9603:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9603:
	.size	_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_, .-_ZNSt10_Head_baseILm0EPNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_
	.section	.text._ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_,"axG",@progbits,_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_,comdat
	.weak	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_
	.type	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_, @function
_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_:
.LFB9604:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9604:
	.size	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_, .-_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_
	.section	.text._ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_,"axG",@progbits,_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_,comdat
	.weak	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_
	.type	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_, @function
_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_:
.LFB9650:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9650:
	.size	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_, .-_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERKS7_
	.section	.text._ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_,"axG",@progbits,_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_,comdat
	.weak	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_
	.type	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_, @function
_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_:
.LFB9651:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9651:
	.size	_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_, .-_ZNSt10_Head_baseILm0EPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEELb0EE7_M_headERS7_
	.section	.text._ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_,"axG",@progbits,_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_,comdat
	.weak	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_
	.type	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_, @function
_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_:
.LFB9652:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9652:
	.size	_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_, .-_ZNSt11_Tuple_implILm1EJSt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEEEE7_M_headERS8_
	.section	.text._ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_,"axG",@progbits,_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_,comdat
	.weak	_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_
	.type	_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_, @function
_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_:
.LFB9654:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA9654
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$424, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -424(%rbp)
	movq	%rsi, -432(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$8, %esi
	movl	$16, %edi
	call	_ZStorSt13_Ios_OpenmodeS_
	movl	%eax, %edx
	leaq	-416(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
.LEHB26:
	call	_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode@PLT
.LEHE26:
	leaq	-416(%rbp), %rax
	leaq	16(%rax), %rdx
	movq	-432(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB27:
	call	_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo
	movq	-424(%rbp), %rax
	leaq	-416(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNKSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv@PLT
.LEHE27:
	nop
	leaq	-416(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev@PLT
	nop
	movq	-424(%rbp), %rax
	movq	-24(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L503
	jmp	.L505
.L504:
	movq	%rax, %rbx
	leaq	-416(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB28:
	call	_Unwind_Resume@PLT
.LEHE28:
.L505:
	call	__stack_chk_fail@PLT
.L503:
	addq	$424, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9654:
	.section	.gcc_except_table
.LLSDA9654:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE9654-.LLSDACSB9654
.LLSDACSB9654:
	.uleb128 .LEHB26-.LFB9654
	.uleb128 .LEHE26-.LEHB26
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB27-.LFB9654
	.uleb128 .LEHE27-.LEHB27
	.uleb128 .L504-.LFB9654
	.uleb128 0
	.uleb128 .LEHB28-.LFB9654
	.uleb128 .LEHE28-.LEHB28
	.uleb128 0
	.uleb128 0
.LLSDACSE9654:
	.section	.text._ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_,"axG",@progbits,_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_,comdat
	.size	_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_, .-_ZN7testing13PrintToStringIfEENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKT_
	.section	.text._ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_,"axG",@progbits,_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_,comdat
	.weak	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_
	.type	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_, @function
_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_:
.LFB9662:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9662:
	.size	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_, .-_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_
	.section	.text._ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_,"axG",@progbits,_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_,comdat
	.weak	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_
	.type	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_, @function
_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_:
.LFB9682:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9682:
	.size	_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_, .-_ZNSt10_Head_baseILm1ESt14default_deleteINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEELb1EE7_M_headERS8_
	.section	.text._ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo,"axG",@progbits,_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo,comdat
	.weak	_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo
	.type	_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo, @function
_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo:
.LFB9683:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9683:
	.size	_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo, .-_ZN7testing8internal21UniversalTersePrinterIfE5PrintERKfPSo
	.section	.text._ZN7testing8internal14UniversalPrintIfEEvRKT_PSo,"axG",@progbits,_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo,comdat
	.weak	_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo
	.type	_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo, @function
_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo:
.LFB9693:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9693:
	.size	_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo, .-_ZN7testing8internal14UniversalPrintIfEEvRKT_PSo
	.section	.text._ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo,"axG",@progbits,_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo,comdat
	.weak	_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo
	.type	_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo, @function
_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo:
.LFB9701:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal7PrintToIfEEvRKT_PSo
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9701:
	.size	_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo, .-_ZN7testing8internal16UniversalPrinterIfE5PrintERKfPSo
	.section	.text._ZN7testing8internal7PrintToIfEEvRKT_PSo,"axG",@progbits,_ZN7testing8internal7PrintToIfEEvRKT_PSo,comdat
	.weak	_ZN7testing8internal7PrintToIfEEvRKT_PSo
	.type	_ZN7testing8internal7PrintToIfEEvRKT_PSo, @function
_ZN7testing8internal7PrintToIfEEvRKT_PSo:
.LFB9704:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9704:
	.size	_ZN7testing8internal7PrintToIfEEvRKT_PSo, .-_ZN7testing8internal7PrintToIfEEvRKT_PSo
	.section	.text._ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo,"axG",@progbits,_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo,comdat
	.weak	_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo
	.type	_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo, @function
_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo:
.LFB9706:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9706:
	.size	_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo, .-_ZN7testing8internal17PrintWithFallbackIfEEvRKT_PSo
	.section	.text._ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo,"axG",@progbits,_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo,comdat
	.weak	_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo
	.type	_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo, @function
_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo:
.LFB9708:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %edx
	movq	-16(%rbp), %rax
	vmovd	%edx, %xmm0
	movq	%rax, %rdi
	call	_ZNSolsEf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9708:
	.size	_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo, .-_ZN7testing8internal13StreamPrinter10PrintValueIfvEEvRKT_PSo
	.weak	_ZTV13GEMM_ASM_Test
	.section	.data.rel.ro._ZTV13GEMM_ASM_Test,"awG",@progbits,_ZTV13GEMM_ASM_Test,comdat
	.align 8
	.type	_ZTV13GEMM_ASM_Test, @object
	.size	_ZTV13GEMM_ASM_Test, 64
_ZTV13GEMM_ASM_Test:
	.quad	0
	.quad	_ZTI13GEMM_ASM_Test
	.quad	_ZN13GEMM_ASM_TestD1Ev
	.quad	_ZN13GEMM_ASM_TestD0Ev
	.quad	_ZN7testing4Test5SetUpEv
	.quad	_ZN7testing4Test8TearDownEv
	.quad	_ZN13GEMM_ASM_Test8TestBodyEv
	.quad	_ZN7testing4Test5SetupEv
	.section	.text._ZN13GEMM_ASM_TestD2Ev,"axG",@progbits,_ZN13GEMM_ASM_TestD5Ev,comdat
	.align 2
	.weak	_ZN13GEMM_ASM_TestD2Ev
	.type	_ZN13GEMM_ASM_TestD2Ev, @function
_ZN13GEMM_ASM_TestD2Ev:
.LFB9730:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	16+_ZTV13GEMM_ASM_Test(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing4TestD2Ev@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9730:
	.size	_ZN13GEMM_ASM_TestD2Ev, .-_ZN13GEMM_ASM_TestD2Ev
	.weak	_ZN13GEMM_ASM_TestD1Ev
	.set	_ZN13GEMM_ASM_TestD1Ev,_ZN13GEMM_ASM_TestD2Ev
	.section	.text._ZN13GEMM_ASM_TestD0Ev,"axG",@progbits,_ZN13GEMM_ASM_TestD5Ev,comdat
	.align 2
	.weak	_ZN13GEMM_ASM_TestD0Ev
	.type	_ZN13GEMM_ASM_TestD0Ev, @function
_ZN13GEMM_ASM_TestD0Ev:
.LFB9732:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN13GEMM_ASM_TestD1Ev
	movq	-8(%rbp), %rax
	movl	$16, %esi
	movq	%rax, %rdi
	call	_ZdlPvm@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9732:
	.size	_ZN13GEMM_ASM_TestD0Ev, .-_ZN13GEMM_ASM_TestD0Ev
	.weak	_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE
	.section	.data.rel.ro.local._ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE,"awG",@progbits,_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE,comdat
	.align 8
	.type	_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE, @object
	.size	_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE, 40
_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE:
	.quad	0
	.quad	_ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE
	.quad	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED1Ev
	.quad	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev
	.quad	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev:
.LFB9734:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	16+_ZTVN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryBaseD2Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9734:
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev, .-_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED1Ev
	.set	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED1Ev,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED2Ev
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev:
.LFB9736:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED1Ev
	movq	-8(%rbp), %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	_ZdlPvm@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9736:
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev, .-_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestED0Ev
	.weak	_ZTV13GEMM_CPP_Test
	.section	.data.rel.ro._ZTV13GEMM_CPP_Test,"awG",@progbits,_ZTV13GEMM_CPP_Test,comdat
	.align 8
	.type	_ZTV13GEMM_CPP_Test, @object
	.size	_ZTV13GEMM_CPP_Test, 64
_ZTV13GEMM_CPP_Test:
	.quad	0
	.quad	_ZTI13GEMM_CPP_Test
	.quad	_ZN13GEMM_CPP_TestD1Ev
	.quad	_ZN13GEMM_CPP_TestD0Ev
	.quad	_ZN7testing4Test5SetUpEv
	.quad	_ZN7testing4Test8TearDownEv
	.quad	_ZN13GEMM_CPP_Test8TestBodyEv
	.quad	_ZN7testing4Test5SetupEv
	.section	.text._ZN13GEMM_CPP_TestD2Ev,"axG",@progbits,_ZN13GEMM_CPP_TestD5Ev,comdat
	.align 2
	.weak	_ZN13GEMM_CPP_TestD2Ev
	.type	_ZN13GEMM_CPP_TestD2Ev, @function
_ZN13GEMM_CPP_TestD2Ev:
.LFB9738:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	16+_ZTV13GEMM_CPP_Test(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing4TestD2Ev@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9738:
	.size	_ZN13GEMM_CPP_TestD2Ev, .-_ZN13GEMM_CPP_TestD2Ev
	.weak	_ZN13GEMM_CPP_TestD1Ev
	.set	_ZN13GEMM_CPP_TestD1Ev,_ZN13GEMM_CPP_TestD2Ev
	.section	.text._ZN13GEMM_CPP_TestD0Ev,"axG",@progbits,_ZN13GEMM_CPP_TestD5Ev,comdat
	.align 2
	.weak	_ZN13GEMM_CPP_TestD0Ev
	.type	_ZN13GEMM_CPP_TestD0Ev, @function
_ZN13GEMM_CPP_TestD0Ev:
.LFB9740:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN13GEMM_CPP_TestD1Ev
	movq	-8(%rbp), %rax
	movl	$16, %esi
	movq	%rax, %rdi
	call	_ZdlPvm@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9740:
	.size	_ZN13GEMM_CPP_TestD0Ev, .-_ZN13GEMM_CPP_TestD0Ev
	.weak	_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE
	.section	.data.rel.ro.local._ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE,"awG",@progbits,_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE,comdat
	.align 8
	.type	_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE, @object
	.size	_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE, 40
_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE:
	.quad	0
	.quad	_ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE
	.quad	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED1Ev
	.quad	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev
	.quad	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev:
.LFB9742:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	leaq	16+_ZTVN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryBaseD2Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9742:
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev, .-_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED1Ev
	.set	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED1Ev,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED2Ev
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED5Ev,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev:
.LFB9744:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED1Ev
	movq	-8(%rbp), %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	_ZdlPvm@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9744:
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev, .-_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestED0Ev
	.weak	_ZTVN7testing8internal15TestFactoryBaseE
	.section	.data.rel.ro._ZTVN7testing8internal15TestFactoryBaseE,"awG",@progbits,_ZTVN7testing8internal15TestFactoryBaseE,comdat
	.align 8
	.type	_ZTVN7testing8internal15TestFactoryBaseE, @object
	.size	_ZTVN7testing8internal15TestFactoryBaseE, 40
_ZTVN7testing8internal15TestFactoryBaseE:
	.quad	0
	.quad	_ZTIN7testing8internal15TestFactoryBaseE
	.quad	0
	.quad	0
	.quad	__cxa_pure_virtual
	.weak	_ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE
	.section	.data.rel.ro._ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE,"awG",@progbits,_ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE,comdat
	.align 8
	.type	_ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE, @object
	.size	_ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE, 24
_ZTIN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE
	.quad	_ZTIN7testing8internal15TestFactoryBaseE
	.weak	_ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE
	.section	.rodata._ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE,"aG",@progbits,_ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE,comdat
	.align 32
	.type	_ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE, @object
	.size	_ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE, 54
_ZTSN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE:
	.string	"N7testing8internal15TestFactoryImplI13GEMM_ASM_TestEE"
	.weak	_ZTI13GEMM_ASM_Test
	.section	.data.rel.ro._ZTI13GEMM_ASM_Test,"awG",@progbits,_ZTI13GEMM_ASM_Test,comdat
	.align 8
	.type	_ZTI13GEMM_ASM_Test, @object
	.size	_ZTI13GEMM_ASM_Test, 24
_ZTI13GEMM_ASM_Test:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTS13GEMM_ASM_Test
	.quad	_ZTIN7testing4TestE
	.weak	_ZTS13GEMM_ASM_Test
	.section	.rodata._ZTS13GEMM_ASM_Test,"aG",@progbits,_ZTS13GEMM_ASM_Test,comdat
	.align 16
	.type	_ZTS13GEMM_ASM_Test, @object
	.size	_ZTS13GEMM_ASM_Test, 16
_ZTS13GEMM_ASM_Test:
	.string	"13GEMM_ASM_Test"
	.weak	_ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE
	.section	.data.rel.ro._ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE,"awG",@progbits,_ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE,comdat
	.align 8
	.type	_ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE, @object
	.size	_ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE, 24
_ZTIN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE
	.quad	_ZTIN7testing8internal15TestFactoryBaseE
	.weak	_ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE
	.section	.rodata._ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE,"aG",@progbits,_ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE,comdat
	.align 32
	.type	_ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE, @object
	.size	_ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE, 54
_ZTSN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE:
	.string	"N7testing8internal15TestFactoryImplI13GEMM_CPP_TestEE"
	.weak	_ZTI13GEMM_CPP_Test
	.section	.data.rel.ro._ZTI13GEMM_CPP_Test,"awG",@progbits,_ZTI13GEMM_CPP_Test,comdat
	.align 8
	.type	_ZTI13GEMM_CPP_Test, @object
	.size	_ZTI13GEMM_CPP_Test, 24
_ZTI13GEMM_CPP_Test:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTS13GEMM_CPP_Test
	.quad	_ZTIN7testing4TestE
	.weak	_ZTS13GEMM_CPP_Test
	.section	.rodata._ZTS13GEMM_CPP_Test,"aG",@progbits,_ZTS13GEMM_CPP_Test,comdat
	.align 16
	.type	_ZTS13GEMM_CPP_Test, @object
	.size	_ZTS13GEMM_CPP_Test, 16
_ZTS13GEMM_CPP_Test:
	.string	"13GEMM_CPP_Test"
	.weak	_ZTIN7testing8internal15TestFactoryBaseE
	.section	.data.rel.ro._ZTIN7testing8internal15TestFactoryBaseE,"awG",@progbits,_ZTIN7testing8internal15TestFactoryBaseE,comdat
	.align 8
	.type	_ZTIN7testing8internal15TestFactoryBaseE, @object
	.size	_ZTIN7testing8internal15TestFactoryBaseE, 16
_ZTIN7testing8internal15TestFactoryBaseE:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	_ZTSN7testing8internal15TestFactoryBaseE
	.weak	_ZTSN7testing8internal15TestFactoryBaseE
	.section	.rodata._ZTSN7testing8internal15TestFactoryBaseE,"aG",@progbits,_ZTSN7testing8internal15TestFactoryBaseE,comdat
	.align 32
	.type	_ZTSN7testing8internal15TestFactoryBaseE, @object
	.size	_ZTSN7testing8internal15TestFactoryBaseE, 37
_ZTSN7testing8internal15TestFactoryBaseE:
	.string	"N7testing8internal15TestFactoryBaseE"
	.section	.rodata
.LC13:
	.string	"CPP"
.LC14:
	.string	"GEMM"
.LC15:
	.string	"ASM"
	.text
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB9781:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA9781
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$112, %rsp
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	movl	%edi, -132(%rbp)
	movl	%esi, -136(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -40(%rbp)
	xorl	%eax, %eax
	cmpl	$1, -132(%rbp)
	jne	.L524
	cmpl	$65535, -136(%rbp)
	jne	.L524
	leaq	_ZStL8__ioinit(%rip), %rdi
.LEHB29:
	call	_ZNSt8ios_base4InitC1Ev@PLT
	leaq	__dso_handle(%rip), %rdx
	leaq	_ZStL8__ioinit(%rip), %rsi
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	__cxa_atexit@PLT
	movl	$8, %edi
	call	_Znwm@PLT
	movq	%rax, %rbx
	movq	%rbx, %rdi
	call	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestEC1Ev
	movl	$9, %esi
	leaq	.LC6(%rip), %rdi
	call	_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci
	movq	%rax, %r13
	movl	$9, %esi
	leaq	.LC6(%rip), %rdi
	call	_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci
	movq	%rax, %r12
	call	_ZN7testing8internal13GetTestTypeIdEv@PLT
.LEHE29:
	movq	%rax, %r14
	leaq	-113(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcEC1Ev@PLT
	leaq	-113(%rbp), %rdx
	leaq	-112(%rbp), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
.LEHB30:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_@PLT
.LEHE30:
	leaq	-112(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movl	$9, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB31:
	call	_ZN7testing8internal12CodeLocationC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
.LEHE31:
	leaq	-80(%rbp), %rax
	subq	$8, %rsp
	pushq	%rbx
	pushq	%r13
	pushq	%r12
	movq	%r14, %r9
	movq	%rax, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	.LC13(%rip), %rsi
	leaq	.LC14(%rip), %rdi
.LEHB32:
	.cfi_escape 0x2e,0x20
	call	_ZN7testing8internal23MakeAndRegisterTestInfoEPKcS2_S2_S2_NS0_12CodeLocationEPKvPFvvES7_PNS0_15TestFactoryBaseE@PLT
.LEHE32:
	addq	$32, %rsp
	movq	%rax, _ZN13GEMM_CPP_Test10test_info_E(%rip)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal12CodeLocationD1Ev
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	leaq	-113(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movl	$8, %edi
.LEHB33:
	call	_Znwm@PLT
	movq	%rax, %rbx
	movq	%rbx, %rdi
	call	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestEC1Ev
	movl	$53, %esi
	leaq	.LC6(%rip), %rdi
	call	_ZN7testing8internal16SuiteApiResolverINS_4TestEE22GetTearDownCaseOrSuiteEPKci
	movq	%rax, %r13
	movl	$53, %esi
	leaq	.LC6(%rip), %rdi
	call	_ZN7testing8internal16SuiteApiResolverINS_4TestEE19GetSetUpCaseOrSuiteEPKci
	movq	%rax, %r12
	call	_ZN7testing8internal13GetTestTypeIdEv@PLT
.LEHE33:
	movq	%rax, %r14
	leaq	-113(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcEC1Ev@PLT
	leaq	-113(%rbp), %rdx
	leaq	-112(%rbp), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
.LEHB34:
	.cfi_escape 0x2e,0
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1EPKcRKS3_@PLT
.LEHE34:
	leaq	-112(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movl	$53, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
.LEHB35:
	call	_ZN7testing8internal12CodeLocationC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi
.LEHE35:
	leaq	-80(%rbp), %rax
	subq	$8, %rsp
	pushq	%rbx
	pushq	%r13
	pushq	%r12
	movq	%r14, %r9
	movq	%rax, %r8
	movl	$0, %ecx
	movl	$0, %edx
	leaq	.LC15(%rip), %rsi
	leaq	.LC14(%rip), %rdi
.LEHB36:
	.cfi_escape 0x2e,0x20
	call	_ZN7testing8internal23MakeAndRegisterTestInfoEPKcS2_S2_S2_NS0_12CodeLocationEPKvPFvvES7_PNS0_15TestFactoryBaseE@PLT
.LEHE36:
	addq	$32, %rsp
	movq	%rax, _ZN13GEMM_ASM_Test10test_info_E(%rip)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal12CodeLocationD1Ev
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	leaq	-113(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	jmp	.L524
.L535:
	movq	%rax, %rbx
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal12CodeLocationD1Ev
	jmp	.L527
.L534:
	movq	%rax, %rbx
.L527:
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	jmp	.L528
.L533:
	movq	%rax, %rbx
.L528:
	leaq	-113(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB37:
	call	_Unwind_Resume@PLT
.L538:
	movq	%rax, %rbx
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN7testing8internal12CodeLocationD1Ev
	jmp	.L530
.L537:
	movq	%rax, %rbx
.L530:
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT
	jmp	.L531
.L536:
	movq	%rax, %rbx
.L531:
	leaq	-113(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSaIcED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
	call	_Unwind_Resume@PLT
.LEHE37:
.L524:
	movq	-40(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L532
	call	__stack_chk_fail@PLT
.L532:
	leaq	-32(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9781:
	.section	.gcc_except_table
.LLSDA9781:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE9781-.LLSDACSB9781
.LLSDACSB9781:
	.uleb128 .LEHB29-.LFB9781
	.uleb128 .LEHE29-.LEHB29
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB30-.LFB9781
	.uleb128 .LEHE30-.LEHB30
	.uleb128 .L533-.LFB9781
	.uleb128 0
	.uleb128 .LEHB31-.LFB9781
	.uleb128 .LEHE31-.LEHB31
	.uleb128 .L534-.LFB9781
	.uleb128 0
	.uleb128 .LEHB32-.LFB9781
	.uleb128 .LEHE32-.LEHB32
	.uleb128 .L535-.LFB9781
	.uleb128 0
	.uleb128 .LEHB33-.LFB9781
	.uleb128 .LEHE33-.LEHB33
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB34-.LFB9781
	.uleb128 .LEHE34-.LEHB34
	.uleb128 .L536-.LFB9781
	.uleb128 0
	.uleb128 .LEHB35-.LFB9781
	.uleb128 .LEHE35-.LEHB35
	.uleb128 .L537-.LFB9781
	.uleb128 0
	.uleb128 .LEHB36-.LFB9781
	.uleb128 .LEHE36-.LEHB36
	.uleb128 .L538-.LFB9781
	.uleb128 0
	.uleb128 .LEHB37-.LFB9781
	.uleb128 .LEHE37-.LEHB37
	.uleb128 0
	.uleb128 0
.LLSDACSE9781:
	.text
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv:
.LFB9806:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA9806
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -24(%rbp)
	movl	$16, %edi
.LEHB38:
	call	_Znwm@PLT
.LEHE38:
	movq	%rax, %rbx
	movq	%rbx, %rdi
.LEHB39:
	call	_ZN13GEMM_ASM_TestC1Ev
.LEHE39:
	movq	%rbx, %rax
	jmp	.L543
.L542:
	movq	%rax, %r12
	movl	$16, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
	movq	%r12, %rax
	movq	%rax, %rdi
.LEHB40:
	call	_Unwind_Resume@PLT
.LEHE40:
.L543:
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9806:
	.section	.gcc_except_table
.LLSDA9806:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE9806-.LLSDACSB9806
.LLSDACSB9806:
	.uleb128 .LEHB38-.LFB9806
	.uleb128 .LEHE38-.LEHB38
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB39-.LFB9806
	.uleb128 .LEHE39-.LEHB39
	.uleb128 .L542-.LFB9806
	.uleb128 0
	.uleb128 .LEHB40-.LFB9806
	.uleb128 .LEHE40-.LEHB40
	.uleb128 0
	.uleb128 0
.LLSDACSE9806:
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv,comdat
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv, .-_ZN7testing8internal15TestFactoryImplI13GEMM_ASM_TestE10CreateTestEv
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv,comdat
	.align 2
	.weak	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv
	.type	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv, @function
_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv:
.LFB9807:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA9807
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -24(%rbp)
	movl	$16, %edi
.LEHB41:
	call	_Znwm@PLT
.LEHE41:
	movq	%rax, %rbx
	movq	%rbx, %rdi
.LEHB42:
	call	_ZN13GEMM_CPP_TestC1Ev
.LEHE42:
	movq	%rbx, %rax
	jmp	.L548
.L547:
	movq	%rax, %r12
	movl	$16, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
	movq	%r12, %rax
	movq	%rax, %rdi
.LEHB43:
	call	_Unwind_Resume@PLT
.LEHE43:
.L548:
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9807:
	.section	.gcc_except_table
.LLSDA9807:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE9807-.LLSDACSB9807
.LLSDACSB9807:
	.uleb128 .LEHB41-.LFB9807
	.uleb128 .LEHE41-.LEHB41
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB42-.LFB9807
	.uleb128 .LEHE42-.LEHB42
	.uleb128 .L547-.LFB9807
	.uleb128 0
	.uleb128 .LEHB43-.LFB9807
	.uleb128 .LEHE43-.LEHB43
	.uleb128 0
	.uleb128 0
.LLSDACSE9807:
	.section	.text._ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv,"axG",@progbits,_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv,comdat
	.size	_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv, .-_ZN7testing8internal15TestFactoryImplI13GEMM_CPP_TestE10CreateTestEv
	.text
	.type	_GLOBAL__sub_I__ZN13GEMM_CPP_Test10test_info_E, @function
_GLOBAL__sub_I__ZN13GEMM_CPP_Test10test_info_E:
.LFB9882:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9882:
	.size	_GLOBAL__sub_I__ZN13GEMM_CPP_Test10test_info_E, .-_GLOBAL__sub_I__ZN13GEMM_CPP_Test10test_info_E
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__ZN13GEMM_CPP_Test10test_info_E
	.section	.rodata
	.align 4
.LC3:
	.long	1065353216
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
