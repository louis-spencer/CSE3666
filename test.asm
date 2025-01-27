.text

 # s0, sum = 0
 addi 	s0, x0, 0
 # s1, i = 0
 addi 	s1, x0, 0
 # s2, temp = 100
 addi 	s2, x0, 100
 beq 	x0, x0, test
 
 while:
 	add 	s0, s0, s1
 	addi 	s1, s1, 1	
 test:
 	blt	s1, s2, while

 