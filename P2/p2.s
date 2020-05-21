# practica 2. Principio de computadoras
# OBJETIVO: introduce el codigo necesario para reproducir el comportamiento del programa
# C++ que se adjunta como comentarios

##include <iostream>
#
#int main()
#{
#    std::cout << "Encuentra el número de veces que aparece una cifra en un entero." << std::endl;
#
#    int cifra;
#    do {
#        std::cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
#        std::cin >> cifra;
#    } while ((cifra < 0) || (cifra > 9));
#
#    int numero;
#    do {
#        std::cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
#        std::cin >> numero;
#    } while (numero < 0);
#
#    std::cout << "Buscando " << cifra << " en " << numero << " ... " << std::endl;
#    int encontrado = 0;
#    do {
#        int resto = numero % 10;
#        if (resto == cifra) encontrado++;
#        numero = numero / 10;
#    } while (numero != 0);
#
#    std::cout << "La cifra buscada se encontró en " << encontrado <<" ocasiones." << std::endl;
#    return 0;
#}

	.data		# directiva que indica la zona de datos
titulo: 	.asciiz	"Encuentra el numero de veces que aparece una cifra en un entero.\n"
msgcifra:	.asciiz	"Introduzca la cifra a buscar (numero de 0 a 9): "
msgnumero:	.asciiz	"Introduzca un entero positivo donde se realizara la busqueda: "
msgbusqueda1:	.asciiz	"Buscando cifra "
msgbusqueda2:	.asciiz	" en el numero "
msgresultado1:	.asciiz	" ...\nLa cifra buscada se encontro en "
msgresultado2:	.asciiz	" ocasiones\n"


	.text		# directiva que indica la zona de código
main:
	# IMPRIME EL TITULO POR CONSOLA
	#    std::cout << "Encuentra el número de veces que aparece una cifra en un entero." << std::endl;
	la	$a0,titulo
	li	$v0,4
	syscall

	# INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    do {
	#        std::cout << "Introduzca la cifra a buscar (numero de 0 a 9): ";
	#        std::cin >> cifra;
	#    } while ((cifra < 0) || (cifra > 9));
	# NOTA: utiliza $s0 para almacenar la cifra
  inicioBucle1:
    la	$a0,msgcifra
    li	$v0,4
    syscall
    
    li $v0, 5 #Leer por teclado.
    syscall
    move $s0, $v0
    
    
    blt $s0, $zero, inicioBucle1
    bgt $s0, 9, inicioBucle1

	# INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    do {
	#        std::cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
	#        std::cin >> numero;
	#    } while (numero < 0);
	# NOTA: utiliza $s1 para almacenar el numero donde buscar la cifra
  inicioBucle2:
    la	$a0,msgnumero
    li	$v0,4
    syscall
    
    li $v0, 5 #Leer por teclado.
    syscall
    move $s1, $v0
    
    
    blt $s1, $zero, inicioBucle2

	#IMPRIME MENSAJE DE BUSQUEDA POR CONSOLA, suponiendo que en $s0 esta la cifra a buscar
	# y en $s1 el numero en el que buscar la cifra
	la	$a0,msgbusqueda1
	li	$v0,4
	syscall

	move	$a0,$s0
	li	$v0,1
	syscall

	la	$a0,msgbusqueda2
	li	$v0,4
	syscall

	move	$a0,$s1
	li	$v0,1
	syscall

	# INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    int encontrado = 0;
	#    do {
	#        int resto = numero % 10;
	#        if (resto == cifra) 
  #          encontrado++;
	#        numero = numero / 10;
	#    } while (numero != 0);
	# NOTA: utiliza $s2 para almacenar el contador encontrado
  
  # $s2 es el contador.
  li $s2, 0
  li $t2, 10
  # Guardar el número en $t1, para usarlo sin modificar el valor inicial.
  move $t1, $s1
  
  inicioBucle3:
    # $t0 Div entera $t3 = $t1/10
    # $t3 Cociente, $t4 Resto.
    div $t1 $t2
    mflo $t3
    mfhi $t4
    # Si el resto es distinto a la cifra.
    bne $t4, $s0, inicioBucle4
    # Si el resto es igual, suma el contador.
    add $s2, $s2, 1
    
  inicioBucle4:
    div $t1, $t1, $t2
    
  bne $t1, 0, inicioBucle3

	#IMPRIME EL RESULTADO POR CONSOLA, suponiendo que en $s2 tenemos el contador de econtrados
	la	$a0,msgresultado1
	li	$v0,4
	syscall

	move	$a0,$s2
	li	$v0,1
	syscall

	la	$a0,msgresultado2
	li	$v0,4
	syscall

	# las siguientes dos instrucciones finalizan el programa
	li $v0,10
	syscall
 
