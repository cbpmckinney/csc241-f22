.data

  magic32: .word 0x5f3759df
  threehalves: .word 0x3fc00000
  onehalf: .word 0x3f000000

.text

.global Carmack2  // float Carmack2(float x)
Carmack2:
stp x29, x30, [sp, #-16]!

  ldr x1, =onehalf
  ldr s1, [x1]
  fmul s2, s1, s0   //these lines compute Carmack x2

CarmackEstimate:
  fmov w0, s0
  ldr x1, =magic32
  ldr w2, [x1]
  lsr w0, w0, #1
  sub w0, w2, w0
  fmov s0, w0

CarmackIteration:

  fmul s3, s0, s0  // computes y*y
  fmul s4, s2, s3  // computes x2*y*y
  ldr x1, =threehalves
  ldr s5, [x1]
  fsub s6, s5, s4 //computes threehalves-x2*y*y
  fmul s0, s6, s0 //computes y*(threehalves-x2*y*y)

ldp x29, x30, [sp], #16
ret
