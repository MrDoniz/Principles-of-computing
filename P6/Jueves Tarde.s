maxlen = 20 #Magic Number.
    .data
vector:     .space maxlen
cad0: 	    .asciiz "Practica 6 de Principios de Computadores.\nDaniel Dóniz García\n"
cad1: 	    .asciiz "Introduzca el numero de elementos que debe teener el vector [1-20]: "
cad2: 	    .asciiz "Introduzca siguiente elemento del vector: "
cad3: 	    .asciiz "El número de elementos pares del vector es: "
cad4: 	    .asciiz ""
space:      .asciiz " "
endl:       .asciiz "\n"
endmain:    .asciiz "\n\n\n"
	.text
    
espar:
#Si $t0/2 % 1
#   $s5 = 0
#Si $t0/2 % 0
#   $s5 = 1

	#Almaceno en la pila la dir a la que volver.
	sw $ra,4($sp)
    #Argumentos de entrada un numero entero.
    lw $t0, 16($sp)
    li $t6, 2
    
    #
    div $t6, $t0, $t6
    mfhi $t6
    
    bne $t6, $zero, espar1
    
    li $s5, 0
    sw $s5,20($sp)
    
    #Salto a la continuacion de "cuentapares".
    lw $ra,4($sp)
    jr $ra


    espar1:
        li $s5, 1
        sw $s5,20($sp)
        
        #Salto a la continuacion de "cuentapares".
        lw $ra,4($sp)
        jr $ra
    
	

cuentapares:
#Recorro un vector
#   Envío cada numero a espar
#   Recibo $s5 siendo 0 o 1
#   Si $s5 = 1, incremento t5 en 1 y salto al bucle0
#   Si $s5 = 0, salto al bucle0

	#Almaceno en la pila la dir a la que volver.
	sw $ra,0($sp)
    
    #Argumentos de entrada: dirección de memoria donde comienza un vector de enteros y número de elementos que tiene el vector.
    lw $s0, 8($sp)
    lw $t1, 12($sp)
    
    #Contar numero de pares.
    li $t3, 0 #Iterador
    li $t5, 0 #Contador de numeros pares.
    #Recorro el vector enviando cada número a "espar".
    bucle2:
        beq $t3, $t1, finbucle2
        lw $t2, 0($s0)
        addi $t3, 1
        addi $s0, 4
        
        sw $t2, 16($sp)
        #Salto a la funcion "espar".
        jal espar
        
        
        lw $t4, 20($sp)
        
        #Si el numero es 1, salto al bucle
        beq $t4, $zero, cuentapar
        j bucle2
        
        #Si el numero es 0, incremento $t5 y salto al bucle.
        cuentapar:
            addi $t5, 1
            j bucle2
            
    finbucle2:
        #Pregunto el numero de elementos del vector
        li $v0, 4
        la $a0, cad3
        syscall
        
        #Imprimir entero
        li   $v0, 1
        move $a0, $t5
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
    
    #Almaceno en la pila la dir del vector.
    la $s0, vector
    sw $s0, 8($sp)
    
    #Vector de enteros.
    li $s1, 1
    li $s2, 20
    bucle0:
        #Pregunto el numero de elementos del vector
        li $v0, 4
        la $a0, cad1
        syscall
        
        #Recojo el número de elementos del vector
        li   $v0, 5
        syscall
        move $t1, $v0
        
        #Compruebo que esté dentro del rango permitido.
        blt $t1, $s1, bucle0
        bgt $t1, $s2, bucle0
        
    #Almaceno en la pila la dimención del vector.    
    sw $t1, 12($sp)
    li $t0, 0 #Iterador.
    bucle1:
        #Imprimo informacion para que introduzca el numero.
        li $v0, 4
        la $a0, cad2
        syscall
        
        #Recojo el número que introduciré en el vector
        li   $v0, 5
        syscall
        move $s1, $v0
        
        sw $s1, 0($s0)
        addi $s0, 4
        addi $t0, 1
        
        blt $t0, $t1, bucle1
        
    
	jal cuentapares
    
    li $v0, 4
    la $a0, endmain
    syscall
	
salida:
	li $v0,10
	syscall