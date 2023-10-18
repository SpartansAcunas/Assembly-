.data
								
        X:    				.asciiz "\nAnote el multiplicando: "
							
        Y:    				.asciiz "Anote el multiplicador: "
							
        R:   			.asciiz "Respuesta de la multiplicación: "
								
.text

main:
    #Leyendo el Multiplicando
    li  $v0,4           			 
    la  $a0,X        			
    syscall             			# Llama el sistema

    #Cargando el Multiplicando
    li  $v0,5           			# Lee el valor de X
    syscall             			
    move    $s0,$v0     			# mueve el dato  de $v0 para $s0

    #Leyendo el Multiplicador
    li  $v0,4           			
    la  $a0,Y       			
    syscall             			# Llamada del sistema

    #Cargando el Multiplicador
    li  $v0,5          				# Lee el valor de Y
    syscall             			# Llama el sistema 
    move    $s1,$v0     			# mueve el valor de $v0 para $s1

    jal Multiplica					# Salto a la dirección específica, guarda la dirección de la intrucción en $ra
    j   finaliza					# Salta la siguiente dirección de memoria



Multiplica:
    move $s3, $zero       			
    move $s4, $zero 				
    beq $s1, $zero, salto				# Cancela si $s1 == $zero
    beq $s0, $zero, salto				# Cancela si $s0 == $zero

ciclo:
    andi $t0, $s0, 1    			# obtiene el bit menos significativo de $s0 y lo pone en $t0			
    beq $t0, $zero, Desplaza 			# funcion de desplazamiento hace la función de acarreo  			
    addu $s3, $s3, $s1  			# incrementa
    sltu $t0, $s3, $s1 				# acarreo			
    addu $s4, $s4, $t0  			# incrementa
    addu $s4, $s4, $s2  			# incrementa
	
Desplaza:    
    srl $t0, $s1, 31    			# desplazamiento hacia la derecha 		
    sll $s1, $s1, 1					# desplazamiento a la izquierda 
    sll $s2, $s2, 1					# desplazamiento a la izquierda 
    addu $s2, $s2, $t0				

    srl $s0, $s0, 1     			# desplazamiento hacia la derecha
    bne $s0, $zero, ciclo			# condicional para que se repita si $s0 != $zero

salto:
    jr $ra							# salta y guarda en la dirección  $ra



finaliza:
   
    li  $v0,4           			# carga el valor
    la  $a0,R      			# carga direccion
    syscall             			

    li  $v0,1           			# imprime la respuesta
    move    $a0,$s3     			# coloca la respuesta en $a0
    syscall             			
   
    li  $v0,10         				
    syscall             			# Fin