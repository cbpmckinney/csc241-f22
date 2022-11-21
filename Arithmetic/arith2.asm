.data

num1: .dword 0xFEEDCADEDEADBEEF
str1: .asciz "Carry is set\n"
str2: .asciz "Carry is not set\n"

.text

.global main

main:
    stp x29, x30, [sp, #-16]!

    //ldr x0, =num1
    //ldr x1, [x0]
    mov x2, #-1
    //movz x3, #0xBEEF
    //movk x3, #0xDEAD, lsl 16
    //movk x3, #0xCADE, lsl 32
    //movk x3, #0xFEED, lsl 48

    mov x4, #2
    adcs x5, x4, x2
    mrs x6, NZCV
    movz x7, #0xf000, lsl 16
    msr NZCV, x7

    b.cs carryset
    b carrynotset

carryset:
    ldr x0, =str1
    bl puts
    b end

carrynotset:
    ldr x0, =str2
    bl puts 

end:
    ldp x29, x30, [sp], #16
    mov w0, #0
    ret

