.data

mount:		.asciz "Attempting to map devices...\n"
unmount:	.asciz "Attempting to unmap devices...\n"
pin4on:		.asciz "Attempting to power up GPIO Pin 4...\n"
pin4config: .asciz "Configuring GPIO Pin 4 as output...\n"

gpioconf:	.asciz "Dev 0x%llx- 0x%x\n"


.equ GPIOFSEL0, 0x3F200000
.equ GPIOFSEL1, 0x3F200004
.equ GPIOFSEL2, 0x3F200008
.equ GPSET0,0x3F20001C
.equ GPCLR0,0x3F200028
.equ GPPUD, 0x3F200094

.equ mask1, 0b111111000000000000
.equ mask2, 0b000001000000000000
.equ mask3, 0b10000




.text

.global main

main:
	stp x29,x30,[sp,#-16]!

	ldr x0,=mount
	bl	printf

	bl	IO_init

pin4configuration:


	
	
//sets pin 4 for output, pin 5 for input
	ldr x0, =GPIOFSEL0
	mov w1, #mask1
	ldr w2,[x0]
	bic w2,w2,w1
	mov w3,#mask2
	orr w3,w2,w3
	str w3,[x0]
	
	ldr x0,=gpioconf
	ldr x1,=GPIOFSEL0
	ldr w2,[x1]
	bl	printf

//disables pullup/pulldown for GPIO 0-31		
	ldr x0,=GPPUD
	mov w1,wzr
	str w1,[x0]
	
	ldr x0,=gpioconf
	ldr x1,=GPPUD
	ldr w2,[x1]
	bl	printf	

//turns on pin 4 by setting 1 to GPSET0 bit 4
	ldr x0, =GPSET0
	mov w1, #mask3
	str w1,[x0]
	
	ldr x0,=gpioconf
	ldr x1,=GPSET0
	ldr w2,[x1]
	bl	printf




loop:	//endless loop to keep pin on

	b loop


	ldp x29,x30,[sp],#16
	mov w0,#0
	ret
