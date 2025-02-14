#       CSE 3666 HW 2
#	by Louis Spencer


# Skeleton code provided by CSE3666
# Addition of decimal strings

# strings are stored in global data section 
        .data   
dst:    .space  128
str1:   .space  128
str2:   .space  128

# instructions are in text section
        .text
main: 
        # load adresses of strings into s1, s2, and s3
        # s3 is dst, where we store the result 

        lui     s3, 0x10010 
        addi    s1, s3, 128
        addi    s2, s1, 128

        # read the first number as a string
        addi    a0, s1, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        # read the second number as a string
        addi    a0, s2, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall

        #TODO
        # write a loop to find out the number of decimal digits in str1
        # the loop searches for the first character that is less than '0' 

        # Note that we assume str1, str2, and dst have the same number of 
        # decimal digits. 
        
        
        # i= 0
        # do
        # 	c = str[i]
        #	i += 1
        # while c != 0
        
        
        addi s4, x0, 0 # init to 0
       	strlen:
       		add t0, s1, s4	# str_addr + i
       		lb t0, 0(t0)	# load str[i]
       		addi s4, s4, 1  # i++
       	str_test:
       		bne t0, x0, strlen # if not null, keep looping
       		
       	# note: calculated len = strlen + 1 (null) + 1 (extra)

        # We then write a loop to add str1 and str2, and save the result in 
        # dst. 
        # Remember that dst should have a terminating null character.
        
        # AND with 0x0f mask to convert to decimal
        # perform math
        # OR with 0x30 mask to convert back to string
        
        # j = i
        # do
        #	t2 = str1[j] & 0x0f
        #	t3 = str2[j] & 0x0f
        #	t2 = t2 + t3
        #	t2 = t2 | 0x30
        #	dst[j] = t2
        #	j--
        # while j > 0
        # dst[i] = null
        
        # from above
        # note: calculated len = strlen + 1 (null) + 1 (extra)
        # subtract 3 for null, extra, and to properly index (0..n-1) = n elements
        
		addi t0, s4, -3
		addi t4, x0, 10
		addi t6, x0, 0	# carry
		
		for:
        	add t1, t0, s1		# get mem addr of s1 + offset
        	lb t2, 0(t1)		# load into t2
        	andi t2, t2, 0x0f	# AND last 4 bits
        	
        	add t1, t0, s2		# get mem addr of s2 + offset
        	lb t3, 0(t1)		# load into t3
        	andi t3, t3, 0x0f	# AND last 4 bits
        	
        	add t2, t2, t3		# add together
        	add t2, t2, t6		# add carry
        	
        	addi t6, x0, 0		# carry = 0
			blt t2, t4, skip	# if t2 < 10, skip carry
        	sub t2, t2, t4		# else, t2 = t2 - 10
        	addi t6, x0, 1		# carry = 1
        	
        	skip:
        	ori t2, t2, 0x30	# OR to turn to ASCII 
        	
        	add t1, t0, s3		# get mem addr of dst + offset
        	sb t2, 0(t1)		# dst[j] = t2
        	 
        	addi t0, t0, -1		# j--
        for_test:
        	bge t0, x0, for
        
        add t1, s4, s3	# get mem addr of s3 + final
        sb x0, 0(t1)	# store null terminator

        # find the length
        # do addition
        # print the result
        
        addi a7 x0, 4	# use syscall 4 to print null-terminated str
		add a0, x0, s3
		ecall

        # exit
        addi    a7, x0, 10
        ecall

