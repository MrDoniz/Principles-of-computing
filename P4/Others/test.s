    ###################################################################################

  invertirFila:
    #Inicializo los registros temporales que utilizare.
    li $v0, 4	#La funcion 4 imprime una cadena por consola
    la $a0, cad3
    syscall

    li $v0, 1  #La funcion 1 imprime un entero por consola
    move $a0, $s3
    syscall

    li $v0, 4	#La funcion 4 imprime una cadena por consola
    la $a0, cad6
    syscall

    li $v0, 5	#La funcion 5 lee un entero por consola.
    syscall
    move $t0, $v0
      
    addi $t0, -1	    #registro para f
    li $t1, 0			#registro para j
    li $t3, 0			#registro para guardar aux
    addi $t2, $s4, -1
    li $t4, 2
    div $t2, t4
    mflo $t2			#registro que guarda la condicion de salida
    
	
    mul $t0, $t0, $s4
    buclefila
    
    lw $t3, 
    
    addi $t1, 1
    ble $t1, t2, buclefila
    
    
    addu $, $, $s0
    
	
          for (j = 0; j <= (ncols-1) / 2; j++) {
            aux = matrix[f][j];
            matrix[f][j] = matrix[f][ncols-1-j];
            matrix[f][ncols-1-j] = aux;
            
              bucleMatriz1:
    #Contengo el desplazamiento relativo y la direccion del elemento que quiero mostrar en el registro $t1
    mul $t1, $t0, $s2
    addu $t1, $t1, $s0 
      
    #Cargo el elemento que quiero mostrar en el registro $t2 y lo muestro por pantalla
    lw $t2, 0($t1)
    li $v0, 1
    move $a0, $t2
    syscall

      li $v0, 4
    la $a0, space
    syscall
      
    #Realizo los incrementos necesarios para continuar el bucle y y luego salir
    addi $t0, $t0, 1
    add $t3, $t3, 1
    add $t4, $t4, 1
    bne $t4, $s4, bucleMatriz1

    j MostrarMatriz
    ###################################################################################
 