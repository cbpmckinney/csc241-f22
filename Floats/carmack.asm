.data
str1: .asciz "Number = %f, Guess = %f, Newton = %f\n"

threehalves: .word 0x3FC00000 // 1.5
onehalf: .word 0x3F000000 // 0.5
number: .word 0x40000000 // 2.0

vari: .word 0x00000000
varx2: .word 0x00000000
vary: .word 0x0000000
magic32: .word 0x5f3759df

.text

.global main
main:
stp x29, x30, [sp, #-16]!

ldr x0, =number  //computes number*0.5
ldr s0,[x0]
ldr x0, =onehalf
ldr s1,[x0]
fmul s2, s0, s1
ldr x0,=varx2
str s2,[x0]

ldr x0,=vary
str s0,[x0]



ldr x0,=vary  //line 9
ldr s0,[x0]
fmov w0, s0
ldr x1, =vari
str w0, [x1]

lsr w0, w0, #1 //line 10
ldr x1, =magic32
ldr w2, [x1]
sub w3, w2, w0
ldr x0, =vari
str w3, [x0]

fmov s0, w3














ldp x29, x30, [sp], #16
mov w0, #0
ret
