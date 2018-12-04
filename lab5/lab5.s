.global main

.text
main:
    pushq %rbp
    xor %rax, %rax # clear rax
    movq $x, %rbx # load location of array into rbx
    movq $0, %rcx # load the number of inputs into rcx (i)
    cmpq $10, %rcx # compare i vs iteration #
    jge endin1
    in1:
        # save registers
        pushq %rbx
        pushq %rcx

        xorq %rax, %rax # no args on stack
        movq $prompt, %rdi # load prompt as argument 
        call printf

        # popem in order
        popq %rcx # get array ptr back from stack
        popq %rbx # get i back from stack

        lea (%rbx, %rcx, 8), %rbx # Load x[rcx] into rdx.

        # save registers
        pushq %rbx
        pushq %rcx

        xorq %rax, %rax # no args on stack
        movq $percentd, %rdi # load percentd as 1st arg
        movq $temp, %rsi # load current array index as 2nd arg
        call scanf
 
        # popem in order
        popq %rcx # get array ptr back from stack
        popq %rbx # get i back from stack
        movq temp,%rdx
        movq %rdx, (%rbx)
        cmpq $10, %rcx # check while condition
        jl in1 
    endin1:

    # Exit program.
    movq   $60,    %rax     # exit(
    movq   $0,     %rdi     # EXIT_SUCCESS
    syscall


.data
    x: .quad 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 # Declare an array with 10 entries.
    sum: .quad 0
    prompt: .asciz "Please enter a number: \n"
    percentd: .asciz "%i \n"
    temp: .quad 0
