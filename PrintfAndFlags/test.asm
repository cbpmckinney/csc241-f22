.data

mystring: .asciz "The number is %i\n"

.text

.global main

main:
stp x29, x30, [sp, #-16]!

mrs x2, NZCV
mov w1, #5
ldr x0, =mystring
bl printf

ldp x29, x30, [sp], #16
mov w0, #0
ret