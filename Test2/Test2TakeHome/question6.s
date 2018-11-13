.global main

.text
main:
  movq SUM, %rax # rax will act as the accumulator register.

  # Each variable value will be added to the value in rax, then the
  # sum left in rax.
  add A, %rax
  add B, %rax
  add C, %rax
  add D, %rax
  add E, %rax
  add F, %rax
  add G, %rax
  add H, %rax
  add I, %rax
  add J, %rax

  # place sum of our additions, currently in rax, into the variable SUM.
  movq %rax, SUM

  # Exit program
  movq $60, %rax
  movq $0, %rdi
  syscall #) EXIT

.data
  A: .quad 1
  B: .quad 2
  C: .quad 3
  D: .quad 4
  E: .quad 5
  F: .quad 6
  G: .quad 7
  H: .quad 8
  I: .quad 9
  J: .quad 10
  SUM: .quad 0
