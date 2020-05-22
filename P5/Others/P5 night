	.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palíndroma.\n\n"
cadnoespal:	.asciiz "No es palíndroma.\n\n"
	.text

strlen:
    li $v0, 0
    bucle:
        lb $s0, 0($a0)
        addi $a0, 1
        addi $v0, 1
        bne $s0, $zero, bucle

         # numero de caracteres que tiene una cadena sin considerar el '\0'
		 # la cadena tiene que estar terminada en '\0'
		 # $a0 tiene la direccion de la cadena
		 # $v0 devuelve el numero de caracteres

		 # INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN strlen SIN CAMBIAR LOS ARGUMENTOS
		 
reverse_i:
    li $t0, 0 # contador (i)
    div $t1, $a1, 2 # divido el numero de caracteres que tiene la cadena entre 2
    add $t2, $a0, $a1 # suma cadena a la que hay que dar la vuelta entre numero de caracteres que tiene la cadena
    bucle2:     # a0 = 1, t2 = 5
        lb $s0, 0($a0)
        lb $s1, 0($t2)
        addi $a0, 1
        addi $t2, -1
        addi $t0, 1
        beq $t0, $t1, fin
        beq $s0, $s1, ipanlindroma
        bne $s0, $s1, inopalindroma
    ipanlindroma:
        li $v0, 1
        j bucle2
    inopalindroma:
        li $v0, 0
    fin:
        
            # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracteres que tiene la cadena
			# $v0 1 Si es palíndroma 0 si no lo es
			
			# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_i SIN CAMBIAR LOS ARGUMENTOS
				
reverse_r:
    li $t0, 0
    li $t1, 0
    move $t2, $a0
    bucle3:
        lb $s2, 0($a0)
        addi $sp, -4
        sb $s2, 0($sp) # push s2
        addi $a0, 1
        addi $t0, 1
        blt $t0, $a1, bucle3
    bucle4:
        lb $s3, 0($t2)
        lb $s2, 0($sp)
        addi $sp, 4 #POP
        bne $s2, $s3, rnopalindroma
        beq $s2, $s3, rpalindroma
        addi $t2, 1
        addi $t1, 1
        blt $t1, $a1, bucle4
    rpalindroma:
        li $v0, 1
        j buble4
    rnopalindroma:
        li $v0, 0

            # funcion que da la vuelta a una cadena
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palíndroma 0 si no lo es
			
			# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_r SIN CAMBIAR LOS ARGUMENTOS

main:

  la $a0, cadena
  j strlen
  la $a0, cadena2
  j strlen
            # INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN main QUE REPRODUZCA LA SALIDA COMO EL GUIÓN
			# INVOCANDO A LA FUNCIÓN strlen DESPUÉS DE CADA MODIFICACIÓN DE LAS CADENAS
			
			
