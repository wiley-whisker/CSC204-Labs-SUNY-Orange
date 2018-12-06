.global main

.data
    # Array and temp variable
    x: .quad 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 # Declare an array with 10 entries.
    temp: .quad 0 # Temp variable for array swaps

    # input-output/prompts
    prompt: .asciz "\nPlease enter a number %d: "
    format: .asciz "%i"
    sortingmsg: .asciz "\nSorting the array...\n"
    arrayoutmsg: .asciz "Printing array: %d\n"
    sortedmsg: .asciz "Array has been sorted\n"

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

    # CALL OUTPUT FUNCTION
    # 16-bit alignment
    pushq %rbp
    pushq %rsp

    xorq %rax, %rax # no args on stack
    movq $x, %rdi # pass array as arg
    call arrayout

    # popem from stack
    popq %rsp
    popq %rbp

    # PRINT SORTING MSG
    # save registers
    pushq %rbx
    pushq %rcx

    xorq %rax, %rax # no args on stack
    movq $sortingmsg, %rdi # load prompt as argument
    call printf

    # popem in order
    popq %rcx # get i back from stack
    popq %rbx # get array ptr back from stack

    # CALL SORT FUNCTION
    # 16-bit alignment
    pushq %rbp
    pushq %rsp

    xorq %rax, %rax # no args on stack
    movq $x, %rdi # pass array as arg
    call bubblesort

    # popem from stack
    popq %rsp
    popq %rbp

    # CALL OUTPUT FUNCTION
    # 16-bit alignment
    pushq %rbp
    pushq %rsp

    xorq %rax, %rax # no args on stack
    movq $x, %rdi # pass array as arg
    call arrayout

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
        popq %rbx # get array ptr back from stack

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
arrayout:
    # Create stackframe
    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %rbx
    movq $0, %rcx
    arrayoutloop: # A do-while loop to print out a 10 index array
        # save registers
        pushq %rbx
        pushq %rcx

        xorq %rax, %rax # no args on stack
        movq $arrayoutmsg, %rdi # load prompt as argument
        movq (%rbx), %rsi # Move i to rsi
        call printf

        # popem in order
        popq %rcx # get i back from stack
        popq %rbx # get array ptr back from stack

        addq $8, %rbx # move to next array index

        inc %rcx

        cmpq $10, %rcx
        jl arrayoutloop
    
    movq %rbp, %rsp # restore top stack pointer
    popq %rbp
    ret

# FUNCTION FOR BUBBLESORTING AN ARRAY
bubblesort:
    # Create stackframe
    pushq %rbp
    movq %rsp, %rbp

    for1:
    movq $0, j
        for2:
            movq j, %rbx # move current index to rbx
            movq %rbx, %rdx # move current index to rdx the  increment
            inc %rdx

            leaq (%rdi,%rbx,8), %rcx # Move address of Current array index into rCx
            leaq (%rdi,%rdx,8), %rax # Move address of Adjacent array index into rAx

            movq (%rcx), %rsi # using rsi as our temp register

            cmpq %rsi, (%rax)
            jge dontswap
                # Move value of j+1 to temp
                movq (%rax), %rsi
                movq %rsi, temp
                
                # move [j] to [j+1]
                movq (%rcx), %rsi
                movq %rsi, (%rax)

                # move temp to [j]
                movq temp, %rsi
                movq %rsi, (%rcx)
            dontswap:

            
        # Move j to rcx, increment, save new value, then compare.
        movq j, %rcx
        inc %rcx
        movq %rcx, j
        cmpq $9, %rcx
        jl for2
    
    # Move i to rcx, increment, save new value, then compare.

    movq i, %rcx
    inc %rcx
    movq %rcx, i
    cmpq $10, %rcx
    jl for1
    
    movq %rbp, %rsp # restore top stack pointer
    popq %rbp
    ret
