.global main

.text
main:
  XOR %rbx, %rbx   # Ensure rbx register is clear.

  movq $1, %rcx    # rcx = 1
  ADDQ %rcx, %rbx  # 0 += 1

  movq $2, %rcx    # rcx = 2
  ADDQ %rcx, %rbx  # 1 += 2

  movq $3, %rcx    # rcx = 3
  ADDQ %rcx, %rbx  # 3 += 3

  movq $4, %rcx    # rcx = 4
  ADDQ %rcx, %rbx  # 6 += 4

  movq $5, %rcx    # rcx = 5
  ADDQ %rcx, %rbx  # 10 += 5

  movq $6, %rcx    # rcx = 6
  ADDQ %rcx, %rbx  # 15 += 6

  movq $7, %rcx    # rcx = 7
  ADDQ %rcx, %rbx  # 21 += 7

  movq $8, %rcx    # rcx = 8
  ADDQ %rcx, %rbx  # 28 += 8

  movq $9, %rcx    # rcx = 9
  ADDQ %rcx, %rbx  # 36 += 9

  movq $10, %rcx   # rcx = 10
  ADDQ %rcx, %rbx  # 45 += 10 ---> rbx = 55


  movq   $60,    %rax     #exit(
  movq   $0,     %rdi     #EXIT_SUCCESS
  syscall                          #);
