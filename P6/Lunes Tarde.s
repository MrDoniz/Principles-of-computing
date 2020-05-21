maxlen = 200 #Magic Number.
	.data
cad0: 	    .asciiz "Practica 6 de Principios de Computadores.\n"
cad1: 	    .asciiz "La suma de "
cad2: 	    .asciiz " y "
cad3: 	    .asciiz " es: "
cad4: 	    .asciiz "\nSolicita devuelve: "
endl:       .asciiz "\n"
space:      .asciiz " "
	.text
    
normaliza:
    #Almaceno en la pila la dir a la que volver.
    sw $ra, 4($sp)
    lw $s1, 8($sp)
    mtc1    $s1, $f20
    cvt.s.w $f20, $f20
    li $t0, 10
    mtc1 $t0, $f25
    cvt.s.w $f25, $f25
    div.s $f20, $f20, $f25
    
    swc1 $f20, 12($sp)
    
    #Salto a la continuación de "suma".
    lw $ra, 4($sp)
	jr $ra

suma:
    #Almaceno en la pila la dir a la que volver.
    sw $ra, 0($sp)
    
    #Argumentos de entrada: dos números enteros entre cero y diez.
    lw $s1,  8($sp)
    lw $s2, 12($sp)
    
    sw $s1, 8($sp)
    #Salto a la función "normaliza".
    jal normaliza
    lwc1 $f20, 12($sp)
    mov.s $f21, $f20
    
    sw $s2, 8($sp)
    #Salto a la función "normaliza".
    jal normaliza
    lwc1 $f20, 12($sp)
    
    add.s $f20, $f20, $f21
    
    mov.s $f12, $f20
    li $v0, 2
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
    
    #Leer por consola dos números enteros comprobando que están comprendidos entre 0 y 10.
    li $t0, 10
    comprobar:
        li   $v0, 5	#La funcion 5 lee un entero por consola.
        syscall
        move $t1, $v0
        
        li   $v0, 5	#La funcion 5 lee un entero por consola.
        syscall
        move $t2, $v0
        
        blt  $t1, $zero, comprobar
        blt  $t1, $zero, comprobar
        bgt  $t2, $t0,   comprobar
        bgt  $t2, $t0,   comprobar
    
    #Llamar a la función suma pasando como argumento los números leídos.
    sw   $t1,  8($sp)
    sw   $t2, 12($sp)
    jal suma
    
    #Imprimo un salto de línea para la siguiente ejecución del programa.
    li $v0, 4
    la $a0, endl
    syscall
    
    j main
    
salida:
    li $v0, 10
	syscall
   
