.data

mystr: .asciz "000000000000000\0"
str1: .asciz "Please enter a string\n"
str2: .asciz "You typed '%s'\n"
instr: .asciz "%s"

.text

.global main
main:
stp x29, x30, [sp, #-16]!

ldr x0, =str1
bl puts

ldr x0, =instr
ldr x1, =mystr
bl scanf

ldr x0, =str2
ldr x1, =mystr
bl printf

ldp x29, x30, [sp], #16
mov w0, #0
ret
