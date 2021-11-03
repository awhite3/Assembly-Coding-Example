#Alex White
#CSCI 4720
#Homework 3
#2/24/13
#
# Objective: Computes the first 400 prime numbers
# and prints out the prime numbers between 2000 and 
# 2100, then prints out the next prime year after that.
#
################### Data Segment ###################
.data
test: .asciiz "TEST"
  br:      .asciiz  "\n"
  output1: .asciiz "The prime numbers between 2000 and 2100:\n"
  output2: .asciiz "The next year that will be prime is: "
################### Code Segment ###################
.text
.globl main
main:

  li	$v0, 4		# prints the string output1
  la	$a0, output1
  syscall
 
  add 	$fp, $zero, $sp	# initialize the frame pointer
  addi 	$s0, $zero, 0	# set $s0 to 0 (number of primes found)
  addi 	$s1, $zero, 400	# set $s1 to 400 (number of primes we are looking for)
  addi 	$s2, $zero, 2	# set $s2 to 2	(current number being checked)
  addi  $s4, $zero, 0  	# set $s4 to 0 to use for finding next year after 2100
  
FOR_LOOP:  
  move 	$a0, $s2	# set $a1 to $s2 to test if $s2 is prime
  jal is_prime
  beqz	$v0, endif	# if $s0 is not prime, go to endif
  

  move	$a0, $s2
  jal check_prime

  beqz	$v0, prime_endif# if $s2 isn't between 2000 and 2100 go to prime_endif
  
  beq	$v0, $s4, skip	# if we have begun to get into primes between 2000 and 2100
  addi $s4, $zero, 1	# then we will know the next prime that fails check prime is the last
skip:

  la	$a0, ($s2)	# sets $a0 to $s2 so it can be printed
  li 	$v0, 1
  syscall
    
  la	$a0, br		# displays a new line
  li	$v0, 4	
  syscall
  j endif
  
prime_endif:    
  bnez	$s4, LAST_CASE
  
endif: 
  addi 	$s2, $s2, 1	# loop counter incremented (i++)
  j FOR_LOOP

LAST_CASE:
  li	$v0, 4		# prints the string output2
  la	$a0, output2
  syscall
  
  move	$a0, $s2	# sets $a0 to $s0 so it can be printed
  li 	$v0, 1
  syscall
  
  li 	$v0, 10		# exit
  syscall
  
  # end main
  
 .text
is_prime:
  addi	$v0, $zero, 0	# initialize return to 0, only set to 1 if prime
  addi 	$s3, $zero, 2
  
LOOP:   
  sne	$t0, $a0, 2	# if $a0 = 2 then return true because it is special
  beqz 	$t0, LOOP_END_TRUE

  sne 	$t0, $s3, $a0	# if $s3 = $a0 exit loop and return true
  beqz 	$t0, LOOP_END_TRUE
  
  div 	$a0, $s3		# if $a0 % $s3 = 0 return false
  mfhi 	$t1
  beqz 	$t1, LOOP_END

  addi 	$s3, $s3, 1	# $s3++
  j LOOP               	# restart the loop 
  
LOOP_END_TRUE:
  addi 	$v0, $zero, 1 
LOOP_END:      
  jr 	$ra

.text
check_prime:
  addi 	$v0, $zero, 0	# initialize return to 0, only set to 1 if between 2000 and 2100
  addi 	$t1, $zero, 2000
  addi 	$t2, $zero, 2100
  
  sgt  	$t0, $a0, $t1	# if $a0 > 2000, $t0 = 1
  beqz 	$t0, END
  
  slt 	$t0, $a0, $t2	# if $a0 < 2100, $t0 = 1
  beqz 	$t0, END
  
  addi 	$v0, $zero, 1
    
END:    
  jr 	$ra
