.data

    mystring: .asciz "Result: %i\n"

.text

.global main

main:
    stp x29, x30, [sp, #-16]!

    // add, adc, adcs, adds
    // add, well, adds.  Discards any carry, disregards previous carries
    // adds adds, but does not discard a carry.  Disregards previous carries
    // adc takes into account previous carry, discards current carry if any
    // adcs takes into account both

    mov w0, #0xFFFFFFFF
    mov w1, #1
    adcs w1, w1, w0
    ldr x0, =mystring
    bl printf

    ldp x29, x30, [sp], #16
    mov w0, #0
    ret