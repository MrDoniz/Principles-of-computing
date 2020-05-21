maxlen = 200 #Magic Number.
	.data
cadAux:    .space maxlen
vector:	    .word 2, 5, 4, 1
cad0: 	    .asciiz "\n\nPractica 6 de Principios de Computadores.\nDaniel Dóniz García\n"
cad1: 	    .asciiz "¿Cuantos caracteres tiene su cadena?: "
cad2: 	    .asciiz "\nIntroduzca su cadena:\n"
endl:       .asciiz "\n"
space:      .asciiz " "
	.text
    
Sustituye:
    #Recibe la dir de una cadena, y dos caracteres
	#Almaceno en la pila la dir a la que volver.
	sw $ra,4($sp)
    
    lw $s0, 8($sp)
    lb $s1, 12($sp)
    lb $s2, 16($sp)
    li $s3, 0
    
    bucle:
        lb $t0, 0($s0)
        beq $t0, $s1, encuentra
        addi $s0, 1
        bne $t0, $zero, bucle
        
        j finbucle
        
    encuentra:
        sb $s2, 0($s0)
        addi $s3, 1
        addi $s0, 1
        j bucle
    
    finbucle:
        sw $s3, 20($sp)
    
	#Salto a la continuacion de "LeeYSubstituye".
	lw $ra,4($sp)
	jr $ra

LeeYSubstituye:
    #Sustituye en la cadena todas las a por i haciendo uso de la función sustituye.
    
	#Almaceno en la pila la dir a la que volver.
	sw $ra,0($sp)
    
    #Pregunto el número de caracteres.
    li $v0, 4
    la $a0, cad1
    syscall
    
    #Recibo el número de caracteres.
    li   $v0, 5
    syscall
    move $t0, $v0
    addi $t0, 1               #Le aumento 1 al número de caracteres ya que va a tomar el enter como un caracter de la cadena.
    move $s2, $t0
    
    #Informo de que escriba la cadena.
    li $v0, 4
    la $a0, cad2
    syscall
    
    #Recogo la cadena con el número de caracteres específicos.
    li $v0, 8
    la $a0, cadAux
    move $a1, $t0
    syscall
    sw $a0, 8($sp)            #Almaceno en la pila la cadena.

    
    li $t1, 'a'
    li $t2, 'i'
    sb $t1, 12($sp)
    sb $t2, 16($sp)
    
	#Salto a la funcion "Sustituye".
	jal Sustituye
    
    #Devuelve el número de caracteres sustituidos
    lw $t3, 20($sp)
    
    
    li $v0, 4
    la $a0, endl
    syscall
    #Imprimir entero
    li   $v0, 1
    move $a0, $t3
    syscall

    #Salto a la continuación de "main".
	lw $ra,0($sp)
	jr $ra

main:
    li $v0, 4
    la $a0, cad0
    syscall
    
    #Push, reservo espacio para un marco de pila.
	addi $sp,-24
	jal LeeYSubstituye
    
    lw $t1, 20($sp)
    li $t0, 8
    
    bne $t0, $t1, main
    
	
salida:
	li $v0,10
	syscall