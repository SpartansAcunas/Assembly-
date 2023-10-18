.data
	msg1:.asciiz "Indique el n: \n "
	ans: .word 0
	num: .word 0
.text


main:

	li $v0,4
	la $a0,msg1
	syscall #imprime el msj
	
	li $v0,5
	syscall #lee un numero
	sw $v0,num #lo guarda en num

	lw $a0,num
	jal fib # llama a la funcion fib
	sw $v0,ans
	
	li $v0,1
	lw $a0,ans
	syscall  # muestra el resultado

	li $v0,10
	syscall # termina el proceso

fib:
	addi $sp,$sp,-12 #guarda espacio en el stack
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)

	add $s0,$a0,$zero

	addi $t1,$zero,1
	beq $s0,$zero,retornar0 # si es 0 retorna 0
	beq $s0,$t1,retornar1# si en 1 retorna 1

	addi $a0,$s0,-1

	jal fib

	add $s1,$zero,$v0     

	addi $a0,$s0,-2

	jal fib               
	
	add $v0,$v0,$s1       
terminar:

	lw $ra,0($sp)       
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12     
	jr $ra    # se devuelve

retornar1:
 	li $v0,1
 	j terminar
retornar0 :
     li $v0,0
     j terminar
