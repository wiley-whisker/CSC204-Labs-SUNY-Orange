.global main

.text
main:
    xor %rax, %rax # Clear rax register, it will be our sum register.
    movq $x, %rbx # Move pointer for x into rbx
    movq $0, %rcx # Move starting index to rcx, this functions like i.

    # While loop entry condition.
    cmpq $10, %rcx # Compare 10(len of array) against i (rcx).
    jge endwhile # Skip while loop if contition is not met.
    while:
        lea (%rbx, %rcx, 8), %rdx # Load x[rcx] into rdx.
        add (%rdx), %rax # Add x[rcx] to sum. store in sum.

        inc %rcx # rcx++.

        # Compare for repeat.
        cmpq $10, %rcx # Compare 10(len of array) against i (rcx).
        jl while # Repeat loop while rcx < 10
    
    endwhile:

    movq %rax, sum # Move the value of rax (the sum) into our sum variable

    # Exit program.
    movq   $60,    %rax     # exit(
    movq   $0,     %rdi     # EXIT_SUCCESS
    syscall


.data
    x: .quad 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 # Declare an array with 10 entries.
    sum: .quad 0
