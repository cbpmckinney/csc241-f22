	.arch armv8-a
	.file	"pointers1.c"
	.text
	.section	.rodata
	.align	3
.LC1:
	.string	"The character located at %p is %c\n"
	.align	3
.LC2:
	.string	"The integer located at %p is %i\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -96]!
	.cfi_def_cfa_offset 96
	.cfi_offset 29, -96
	.cfi_offset 30, -88
	mov	x29, sp
	mov	w0, 7
	str	w0, [sp, 60]
	adrp	x0, .LC3
	ldr	d0, [x0, #:lo12:.LC3]
	str	d0, [sp, 48]
	mov	x0, 25928
	movk	x0, 0x6c6c, lsl 16
	movk	x0, 0x216f, lsl 32
	str	x0, [sp, 40]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	add	x2, sp, 16
	mov	x3, x0
	ldp	x0, x1, [x3]
	stp	x0, x1, [x2]
	ldr	w0, [x3, 16]
	str	w0, [x2, 16]
	add	x0, sp, 60
	str	x0, [sp, 88]
	add	x0, sp, 48
	str	x0, [sp, 80]
	add	x0, sp, 40
	str	x0, [sp, 72]
	add	x0, sp, 16
	str	x0, [sp, 64]
	ldr	x0, [sp, 72]
	ldrb	w0, [x0]
	mov	w2, w0
	ldr	x1, [sp, 72]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	ldr	x0, [sp, 72]
	add	x1, x0, 1
	ldr	x0, [sp, 72]
	add	x0, x0, 1
	ldrb	w0, [x0]
	mov	w2, w0
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	ldr	x0, [sp, 64]
	ldr	w0, [x0]
	mov	w2, w0
	ldr	x1, [sp, 64]
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	ldr	x0, [sp, 64]
	add	x1, x0, 4
	ldr	x0, [sp, 64]
	add	x0, x0, 4
	ldr	w0, [x0]
	mov	w2, w0
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 96
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align	3
.LC0:
	.word	3
	.word	1
	.word	4
	.word	1
	.word	5
	.text
	.section	.rodata
	.align	3
.LC3:
	.word	1374389535
	.word	1074339512
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
