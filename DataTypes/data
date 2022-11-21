	.arch armv8-a
	.file	"data.c"
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"The number is %f\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	mov	w0, 274
	str	w0, [sp, 44]
	mov	w0, 5
	str	w0, [sp, 40]
	fmov	s0, 3.5e+0
	str	s0, [sp, 36]
	ldr	s0, [sp, 44]
	scvtf	s0, s0
	ldr	s1, [sp, 36]
	fadd	s0, s1, s0
	str	s0, [sp, 32]
	adrp	x0, .LC1
	ldr	d0, [x0, #:lo12:.LC1]
	str	d0, [sp, 24]
	ldr	s0, [sp, 32]
	fcvt	d0, s0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align	3
.LC1:
	.word	-1717986918
	.word	1075812761
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
