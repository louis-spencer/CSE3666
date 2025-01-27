#       CSE 3666 Lab 1
#       TAG: deedfb266c40e5995253

        # instrutions are placed in the .text section
        .text
main:   

        # GCD examples:
        #     gcd(11, 121) = 11
        #     gcd(24, 60) = 12
        #     gcd(192, 270) = 6
        #     gcd(14, 97) = 1

        # read two positive integers from the console and 
        # save them in s1 and s2 

        # use system call 5 to read integers
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # a in s1

        addi    a7, x0, 5
        ecall
        addi    s2, a0, 0       # b in s2

        # TODO
        # Add you code here
        # compute GCD(a, b) and print it
	
	# use s0 for a
	# use s1 for b

# load a, b into s0, s1
add s0, s1, x0
add s1, s2, x0

loop:
	beq s0, s1, print 	# if equal, break and print
	
	bge s1, s0, else	# inverse logical expr for else
	sub s0, s0, s1		# a = a - b
	beq x0, x0, loop	
	
else:	sub s1, s1, s0		# b = b - a
	beq x0, x0, loop
	
	# print result at the end
print:  addi a7, x0, 1	# load sys call service
        add  a0, x0, s1	# load int to be printed
        ecall
        

        # sys call to exit
exit:   addi    a7, x0, 10      
        ecall
