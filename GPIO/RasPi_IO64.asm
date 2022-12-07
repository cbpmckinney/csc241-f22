/* Raspberry Pi devices
-----------------------------------------------------------
This file provides a function "IO_init" that will map some
devices into the user program's memory space.  Pointers to
the devices are stored in global variables, and the user
program can then use those pointers to access the device
registers.

Another function, "IO_close" is provided to unmap the devices.
-----------------------------------------------------------*/
	// These are the addresses for the I/O devices (after
	// the firmware boot code has remapped them).
	.equ	PERI_BASE,  0xFE000000 // start of all devices
	// Base Physical Address of the GPIO registers
	.equ	GPIO_BASE, (PERI_BASE + 0x200000)
	// Base Physical Address of the PWM registers
	.equ	PWM_BASE,  (PERI_BASE + 0x20C000)
	// Base Physical Address of the UART 0 device
	.equ	UART0_BASE,(PERI_BASE + 0x201000)
	// Base Physical Address of the Clock/timer registers
	.equ	CLK_BASE,  (PERI_BASE + 0x101000)
	// some constants from /usr/include/mman.h
	.equ	MAP_FAILED,-1
	.equ	MAP_SHARED, 1
	.equ	PROT_READ,  1
	.equ	PROT_WRITE, 2
	// some constants from /usr/include/fcntl.h
	.equ	O_RDONLY,   00000000
	.equ	O_WRONLY,   00000001
	.equ	O_RDWR,	    00000002
	.equ	O_CREAT,    00000100
	.equ	O_EXCL,	    00000200
	.equ	O_NOCTTY,   00000400
	.equ	O_TRUNC,    00001000
	.equ	O_APPEND,   00002000
	.equ	O_NONBLOCK, 00004000
	.equ	O_NDELAY,   O_NONBLOCK
	.equ	O_SYNC,     00010000
	.equ	O_FSYNC,    O_SYNC
	.equ	O_ASYNC,    00020000
	// Size of a memory block (may depend on how kerenl
	// was compiled).
	.equ 	BLOCK_SIZE,(4*1024)
	
	// The following global variables will hold the addresses
	// of the devices that can be accessed directly after 
	// IO_init has been called.
	.data
	.global	gpiobase
gpiobase:	.dword	0
	.global	pwmbase
pwmbase	:	.dword	0
	.global	uart0base
uart0base:	.dword	0
	.global	clkbase
clkbase	:	.dword	0
	
	// strings used for printing messages
	.section .rodata
memdev:		.asciz	"/dev/mem"
successstr:	.asciz	"Successfully opened /dev/mem\n"
mappedstr:	.asciz	"Mapped %s device at 0x%016llX\n"
openfailed:	.asciz	"IO_init: failed to open /dev/mem: "
mapfailedmsg:	.asciz	"IO_init: mmap of %s failed: "
gpiostr:	.asciz	"GPIO"
pwmstr:		.asciz	"PWM"
uart0str:	.asciz	"UART0"
clkstr:		.asciz	"CLK"	

	.text
// -----------------------------------------------------------
// IO_init() maps devices into memory space and stores their
// addresses in global variables.
// -----------------------------------------------------------	
	.global	IO_init
