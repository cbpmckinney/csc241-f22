.data

mynum: .word 0x0
scanstr: .asciz "%i"
str1: .asciz "Please type a number: "
str2: .asciz "\nThe number you typed was: %i\n"


.text

.global main

main:
stp x29, x30, [sp, #-16]!

ldr x0, =str1
bl puts //or bl printf

ldr x0, =scanstr
ldr x1, =mynum
bl scanf

ldr x0, =str2
ldr x2, =mynum
ldr w1, [x2]
bl printf


ldp x29, x30, [sp], #16
mov w0, #0
ret
