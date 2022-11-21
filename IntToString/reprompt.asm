.data
str1: .asciz "Please type a string \n"
str2: .asciz "%18s"
instr: .asciz "000000000000000000\0"
str3: .asciz "Your string is invalid!\n"

.text

.global main
main:
    stp x29, x30, [sp, #-16]!

promptuser:
    ldr x0, =str1
    bl puts

    ldr x0, =str2
    ldr x1, =instr
    bl scanf

    bl flush

    ldr x0, =instr
    bl teststring

    cbnz x0, allgood
    ldr x0, =str3
    bl puts
    b promptuser

allgood:

    ldp x29, x30, [sp], #16
    mov w0, #0
    ret



.global teststring 
// bool teststring(string)
//return 0 if invalid, 1 if valid
teststring:
stp x29, x30, [sp, #-16]!

mov x0, #0

ldp x29, x30, [sp], #16
ret
