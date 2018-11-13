.global main

.text
main:
  # Push every variable onto the stack
  pushq A
  pushq B
  pushq C
  pushq D
  pushq E
  pushq F

  # Pop every variable off of the stack, but in "reverse" order
  popq A
  popq B
  popq C
  popq D
  popq E
  popq F

  # These instructions were only for me to confirm the state of the variables,
  # I figured I'd leave them just in case you wanted to confirm my work.
  # The value in rbx will match the values as you read up the original variable order.
  movq A, %rbx #2
  movq B, %rbx #9
  movq C, %rbx #7
  movq D, %rbx #45
  movq E, %rbx #30
  movq F, %rbx #1

  # Exit program
  movq $60, %rax
  movq $0, %rdi
  syscall #) EXIT

.data
  A: .quad 1
  B: .quad 30
  C: .quad 45
  D: .quad 7
  E: .quad 9
  F: .quad 2
