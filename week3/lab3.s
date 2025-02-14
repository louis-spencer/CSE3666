#       CSE 3666 Lab 3: remove consecutive duplicate characters
#       TAG: 6AE978ED678D10E0DE8S25
#	By Louis Spencer

        .data
        # allocating space for both strings
str:    .space  128
res:    .space  128

        .text
main:   
        # load (hard-coded) address of strings 
        lui     s2, 0x10010    # str
        addi    s3, s2, 128    # res

        # read a string into str
        addi    a0, s2, 0 
        addi    a1, x0, 120
        addi    a7, x0, 8
        ecall

        # TODO
        # remove duplicate characters in str
        #     your code changes t registers only in this step.
        # print res
        
#	i = 0           // index to src
#	j = 0           // index to res
# 	lastchar = -1
# 	do
#    		c = str[i]
#    		i += 1
#    		if c != lastchar
#        		res[j] = c
#        		j += 1
#        		lastchar = c
# 	while c != 0

#	use lb (load byte) and wb (write byte)
#	s2 = str, s3 = res

addi t0, x0, 0	# i = 0
addi t1, x0, 0	# j = 0
addi t2, x0, -1 # lastchar = -1
               
while:
	add t3, s2, t0	# str + i
	lb t3, 0(t3)	# load str[i] into t3
			# c=t3
	addi t0, t0, 1	# i++
	
	beq t2, t3, test # c == lastchar, goto test
	add t4, s3, t1	# res + j
	sb t3, 0(t4)	# write t3 into res[j] 
	addi t1, t1, 1	# j++
	add t2, x0, t3	# update t2 with t3
test:
	bne t3, x0, while

# print result using system call
addi a7 x0, 4
add a0, x0, s3
ecall
               
exit:   addi    a7, x0, 10
        ecall
