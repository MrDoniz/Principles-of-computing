maxlen = 200 #Magic Number.
	.data
vector:	    .word 2, 5, 4, 1
nvector:    .word 4
cad0: 	    .asciiz "Practica 6 de Principios de Computadores.\n"
cad1: 	    .asciiz "La suma de "
cad2: 	    .asciiz " y "
cad3: 	    .asciiz " es: "
cad4: 	    .asciiz "\nSolicita devuelve: "
cad5: 	    .asciiz ""
cad6: 	    .asciiz ""
cad7: 	    .asciiz ""
cad8: 	    .asciiz ""
cad9: 	    .asciiz ""
endl:       .asciiz "\n"
space:      .asciiz " "
	.text
    
Encuentra:
    #Almaceno en la pila la dir a la que volver.
    sw $ra, 4($sp)
    #Recibe una dirección de memoria donde comienza un vector de enteros, un entero 
    lw $t0, 8($sp)
    lw $t1, 12($sp)
    lw $t2, 16($sp)
    li $t3, -1
    li $t4, 0
    bucle0:
        lw   $t5, 0($t0)
        beq  $t5, $t1, bucle1
        addi $t0, 4
        addi $t4, 1
        blt  $t4, $t2, bucle0
        j bucle2
    bucle1:
        add $t3, $t4, 1
    bucle2:
        sw $t3, 16($sp)
    

    #Salto a la continuación de "suma".
    lw $ra, 4($sp)
	jr $ra

SolicitarYBusca:
    #Almaceno en la pila la dir a la que volver.
    sw $ra, 0($sp)
    
    #Solicita un entero por consola.
    li   $v0, 5
    syscall
    move $t0, $v0
    
    li $v0, 4
    la $a0, endl
    syscall
    
    #Almaceno en la pila un entero.
    sw $t0, 12($sp)
    
    #Llama a Encuentra.
    jal Encuentra
    
    lw $t0, 12($sp)
    lw $t1, 16($sp)
    li   $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, endl
    syscall
    
    li   $v0, 1
    move $a0, $t1
    syscall

    #Salto a la continuación de "main".
    lw $ra, 0($sp)
	jr $ra

main:
    li $v0, 4
    la $a0, cad0
    syscall
    
    #Push, reservo espacio para un marco de pila.
    addi $sp, -20
    
    #Almaceno en la pila la dir del vector.
    la $s0, vector
    sw $s0, 8($sp)
    lw $s0, nvector
    sw $s0, 16($sp)
    
    li $v0, 4
    la $a0, endl
    syscall

    jal SolicitarYBusca
    lw $t0, 16($sp)
    li $t1, -1
    
    #Imprimo salto de linea
    li $v0, 4
    la $a0, endl
    syscall
    
    beq $t1, $t0, main
    
salida:
    li $v0, 10
	syscall
   
