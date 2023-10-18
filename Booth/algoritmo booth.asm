# Multiplicación mediante el uso del algoritmo de booth

# Comienzo del main, en donde se definen parametros

main: 
    li $v0, 5				# recibiendo multiplicando
    syscall				# llamado del sistema
    move $t0, $v0			# almacenando el multiplicando en el registro $t0
    
    li $v0, 5				# recibiendo multiplicador
    syscall				# llamado del sistema
    
    andi $t1, $v0, 0x0000ffff   	# acá se está definiendo el valor máximo que puede tomar el multiplicador, el cual es de 65535, además se realiza el almacenamiento del multiplicador en $t1
    sll $t0, $t0, 16                    # definiendo la cantidad de bits que debe ocupar de la memoria, en este caso 16
    li $t3,0                            # Guardando el último bit
    li $s0,16                           # definiendo el contador
    
# Fin del main

# Aquí comienza el algoritmo de booth para la multiplicación

loop:
    andi $t2, $t1, 1                    # $t2 = LSB($t1)
    beq $t2, $t3, loop2              	# si los dos últimos bits son 00 o 11, va a loop2 y repite hasta que los mismos sean diferentes
    beq $t2, $zero, suma              	# si los dos últimos bits son 01, realiza la suma
    sub $t1, $t1, $t0                   # se realiza una resta para ahorrarse el paso de realizar el complemento
    j loop2

# Realización de la suma 
  
suma:
    add $t1, $t1, $t0			# Suma $t0 + $t1 y se guarda en el registro $t1

# Este loop es para el proceso cuando los bits finales son 00 o 11, hasta que sean diferentes

loop2:
    sra $t1, $t1, 1                     # Desplazamiento aritmético a la derecha
    addi $s0,$s0, -1			# Se dismuinuye el contador
    move $t3, $t2			# Acá se está colocando el valor que se encuentra en $t2 en $t3, para así modificar la condición de parada del loop
    bne $s0, $zero, loop		# Acá se verifica si el contador es igual o diferente de cero
    
    li $v0, 1				# Acá se recibe la respuesta
    move $a0, $t1			# Acá se está guardando la respuesta en el registro $a0
    syscall				# Llamado al sistema
    
    move $t2, $a0			# Acá se realiza el desplazamiento del resultado de la multiplicación al registro $t2
    move $t3, $a0			# Acá se realiza el desplazamiento del resultado de la multiplicación al registro $t3
    
# Fin del programa

end:
    li $v0, 10				# Parametro para finalizar el programa		
    syscall				# llamado al sistema

