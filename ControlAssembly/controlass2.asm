.data

    sandstring: .asciz "That sandwich was yummy!\n"

.text

.global main
main:
    stp x29, x30, [sp,#-16]!
    mov x19, #10
    mov x20, #1
    
check:
    cmp x19, #0 //does x19-#0, discards result, sets flags
//    b.gt loopbody
//    b    finish
    b.le finish

loopbody:
    ldr x0,=sandstring
    bl  printf
    sub x19, x19, x20 // x19 <--- x19-x20
    b check

finish:
    ldp x29, x30, [sp], #16
    mov w0, #0
    ret
