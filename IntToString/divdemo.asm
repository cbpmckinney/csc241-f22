.data

str: .asciz "%i divided by %i gives quotient %i and remainder %i\n"

.text

.global main
main:

stp x29, x30, [sp, #-16]!

mov w1, #12345
mov w2, #10
sdiv w3, w1, w2 //INTEGER DIVISION!!!!!
mul w4, w2, w3 //computes 10*quotient
sub w4, w1, w4 //computes 12345 - 10*1234
ldr x0, =str
bl printf

ldp x29, x30, [sp], #16
mov w0, #0
ret
