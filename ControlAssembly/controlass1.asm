.data

    outstr: .asciz "The number is %i\n"

.text

.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0, =outstr
    mov w1, #1
    mov w20, w1
    mov w21, #21
check:
    cmp w20, w21
    b.eq end
jabberwocky:
    mov w1, w20
    ldr x0, =outstr
    bl  printf
    mov w1, #1
    add w20, w20, w1
    b check
end:
    ldp x29, x30, [sp], #16
    mov w0, #0
    ret
