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
bucle:
    la  $a0, msgcifra
    li  $v0, 4
    syscall
    li  $v0, 5
    syscall
    move $s0, $v0
    blt $s0, 0, bucle
    bgt $s0, 9, bucle


	# INTRODUCE AQUI EL CODIGO EQUIVALENTE A:
	#    do {
	#        std::cout << "Introduzca un entero positivo donde se realizará la búsqueda: ";
	#        std::cin >> numero;
	#    } while (numero < 0);
	# NOTA: utiliza $s1 para almacenar el numero donde buscar la cifra
bucle2:
    la  $a0, msgnumero
    li  $v0, 4
    syscall
    li  $v0, 5
    syscall
    move $s1, $v0
    blt $s1, 0, bucle2


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
	#        if (resto == cifra) encontrado++;
	#        numero = numero / 10;
	#    } while (numero != 0);
	# NOTA: utiliza $s2 para almacenar el contador encontrado
    li  $s2, 0 #inicializo el contador a 0
    move  $t1, $s1 #muevo el numero introducido a t1
    li  $s3, 10 #inicializo t2 a 10

bucle3:
    div $t1, $s3 #divido el numero introducido entre diez
    mflo $t3 #cociente
    mfhi $t4 #resto
    beq $t4, $s0, bucle4 #si el resto de la división es igual a la cifra introducida salta al bucle4
    bne $t4, $s0, bucle5

bucle4:
    add $s2, $s2, 1 #contador es igual al contador más 1
    div $t1, $t1, $s3 #el numero introducido es igual al numero introducido dividido entre t2
    j salto

bucle5:
    div $t1, $t1, $s3 #el numero introducido es igual al numero introducido dividido entre t2
    j salto

salto:
    bne $t1, 0, bucle3 #si el numero introducido no es igual a 0 salta al bucle3
    beq $t1, 0, final


	#IMPRIME EL RESULTADO POR CONSOLA, suponiendo que en $s2 tenemos el contador de econtrados
final:
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
 
