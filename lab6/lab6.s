.global main

.data
    # Array
    x: .quad 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 # Declare an array with 10 entries.

    # input-output/prompts
    prompt: .asciz "\nPlease enter a number %d: "
    format: .asciz "%i"
    resultmsg: .asciz "The sum is: %d\n"

    # For loop variables (for sort)
    i: .quad 0
    j: .quad 0

    # Debugging
    dbmsg: .asciz "This-> %d\n"

.text
main:
    pushq %rbp # align stack

    # CALL INPUT FUNCTION
    # 16-bit alignment
    pushq %rbp
    pushq %rsp

    xorq %rax, %rax # no args on stack
    movq $x, %rdi # pass array as arg
    call getinput

    # popem from stack
    popq %rsp
    popq %rbp

    # CALL SORT FUNCTION
    # 16-bit alignment
    pushq %rbp
    pushq %rsp

    xorq %rax, %rax # no args on stack
    movq $x, %rdi # pass array as arg
    call getinput

    # popem from stack
    popq %rsp
    popq %rbp

    # Exit program.
    popq %rbp
    movq   $60,    %rax     # exit(
    movq   $0,     %rdi     # EXIT_SUCCESS
    syscall

# FUNCTION FOR GETING USER INPUT FROM COMMAND LINE
getinput:
    # Create stackframe
    pushq %rbp
    movq %rsp, %rbp

    # GET USER INPUT: WHILE LOOP while(rcx < 10) 
    xor %rax, %rax # clear rax
    movq %rdi, %rbx # load location of array into rbx
    movq $0, %rcx # load the number of inputs into rcx (i)
    cmpq $10, %rcx # compare i vs iteration #
    jge endin1
    in1:
        # save registers
        pushq %rbx
        pushq %rcx

        xorq %rax, %rax # no args on stack
        movq $prompt, %rdi # load prompt as argument
        movq %rcx, %rsi # Move i to rsi
        inc %rsi # increment by one so it shows properly ex. 1st, 2nd, not 0th
        call printf

        # popem in order
        popq %rcx # get i back from stack
        popq %rbx # get array ptr back from stack# get i back from stack

        # save registers
        pushq %rbx
        pushq %rcx

        xorq %rax, %rax # no args on stack
        movq $format, %rdi # load percentd as 1st arg
        movq %rbx, %rsi # load current array index ptr as 2nd arg
        call scanf

        # popem in order
        popq %rcx # get array ptr back from stack
        popq %rbx # get i back from stack

        addq $8, %rbx # Increment array index

        # Increment rcx(i) and repeat loop if rcx < 10
        inc %rcx
        cmpq $10, %rcx # check while condition
        jl in1 
    endin1:
    movq %rbp, %rsp # restore top stack pointer
    popq %rbp
    ret

# FUNCTION FOR OUTPUTTING AN ARRAY
# arrayout:
    # Create stackframe
    # pushq %rbp
    # movq %rsp, %rbp

