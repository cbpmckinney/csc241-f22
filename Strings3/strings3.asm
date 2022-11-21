.data 
    mystring: .asciz "Hello, world!"
    printstring: .asciz "The length of `%s` is %i\n"

.text

.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0, =mystring
    bl stringlength
    
    mov w2, w0
    ldr x0, =printstring
    ldr x1, =mystring
    bl printf

    ldp x29, x30, [sp], #16
    mov w0, #0
    ret

stringlength: //int stringlength(char tempstring[])
    stp x29, x30, [sp, #-16]!
    mov x1, x0
    mov x0, #0

loop:
    ldrb w2, [x1, x0]
    cbz w2, end
    mov w2, #0x57
    strb w2, [x1, x0] 
    add x0, x0, #1
    b loop

end:
    ldp x29, x30, [sp], #16
    ret
