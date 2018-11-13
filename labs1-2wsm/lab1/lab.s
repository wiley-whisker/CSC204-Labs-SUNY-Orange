.global main

.text
main:                          #main function
movq      $20,  %rax   #move immediate value 20 into rax reg
movq      $x,   %rbx   #move pointer to rbx reg
movq      x,    %rcx   #move value x into rcx  *x



movq      $60, %rax     #exit(
movq      $0,  %rdi     #EXIT_SUCCESS
syscall                          #);

.data
x: .quad 5        #allocates 8 bytes of memory and places 5 in the location
