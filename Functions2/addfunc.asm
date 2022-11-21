.data

.text

.global addfunc

addfunc: //w0 has input a, w1 has input b
    stp x29, x30, [sp, #-16]!

    add w0, w0, w1 // w0 <- w0 + w1

    ldp x29, x30, [sp], #16
    ret
