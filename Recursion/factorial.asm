.data

num1: .dword 0x0
num2: .dword 0x1

str1: .asciz "Please input a number\n"
str2: .asciz "Factorial of %li is %li\n"
str3: .asciz "%li"

.text
.global main

main:

stp x29, x30, [sp, #-16]!

ldr x0, =str1
bl puts

ldr x0, =str3
ldr x1, =num1
bl scanf

ldr x1, =num1
ldr x0, [x1]
bl fact
ldr x1, =num2
str x0, [x1]


ldr x0, =str2
ldr x3, =num1
ldr x1, [x3]
ldr x3, =num2
ldr x2, [x3]
bl printf



ldp x29, x30, [sp], #16
mov w0, #0
ret

.global fact
fact:
    stp x29, x30, [sp, #-16]!
    cmp x0, #1
    b.gt factrecurse

factbase:
    mov x0, #1
    b end
factrecurse:
    str x0, [sp, #-16]!  //push x0 onto the stack
    sub x0, x0, #1 //compute n-1
    bl fact        //compute n-1 factorial
    ldr x1, [sp], #16  //pop n off the stack into x1
    mul x0, x0, x1

end:
    ldp x29, x30, [sp], #16
    ret

