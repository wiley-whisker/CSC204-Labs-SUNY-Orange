.global main

.text
main:
    pushq %rbp # to fix misalignment

    # GET USER INPUT: WHILE LOOP while(rcx < 10) 
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
        popq %rcx # get i back from stack
        popq %rbx # get array ptr back from stack# get i back from stack

        # save registers
        pushq %rbx
        pushq %rcx

        xorq %rax, %rax # no args on stack
        movq $percentd, %rdi # load percentd as 1st arg
        movq %rbx, %rsi # load current array index ptr as 2nd arg
        call scanf
 
        # popem in order
        popq %rcx # get array ptr back from stack
        popq %rbx # get i back from stack

        addq $8, %rbx

        # Increment rcx(i) and repeat loop if rcx < 10
        inc %rcx
        cmpq $10, %rcx # check while condition
        jl in1 
    endin1:

    # SUM THE NUMBERS
    xorq %rax, %rax # clear rax
    movq $x, %rbx
    movq $0, %rcx # load the number of array indecies into rcx (i)
    cmpq $10, %rcx # compare i vs iteration #
    jge endsum
    sumloop:
        add (%rbx), %rax # Add x[rcx] to sum(rax)

        addq $8, %rbx

        inc %rcx # rcx++.

        # Compare for repeat.
        cmpq $10, %rcx # Compare 10(len of array) against i (rcx).
        jl sumloop # Repeat loop while rcx < 10
    endsum:

    movq %rax, sum # Move sum into variable

    # Save registers
    pushq %rcx
    pushq %rbx

    # Print sum
    xor %rax, %rax
    movq $resultmsg, %rdi
    movq sum, %rsi
    call printf

    # Restore registers
    popq %rbx
    popq %rcx



    # Exit program.
    popq %rbp
    movq   $60,    %rax     # exit(
    movq   $0,     %rdi     # EXIT_SUCCESS
    syscall


.data
    x: .quad 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 # Declare an array with 10 entries.
    sum: .quad 0
    prompt: .asciz "Please enter a number: \n"
    percentd: .asciz "%i \n"
    resultmsg: .asciz "The sum is: %d\n"
    dbmsg: .asciz "This-> %d\n"
