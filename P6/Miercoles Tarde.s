maxlen = 200 #Magic Number.
	.data
cadAux:    .space maxlen
cad0: 	    .asciiz "Practica 6 de Principios de Computadores.\n"
cad1: 	    .asciiz "¿Cuantos caracteres tiene su cadena 1?: "
cad2: 	    .asciiz "\nIntroduzca su cadena 1:\n"
cad3:       .asciiz "¿Cuantos caracteres tiene su cadena 2?: "
cad4:       .asciiz "\nIntroduzca su cadena 2:\n "
cad5: 	    .asciiz "\nCompareString devuelve:"
endl:       .asciiz "\n"
	.text
SumaString:
    #Almaceno en la pila la dir a la que volver.
    sw $ra,  4($sp)
    
    #Recibe la dirección de comienzo de una cadena de tipo asciiz.
    lw $t0, 8($sp)
    li   $t1, 1
    li   $t2, 0
    bucle1:
        lb  $t3, 0($t0)
        addi $t0, 1
        add $t2, $t2, $t3
        addi $t1, 1
        ble  $t1, $s2, bucle1
    #Imprimo salto de linea
    li $v0, 4
    la $a0, endl
    syscall
    #Devuelve la suma de los valores ASCII de cada uno de los caracteres dela cadena.
    li	$v0, 1
    move $a0, $t2
    syscall
    #Imprimo salto de linea
    li $v0, 4
    la $a0, endl
    syscall
    #Salto a la continuación de "ComparaString".
    lw $ra, 4($sp)
	jr $ra

ComparaString:
    #Almaceno en la pila la dir a la que volver.
    sw $ra, 0($sp)
    
    #Lee dos cadenas de consola.
    #Cadena1
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
        
        #Salto a la función "SumaString".
        jal SumaString
        
        move $s3, $s2
    
    #Cadena2
        #Pregunto el número de caracteres.
        li $v0, 4
        la $a0, cad3
        syscall
        
        #Recibo el número de caracteres.
        li   $v0, 5
        syscall
        move $t0, $v0
        addi $t0, 1               #Le aumento 1 al número de caracteres ya que va a tomar el enter como un caracter de la cadena.
        move $s2, $t0
        
        #Informo de que escriba la cadena.
        li $v0, 4
        la $a0, cad4
        syscall
        
        #Recogo la cadena con el número de caracteres específicos.
        li $v0, 8
        la $a0, cadAux
        move $a1, $t0
        syscall
        sw $a0, 8($sp)            #Almaceno en la pila la cadena.
        
        #Salto a la función "SumaString".
        jal SumaString
    
    #Haciendo uso de la función anterior devuelve 1 si la suma de los valores ASCII de la primera es mayor que la segunda y 0 en caso contrario.
    
    li $t0, 1
    bgt $s2, $s3 ComparaStringT
    j ComparaStringFin
    
    ComparaStringT:
        li $t0, 0
    ComparaStringFin:
        li $v0, 4
        la $a0, cad5
        syscall
        li   $v0, 1  #La funcion 1 imprime un entero por consola.
        move $a0, $t0
        syscall
    #Imprimo salto de linea
    li $v0, 4
    la $a0, endl
    syscall
    
    sw $t0, 12($sp)            #Almaceno en la pila.
    #Salto a la continuación de "main".
    lw $ra, 0($sp)
	jr $ra

main:
    li $v0, 4
    la $a0, cad0
    syscall
    #Push, reservo espacio para un marco de pila.
    addi $sp, -20
    li $s0, 1
    #El main llama a ComparaString hasta que devuelva 0.
    bucle0:
        jal ComparaString
        lw $t0, 12($sp)
        bne $t0, $zero, bucle0
salida:
    li $v0, 10
	syscall
   
