.data
texto1: .asciiz "Digite un numero entero: "
tag2: .asciiz "El valor de la paridad del numero "
tag3: .asciiz " es par"
tag4: .asciiz " es impar"
.text
main:
	la  $a0, texto1 #load address
	li $v0, 4 #load immediate funcion 4 imprime string
	syscall
	li $v0, 5 #v0 contains integrer read
	syscall
	move $t0, $v0 #ahora tengo  el valor de n guardado en $t0
	
	jal calcular
	beq $t1,0,par
	jal impar
	break
calcular:
	and $t1, $t0, 1
	jr $ra
par:
	la  $a0, tag2
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0,1
	syscall
	
	syscall
	la  $a0, tag3
	li $v0, 4
	syscall
	break
impar:
	la  $a0, tag2
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0,1
	syscall
	
	la  $a0, tag4
	li $v0, 4
	syscall
	jr $ra
