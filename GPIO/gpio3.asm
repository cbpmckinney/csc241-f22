/*
Dr. C's GPIO TEST
Requires use of Larry Pyeatt's memory mapper
Base GPIO memory address changed from Larry's original version
Values here are for RPi4.  Larry's original had 0x3F2...for RPi2 and 3
Consult Broadcom 2711 manual for register locations and values
*/

.data

mount:		.asciz "Attempting to map devices...\n"
unmount:	.asciz "Attempting to unmap devices...\n"
pin4on:		.asciz "Attempting to power up GPIO Pin 4...\n"
pin4config: .asciz "Configuring GPIO Pin 4 as output...\n"

gpioconf:	.asciz "Dev 0x%llx- 0x%x\n"

/*
GPIO REGISTER ADDRESSES
NOTE: Not all pin numbers are located on the GPIO pinout
Some are special
Refer to manuals!
Note these register addresses are for BCM2711.  Values are 0x3F2... on RPi 2 and 3
Refer to BCM datasheets!
*/
.equ GPIOFSEL0, 0xFE200000 //Function select 0 //pins 0-9, 3 bits each
.equ GPIOFSEL1, 0xFE200004 //Function select 1 //pins 10-19, 3 bits each
.equ GPIOFSEL2, 0xFE200008 //Function select 2 //pins 20-29, 3 bits each
.equ GPIOFSEL3, 0xFE20000C //Function select 3 //pins 30-39, 3 bits each
.equ GPIOFSEL4, 0xFE200010 //Function select 4 //pins 40-49, 3 bits each
.equ GPIOFSEL5, 0xFE200014 //Function select 5 //pins 50-57, 3 bits each
//000 = input, 001=output, other patterns for alt function
//See Broadcom 2711 manual

.equ GPSET0, 0xFE20001C //Output set 0, pins 0-31
.equ GPSET1, 0xFE200020 //Output set 1, pins 32+

.equ GPCLR0, 0xFE200028 //Output clear 0, pins 0-31
.equ GPCLR1, 0xFE20002C //Output clear 1, pins 32+

.equ GPLEV0, 0xFE200034 //Pin level 0
.equ GPLEV1, 0xFE200038 //Pin level 1

.equ GPEDS0, 0xFE200040 //Event status detect 0
.equ GPEDS1, 0xFE200044 //Event status detect 1

.equ GPREN0, 0xFE20004C //Rising edge detect enable 0
.equ GPREN1, 0xFE200050 //Rising edge detect enable 1

.equ GPFEN0, 0xFE200058 //Falling edge detect enable 0
.equ GPFEN1, 0xFE20005C //Falling edge detect enable 1

.equ GPHEN0, 0xFE200064 //High detect enable 0
.equ GPHEN1, 0xFE200068 //High detect enable 1

.equ GPLEN0, 0xFE200070 //Low detect enable 0
.equ GPLEN1, 0xFE200074 //Low detect enable 1

.equ GPAREN0, 0xFE20007C //Async Rising detect 0
.equ GPAREN1, 0xFE200080 //Async Rising detect 1

.equ GPAFEN0, 0xFE200088 //Async Falling detect 0
.equ GPAFEN1, 0xFE20008C //Async falling detect 1

.equ GPIO_PUP_PDN_CNTRL_REG0, 0xFE2000E4 //PU/PD Reg 0 pins 0-15 (2 bits each)
.equ GPIO_PUP_PDN_CNTRL_REG1, 0xFE2000E8 //PU/PD Reg 1 pins 16-31 (2 bits each)
.equ GPIO_PUP_PDN_CNTRL_REG2, 0xFE2000EC //PU/PD Reg 2 pins 32-47 (2 bits each)
.equ GPIO_PUP_PDN_CNTRL_REG3, 0xFE2000F0 //PU/PD Reg 3 pins 48-57 (2 bits each)
//00 no resistor, 01 pullup, 10 pulldown, 11 reserved


//.equ GPPUD, 0xFE200094


.text


.global main

main:
  stp x29, x30, [sp, #-16]!
  bl IO_init
  //Initialize Pin 17 as Output
  ldr x0,=GPIOFSEL1 //Pin 17 is bits 21, 22, 23 of GPIOFSEL1
  mov w1, #0b111
  ldr w2, [x0]
  bic w2, w2, w1
  mov w3, #001
  lsl w3, w3, #21 //shift into position
  orr w3, w2, w3 //ORR against other bits
  str w3, [x0] //writes to GPIOFSEL1
  //Initialize Pins 13 as output
  ldr x0,=GPIOFSEL1 //Pin 13 is bits 9,10,11 of GPIOFSEL1
  mov w1, #0b111111000000000000
  ldr w2, [x0]
  bic w2, w2, w1
  mov w3, #000
  lsl w3, w3, #9 //shift into position
  orr w3, w2, w3 //ORR against other bits
  str w3, [x0] //writes to GPIOFSEL1
  //Initilize Pin 26 as output
  ldr x0,=GPIOFSEL2 //Pin 26 is bits 18-20 of GPIOFSEL2
  mov w1, #0b111
  ldr w2, [x0]
  bic w2, w2, w1
  mov w3, #000
  lsl w3, w3, #18 //shift into position
  orr w3, w2, w3 //ORR against other bits
  str w3, [x0] //writes to GPIOFSEL1
  //Set Pin 13 pullup
  ldr x0,=GPIO_PUP_PDN_CNTRL_REG0 //pin 13 is bits 26-27
  ldr w1,[x0]
  mov w2,#11
  lsl w2, w2, #26
  bic w1,w2,w2
  mov w2,#01
  orr w1,w2,w2
  str w1,[x0]
  //Set Pin 26 pullup
  ldr x0,=GPIO_PUP_PDN_CNTRL_REG1 //pin 26 is bits 20-21
  ldr w1,[x0]
  mov w2,#11
  lsl w2, w2, #20
  bic w1,w2,w2
  mov w2,#01
  orr w1,w2,w2
  str w1,[x0]

mov w5, #1
b lighton
loop:
  //get interrupt info: which bits were high?
  //ldr x0,=GPLEV0
  //tbnz x0,#13,lighton //check bit 13
  //b lightoff
  cbz w5, terminate
  add w5, w5, #1
  b loop



  //b wait //branch to wait in case


  lighton: //power up pin 17 if pin 13 high
    ldr x0, =GPSET0 //pin 17 is bit 16 of GPSET0
    mov w1, #0b1
    lsl w1, w1, #16 //shift left 16 positions
    ldr w2,[x0]
    bic w2, w2, w1
    orr w2, w2, w1
    str w2,[x0]
    b loop

  lightoff: //power down pin 17 if pin 13 low
    ldr x0, =GPCLR0 //pin 17 is bit 16 of GPSET0
    mov w1, #0b0
    lsl w1, w1, #16 //shift left 16 positions
    ldr w2,[x0]
    bic w2, w2, w1
    orr w2, w2, w1
    str w2,[x0]
    b wait

  terminate: //power down pin 17 and exit if pin 26 high
    ldr x0, =GPCLR0 //pin 17 is bit 16 of GPSET0
    mov w1, #0b0
    lsl w1, w1, #16 //shift left 16 positions
    ldr w2,[x0]
    bic w2, w2, w1
    orr w2, w2, w1
    str w2,[x0]
    b finish

wait:
  wfi     //wait for interrupt
  b loop



finish:
  bl IO_close
  ldp x29, x30, [sp], 16
  mov w0, #0
  ret