IO_init:
	stp     x29,x30,[sp, #-16]! // Push FP and LR to stack
	// Try to open /dev/mem	
	adr	x0,memdev	// load address of "/dev/mem"
	mov	w1,#(O_RDWR+O_SYNC) // set up flags
	bl	open		// call the open syscall
	cmp	w0,#0		// check result
	bge	init_opened	// if open failed,
	adr	x0,openfailed	// print message and exit 
	bl	printf
	bl      __errno_location
        ldr     w0, [x0]
        bl      strerror
        bl      perror
	mov	x0,#0		// return 0 for failure
	b	init_exit
init_opened:
	// Open succeeded. Now map the devices 
	mov	x29,x0		// move file descriptor to x29
	adr	x0,successstr	// print message
	bl	printf
	// Map the GPIO device
	mov	x0,x29		// copy file descriptor
	ldr	x1,=GPIO_BASE	// address of device in memory
	bl	trymap
	cmp	w0,#MAP_FAILED
	bne	map_ok
	adr	x1,gpiostr	// if failed, load pointer to string,
	b	map_failed_exit	// print message, and return
map_ok:	adr	x1,gpiobase	// load address of global pointer
	str	x0,[x1]		// store pointer in gpiobase
	mov	x2,x1
	ldr	x2,[x2]
	adr	x0,mappedstr	// print success message
	adr	x1,gpiostr
	bl	printf
	// Map the PWM device
	mov	x0,x29		// move file descriptor to x29
	ldr	x1,=PWM_BASE	// address of device in memory
	bl	trymap
	cmp	w0,#MAP_FAILED
	bne	pwm_ok
	adr	x1,pwmstr	// if failed, load pointer to string,
	b	map_failed_exit	// print message, and return
pwm_ok:	adr	x1,pwmbase	// load address of global pointer
	str	x0,[x1]		// store pointer in pwmbase
	mov	x2,x1
	ldr	x2,[x2]
	adr	x0,mappedstr	// print success message
	adr	x1,pwmstr
	bl	printf
	// Map the UART0 device
	mov	x0,x29		// move file descriptor to r4
	ldr	x1,=UART0_BASE	// address of device in memory
	bl	trymap
	cmp	w0,#MAP_FAILED
	bne	uart_ok
	adr	x1,uart0str	// if failed, load pointer to string,
	b	map_failed_exit	// print message, and return
uart_ok:adr	x1,uart0base	// load address of pointer
	str	x0,[x1]		// store pointer in uart0base
	mov	x2,x1
	ldr	x2,[x2]
	adr	x0,mappedstr	// print success message
	adr	x1,uart0str
	bl	printf
	// Map the clock manager device
	mov	x0,x29		// move file descriptor to r4
	ldr	x1,=CLK_BASE	// address of device in memory
	bl	trymap
	cmp	w0,#MAP_FAILED
	bne	clk_ok
	adr	x1,clkstr	// if failed, load pointer to string,
	b	map_failed_exit	// print message, and return
clk_ok:	adr	x1,clkbase	// load address of pointer
	str	x0,[x1]		// store pointer in clkbase
	mov	x2,x1
	ldr	x2,[x2]
	adr	x0,mappedstr	// print success message
	adr	x1,clkstr
	bl	printf
	// All mmaps have succeded.
	// Close file and return 1 for success
	mov	w5,#1
	b	init_close
map_failed_exit:
	// At least one mmap failed. Print error,
	// unmap everthing and return
	adr	x0,mapfailedmsg
	bl	printf
	bl      __errno_location
	ldr     x0, [x0]
	bl      strerror
	bl      perror
	bl	IO_close
	mov	x0,#0
init_close:
	mov	x0,x29		// close /dev/mem
	bl	close
init_exit:	
	ldp     x29,x30,[sp],#16 // pop FP and LR from stack
	ret
// -----------------------------------------------------------
// trymap(int fd, unsigned offset) Calls mmap.  
trymap:
	stp     x29,x30,[sp, #-16]! // Push FP and LR to stack
        mov     x6,x1           // copy address to x5
        mov     x7,#0xFFF	// set up a mask for aligning
        and     x29,x6,x7	// get offset from page boundary
        bic     x5,x6,x7	// align phys addr to page boundary
	mov	x4,x0		// put fd in x4
        mov     x3,#MAP_SHARED
        mov     x2,#(PROT_READ + PROT_WRITE)
        mov     x1,#BLOCK_SIZE
        mov     x0,x6		// request offset as virt address
        bl      mmap
        cmp     x0,#-1
	beq	mapex
        add	x0,x0,x29        // add offset from page boundary
mapex:	ldp     x29,x30,[sp],#16 // pop FP and LR from stack
	ret
// -----------------------------------------------------------
// IO_close unmaps all of the devices
	.global	IO_close
IO_close:
	stp     x27,x28,[sp, #-16]! // Push x27,x28 to stack
	stp     x29,x30,[sp, #-16]! // Push FP and LR to stack
	
	adr	x27,gpiobase	// get address of first pointer
	mov	x28,#4		// there ar 4 pointers
IO_closeloop:
	ldr	x0,[x27]		// load address of device
	mov	x1,#BLOCK_SIZE
	cmp	x0,#0
	ble	closed
	bl	munmap		// unmap it
	mov	x0,#0
	str	x0,[x27],#8	// store and increment
	subs	x28,x28,#1
	bgt	IO_closeloop
closed:	ldp     x29,x30,[sp],#16 // pop FP and LR from stack
	ldp     x27,x28,[sp],#16 // pop x27 and x28
	ret
