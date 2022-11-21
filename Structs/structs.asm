	.arch armv8-a
	.file	"structs.c"
	.text
	.align	2
	.global	distance
	.type	distance, %function
distance:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -80]!
	.cfi_def_cfa_offset 80
	.cfi_offset 29, -80
	.cfi_offset 30, -72
	mov	x29, sp
	fmov	d4, d0
	fmov	d0, d1
	mov	x0, 0
	mov	x1, 0
	fmov	x0, d4
	fmov	x1, d0
	stp	x0, x1, [sp, 32]
	fmov	d1, d2
	fmov	d0, d3
	mov	x0, 0
	mov	x1, 0
	fmov	x0, d1
	fmov	x1, d0
	stp	x0, x1, [sp, 16]
	ldr	d1, [sp, 32]
	ldr	d0, [sp, 16]
	fsub	d0, d1, d0
	str	d0, [sp, 72]
	ldr	d1, [sp, 40]
	ldr	d0, [sp, 24]
	fsub	d0, d1, d0
	str	d0, [sp, 64]
	ldr	d0, [sp, 72]
	fmul	d0, d0, d0
	str	d0, [sp, 72]
	ldr	d0, [sp, 64]
	fmul	d0, d0, d0
	str	d0, [sp, 64]
	ldr	d1, [sp, 72]
	ldr	d0, [sp, 64]
	fadd	d0, d1, d0
	bl	sqrt
	str	d0, [sp, 56]
	ldr	d0, [sp, 56]
	ldp	x29, x30, [sp], 80
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	distance, .-distance
	.align	2
	.global	area
	.type	area, %function
area:
.LFB1:
	.cfi_startproc
	stp	x29, x30, [sp, -80]!
	.cfi_def_cfa_offset 80
	.cfi_offset 29, -80
	.cfi_offset 30, -72
	mov	x29, sp
	str	x19, [sp, 16]
	.cfi_offset 19, -64
	mov	x19, x0
	ldr	d2, [x19, 16]
	ldr	d3, [x19, 24]
	ldr	d0, [x19]
	ldr	d1, [x19, 8]
	bl	distance
	str	d0, [sp, 72]
	ldr	d2, [x19]
	ldr	d3, [x19, 8]
	ldr	d0, [x19, 32]
	ldr	d1, [x19, 40]
	bl	distance
	str	d0, [sp, 64]
	ldr	d2, [x19, 32]
	ldr	d3, [x19, 40]
	ldr	d0, [x19, 16]
	ldr	d1, [x19, 24]
	bl	distance
	str	d0, [sp, 56]
	ldr	d1, [sp, 56]
	ldr	d0, [sp, 64]
	fadd	d1, d1, d0
	ldr	d0, [sp, 72]
	fadd	d1, d1, d0
	fmov	d0, 2.0e+0
	fdiv	d0, d1, d0
	str	d0, [sp, 48]
	ldr	d1, [sp, 48]
	ldr	d0, [sp, 56]
	fsub	d1, d1, d0
	ldr	d0, [sp, 48]
	fmul	d1, d1, d0
	ldr	d2, [sp, 48]
	ldr	d0, [sp, 64]
	fsub	d0, d2, d0
	fmul	d1, d1, d0
	ldr	d2, [sp, 48]
	ldr	d0, [sp, 72]
	fsub	d0, d2, d0
	fmul	d0, d1, d0
	bl	sqrt
	str	d0, [sp, 40]
	ldr	d0, [sp, 40]
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 80
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1:
	.size	area, .-area
	.align	2
	.global	flush
	.type	flush, %function
flush:
.LFB2:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	nop
.L6:
	bl	getchar
	strb	w0, [sp, 31]
	ldrb	w0, [sp, 31]
	cmp	w0, 10
	bne	.L6
	nop
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE2:
	.size	flush, .-flush
	.section	.rodata
	.align	3
.LC0:
	.string	"The triangle struct is at %p\n"
	.align	3
.LC1:
	.string	"The area of the triangle is %f\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB3:
	.cfi_startproc
	stp	x29, x30, [sp, -176]!
	.cfi_def_cfa_offset 176
	.cfi_offset 29, -176
	.cfi_offset 30, -168
	mov	x29, sp
	adrp	x0, .LC2
	ldr	d0, [x0, #:lo12:.LC2]
	str	d0, [sp, 152]
	adrp	x0, .LC3
	ldr	d0, [x0, #:lo12:.LC3]
	str	d0, [sp, 160]
	fmov	d0, 7.0e+0
	str	d0, [sp, 136]
	adrp	x0, .LC4
	ldr	d0, [x0, #:lo12:.LC4]
	str	d0, [sp, 144]
	fmov	d0, -1.0e+0
	str	d0, [sp, 120]
	fmov	d0, 2.5e+0
	str	d0, [sp, 128]
	ldp	x0, x1, [sp, 152]
	stp	x0, x1, [sp, 72]
	ldp	x0, x1, [sp, 136]
	stp	x0, x1, [sp, 88]
	ldp	x0, x1, [sp, 120]
	stp	x0, x1, [sp, 104]
	add	x0, sp, 16
	add	x1, sp, 72
	ldp	x2, x3, [x1]
	stp	x2, x3, [x0]
	ldp	x2, x3, [x1, 16]
	stp	x2, x3, [x0, 16]
	ldp	x2, x3, [x1, 32]
	stp	x2, x3, [x0, 32]
	add	x0, sp, 16
	bl	area
	str	d0, [sp, 168]
	add	x0, sp, 72
	mov	x1, x0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	ldr	d0, [sp, 168]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 176
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.section	.rodata
	.align	3
.LC2:
	.word	1374389535
	.word	1074339512
	.align	3
.LC3:
	.word	-858993459
	.word	1075236044
	.align	3
.LC4:
	.word	-941456831
	.word	1074838424
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
