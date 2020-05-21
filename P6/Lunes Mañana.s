maxlen = 200 #Magic Number.
	.data
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
    
suma:
    #Almaceno en la pila la dir a la que volver.
    sw $ra,  4($sp)
    
    #Recibe como argumento dos números en punto flotante.
    lwc1 $f20,  8($sp)
    lwc1 $f21, 12($sp)
    
    #Devulve la suma de los dos números.
    add.s $f22, $f20, $f21
    
    #Imprimo toda la operación.
    li $v0, 4
    la $a0, cad1
    syscall
    li	$v0, 2
    mov.s $f12, $f20.
	syscall
    li $v0, 4
    la $a0, cad2
    syscall
    li	$v0, 2
    mov.s $f12, $f21.
	syscall
    li $v0, 4
    la $a0, cad3
    syscall
    li	$v0, 2
    mov.s $f12, $f22.
	syscall
    li $v0, 4
    la $a0, endl
    syscall
    
    #Devuelve la suma de los dos números.
    swc1 $f22, 16($sp)
    
    #Salto a la continuación de "solicita".
    lw $ra, 4($sp)
	jr $ra

solicita:
    #Almaceno en la pila la dir a la que volver.
    sw $ra, 0($sp)
    
    #Recibe como argumentos dos números en punto flotante.
    li    $v0, 6	#6, Función leer flotante simple presición.
	syscall
	mov.s $f20, $f0	#Almaceno en $f1 el valor.
	li    $v0, 6	#6, Función leer flotante simple presición.
	syscall
	mov.s $f21, $f0	#Almaceno en $f2 el valor.
    
    #Almaceno los argumentos en la pila
    swc1 $f20,  8($sp)
    swc1 $f21, 12($sp)
    
    #Salto a la función "suma".
    jal suma   
    
    #Devuelve 1 si la suma es mayor que cualquiera de los dos sumandos y 0 en caso contrario.
    li $t0, 1
    c.lt.s $f22, $f20
        bc1t solicitaF
    c.lt.s $f22, $f21
        bc1t solicitaF
    
    j solicitaT
    
    lwc1 $f22, 16($sp)
    solicitaF:
        li $t0, 0
        
    solicitaT:
        #sw $t0, 28($sp)
        li $v0, 4
        la $a0, cad4
        syscall
        li   $v0, 1  #La funcion 1 imprime un entero por consola.
        move $a0, $t0
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
    jal solicita
    
    #Imprimo un salto de línea para la siguiente ejecución del programa.
    li $v0, 4
    la $a0, endl
    syscall
    
    j main
    
salida:
    li $v0, 10
	syscall
   
