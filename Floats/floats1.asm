.data

// w0, x0 are integer registers
// s0, d0 are floating point registers

mystr: .asciz "The square root of %f is %f\n"
mynum64: .dword 0x4025000000000000
mynum32: .word 0x41280000

.text

.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0, =mystr
    ldr x1, =mynum32
    ldr s0, [x1]

    fsqrt s1, s0 
    fcvt d0, s0
    fcvt d1, s1
    bl printf



    ldp x29, x30, [sp], #16
    mov w0, #0
    ret
