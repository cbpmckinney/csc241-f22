//Functions and Parameter Passing

.data

    outstr: .asciz "The sum of %li and %li is %li.\n"

.text

.global main
main:
    stp x29, x30, [sp,#-16]!

    mov x0,#-1
    mov x1,#7
    stp x0, x1, [sp, #-16]!  //stash x0 and x1 on "the stack" 

    bl myfunc

    mov x3, x0
    ldp x1, x2, [sp], #16 //pull x1 and x2 off the stack
    ldr x0, =outstr
    bl printf  //printf(outstr,5,7,12)

    ldp x29, x30, [sp],#16
    mov w0, #0
    ret

//long int myfunc(long int a, long int b)
//{return a + b}
//long int a comes in x0
//long int b comes in x1
//answer goes out x0
myfunc:
    stp x29, x30, [sp, #-16]!
    add x0, x0, x1
    ldp x29, x30, [sp], #16
    ret
