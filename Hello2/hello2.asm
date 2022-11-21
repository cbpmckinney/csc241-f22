.data
    hellostr: .asciz "Hello, world!\n"

.text

.global main

main:
    stp x29,x30,[sp,#-16]!

    ldr x0,=hellostr
    bl  puts

    ldp x29,x30,[sp],#16
    mov w0,#0
    ret
    