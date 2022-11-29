.data

mystr: .asciz "The sine is %f\n"
mynum: .dword 0x3FC5555555555555

.text

.global main
main:

stp x29, x30, [sp, #-16]!

ldr x0, =mynum
ldr d0, [x0]

bl sinpi2x

ldr x0, =mystr
bl printf


ldp x29, x30, [sp], #16
mov w0, #0
ret
