maxlen = 200 #Magic Number.
	.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palíndroma.\n\n"
cadnoespal:	.asciiz "No es palíndroma.\n\n"
cadAux: .space maxlen
	.text
    
strlen:
# numero de caracteres que tiene una cadena sin considerar el '\0'
# la cadena tiene que estar terminada en '\0'
# $a0 tiene la direccion de la cadena
# $v0 devuelve el numero de caracteres
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN strlen SIN CAMBIAR LOS ARGUMENTOS
    addi $sp,   0
	sw 	 $ra,  -4($sp)
    lw   $a0,  -8($sp)
    li   $v0,   0
    bucle:
        lb   $t0,  0($a0)
        addi $a0,  1
        addi $v0,  1
        bne  $t0,  $zero, bucle
        addi $v0, -1
        
    move $t1, $v0
    li   $v0,  4
    lw   $a0, -8($sp)
    syscall
    li   $v0,  4
    la   $a0, cadtiene
    syscall
    li   $v0, 1
    move $a0, $t1
    syscall
    li   $v0, 4
    la   $a0, cadcarac
    syscall
    
    sw $v0, -12($sp)
    lw $ra, -4($sp)
	jr $ra

reverse_i:
# funcion que da la vuelta a una cadena
# $a0 cadena a la que hay que dar la vuelta
# $a1 numero de caracteres que tiene la cadena
# $v0 1 Si es palíndroma 0 si no lo es
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_i SIN CAMBIAR LOS ARGUMENTOS
    sw   $ra, -4($sp)
    lw   $a1, -12($sp)
    lw   $a0, -8($sp)
    li   $t0,  0
    div  $t1,  $a1, 2
    add  $s0,  $a0, $a1
    addi $t1, -1
    bucle1:
        lb   $t2,  0($a0)
        lb   $t3,  0($s0)
        sw   $t2,  0($s0)
        sw   $t3,  0($a0)
        addi $a0,  1
        addi $s0, -1
        addi $t0,  1
        beq  $t0,  $t1, reviEnd
        beq  $t2,  $t3, reviT
        bne  $t2,  $t3, reviF
    reviT:
        li $v0, 1
        j bucle1
    reviF:
        li $v0, 0
        sw $v0, -16($sp)
        li $v0, 4
        la $a0, cadnoespal
        syscall
        
        lw $ra, -4($sp)
        jr $ra
    reviEnd:
        sw $v0, -16($sp)
        li $v0, 4
        la $a0, cadespal
        syscall
        li $v0, 4
        lw $a0, -8($sp)
        syscall
        
        lw $ra, -4($sp)
        jr $ra

reverse_r:
# funcion que da la vuelta a una cadena
# $a0 cadena a la que hay que dar la vuelta
# $a1 numero de caracternes que tiene la cadena
# $v0 1 Si es palíndroma 0 si no lo es
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN reverse_r SIN CAMBIAR LOS ARGUMENTOS
    sw $ra, -4($sp)
    lw $a1, -12($sp)
    lw $a0, -8($sp)
    li $t0,  0
    bucle2:
        lb   $t1, 0($a0)
        sb   $t1, 4($sp)
        addi $a0, 1
        addi $t0, 1
        bne  $t0, $a1, bucle2
    lw $a0, -8($sp)
    li $t0,  0
    bucle3:
        lb   $t1, 0($a0)
        lb   $t2, -4($sp)
        addi $a0, 1
        addi $t0, 1
        beq  $t0, $a1, reviEnd
        beq  $t2, $t1, revrT
        bne  $t2, $t1, revrF
    revrT:
        li $v0, 1
        j bucle3
    revrF:
        li $v0, 0
    revrEnd:
        sw $v0, -20($sp)
        lw $ra, -4($sp)
        jr $ra

main:
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN main QUE REPRODUZCA LA SALIDA COMO EL GUIÓN
# INVOCANDO A LA FUNCIÓN strlen DESPUÉS DE CADA MODIFICACIÓN DE LAS CADENAS
    la   $s0, cadena
    sw   $s0, -8($sp)
    jal strlen
    jal reverse_i
    jal reverse_r
    
salida:
    li $v0, 10
	syscall
   
