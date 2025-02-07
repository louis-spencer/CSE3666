#       CSE 3666 Lab 2
#       TAG: 642BA0658940C84B
#	by Louis Spencer

        .text
main:   
        # use system call 5 to read integer
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # copy to s1

        # TODO
        # Add you code here
        #   reverse bits in s1 and save the results in s2
        #   print s1 in binary, with a system call
        #   print newline
        #   if s1 is NOT a binary palindrome 
        #       print s2 in binary
        #       print newline
        
        # loop 32 times
        
        # copy s1 into temp t0 for final comparison
        add t0, s1, x0
        # setup for loop
        addi t1, x0, 32
        addi t2, x0, 0
        beq x0, x0, if

for: 	# loop 32 times       
        # mask last bit into t1
        andi t3, s1, 0x01
        # shift s2 left
        slli s2, s2, 1
        # store last bit in s2
        or s2, s2, t3
        # shift s1 right
        srli s1, s1, 1
        # decrement t1
        addi t2, t2, 1
        
if: blt t2, t1, for

# print the number
addi a7 x0, 35
add a0, x0, t0
ecall

# print newline
addi a7 x0, 11
addi a0, x0, '\n'
ecall

# if palindrome, skip to exit
beq t0, s2, exit

# else, print s2 and newline
addi a7 x0, 35
add a0, x0, s2
ecall

# print newline
addi a7 x0, 11
addi a0, x0, '\n'
ecall

        # exit
exit:   addi    a7, x0, 10      
        ecall