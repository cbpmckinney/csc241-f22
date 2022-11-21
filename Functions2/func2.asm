.data

    a: .word 0x02
    b: .word 0x03
    mystring: .asciz "The sum of %i and %i is %i\n"

.text

.global main

main:
    stp x29, x30, [sp, #-16]!

    ldr x2, =a
    ldr w0, [x2]
    ldr x2, =b
    ldr w1, [x2]
    bl addfunc
    mov w3, w0

    ldr x0, =mystring
    ldr x4, =a
    ldr w1, [x4]
    ldr x4, =b
    ldr w2, [x4]
    bl printf


    ldp x29, x30, [sp], #16
    mov w0, #0
    ret
