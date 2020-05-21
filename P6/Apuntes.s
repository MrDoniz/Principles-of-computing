#Imprimir entero
    li   $v0, 1
    move $a0, $t0
    syscall
#Imprimir flotante $f22
    li $v0, 2
    mov.s $f12, $f22.
	syscall
#Imprimir cadena cad1
    li $v0, 4
    la $a0, cad1
    syscall

#Cargar caracter
li $t1, 'a'
#Cargar double
li.d $f22,0.0


#Escanear entero
    li $v0, 5
    syscall
    move $t0, $v0
#Escanear flotante $f22
    li $v0, 6
	syscall
	mov.s $f22, $f0


#Sumar flotantes
    add.s $f23, $f22, $f21    


#Almacenar en la pila
    sw $ra,  4($sp)
#Cargar en la pila
    lw $ra, 4($sp)
#Saltos con la pila
    jr $ra
    jal main
#Almacenar dir en la pila
    sw $t0, 8($sp)
#Cargar dir en la pila
    lw $t0, 8($sp)
#Almacenar flotante en la pila
    swc1 $f22, 8($sp)
#Cargar flotante en la pila
    lwc1 $f22, 8($sp)
#Almacenar caracter
    sb  $t2, 0($t0)
#Cargar caracter 
    lb  $t2, 0($t0)


#Mover entero
    move $s2, $s1
#Mover flotante
    mov.s $f21, $f0	


#Comparar flotante, salto
    c.lt.s $f22, $f20
    bc1t solicitaF


#Pasar flotante a entero
    cvt.w.s $f22, $f22
    mfc1 $t0,$f22
#Pasar entero a flotante
    mtc1 $t0, $f22
    cvt.s.w $f22, $f22
    
#Pasar double a entero
    cvt.w.s $f22, $f22
    mfc1 $t0,$f22
#Pasar entero a double (Ocupa f22 y f23)
    mtc1.d $t0, $f22
    cvt.d.w $f22, $f22


cvt.d.s	Fd, Fs	#convert float to double
cvt.d.w	Fd, Rs	#convert integer to double
cvt.s.d	Fd, Fs	#convert double to float
cvt.s.w	Fd, Rs	#convert integer to float
cvt.w.d	Rd, Fs	#convert double to integer
cvt.w.s	Rd, Fs	#convert float to integer

add	Rd, Rs1, Rcs2	#add int
div	Rd, Rs1, Rcs2	#divide int
mul	Rd, Rs1, Rcs2	#multiply int
neg	Rd, Rs	        #negate int (with overflow)
negu	Rd, Rs	    #negate int (without overflow)
rem	Rd, Rs1, Rcs2	#divide int (Rd = remainder)
sub	Rd, Rs1, Rcs2	#subtract int

add	Rd, Rs1, Rcs2	#add int
div	Rd, Rs1, Rcs2	#divide int
mul	Rd, Rs1, Rcs2	#multiply int
neg	Rd, Rs	        #negate int
rem	Rd, Rs1, Rcs2	#divide int (Rd = remainder)
sub	Rd, Rs1, Rcs2	#subtract int

abs.d	Rd, Rs	        #absolute value double
abs.s	Rd, Rs	        #absolute value float
add.d	Fd, Fs1, Fcs2	#add double
add.s	Fd, Fs1, Fcs2	#add float
div.d	Fd, Fs1, Fcs2	#divide double
div.s	Fd, Fs1, Fcs2	#divide float
mul.d	Fd, Fs1, Fcs2	#multiply double
mul.s	Fd, Fs1, Fcs2	#multiply float
neg.d	Fd, Fs	        #negate double
neg.s	Fd, Fs	        #negate float
sub.d	Fd, Fs1, Fcs2	#subtract double
sub.s	Fd, Fs1, Fcs2	#subtract float

abs.d	Rd, Rs	        #absolute value double
add.d	Fd, Fs1, Fcs2	#add double
div.d	Fd, Fs1, Fcs2	#divide double
mul.d	Fd, Fs1, Fcs2	#multiply double
neg.d	Fd, Fs	        #negate double
sub.d	Fd, Fs1, Fcs2	#subtract double

and	Rd, Rs1, Rcs2	#bitwise and
nand Rd, Rs1, Rcs2	#bitwise nand
nor	Rd, Rs1, Rcs2	#bitwise nor
not	Rd, Rs	        #bitwise not
or	Rd, Rs1, Rcs2	#bitwise or
rol	Rd, Rs1, Rcs2	#left rotate
ror	Rd, Rs1, Rcs2	#right rotate
sll	Rd, Rs1, Rcs2	#left shift
sra	Rd, Rs1, Rcs2	#arithmetic (sign extended) right shift
srl	Rd, Rs1, Rcs2	#logical (zero extended) right shift
xor	Rd, Rs1, Rcs2	#bitwise exclusive or
###########################################################################
#Escribir cadena
maxlen = 200 #Magic Number.
cadAux:    .space maxlen
cad1: 	.asciiz "¿Cuantos caracteres tiene su cadena?: "
cad2:   .asciiz "\nIntroduzca su cadena:\n"
    #Pregunto el número de caracteres.
    li $v0, 4
    la $a0, cad1
    syscall
    
    #Recibo el número de caracteres.
    li   $v0, 5
    syscall
    move $t0, $v0
    addi $t0, 1               #Le aumento 1 al número de caracteres ya que va a tomar el enter como un caracter de la cadena.
    #Almaceno en la pila el tamaño de la cadena
    sw $t0, 8($sp)
    
    #Informo de que escriba la cadena.
    li $v0, 4
    la $a0, cad2
    syscall
    
    #Recogo la cadena con el número de caracteres específicos.
    li $v0, 8
    la $a0, cadAux
    move $a1, $t0
    syscall
    
    #Almaceno en la pila la dir de la cadena.
    sw $a0, 12($sp)

#Recorrer cadena
    lw $t0, 8($sp)
    lw $t1,12($sp)
    li $t2, 1
    bucle1:
        lb  $t3, 0($t1)
        addi $t1, 1
        addi $t2, 1
        ble  $t2, $t0, bucle1

###########################################################################
#Esquema
maxlen = 200 #Magic Number.
    .data
cadAux:     .space maxlen
vector:	    .word 2, 5, 4, 1
cad0: 	    .asciiz "\n\nPractica 6 de Principios de Computadores.\nDaniel Dóniz García\n"
endl:       .asciiz "\n"
space:      .asciiz " "
	.text
    
funcion2:
	#Almaceno en la pila la dir a la que volver.
	sw $ra,4($sp)
    
	#Salto a la continuacion de "funcion1".
	lw $ra,4($sp)
	jr $ra

funcion1:
	#Almaceno en la pila la dir a la que volver.
	sw $ra,0($sp)
    
	#Salto a la funcion "funcion2".
	jal funcion2

    #Salto a la continuación de "main".
	lw $ra,0($sp)
	jr $ra

main:
    li $v0, 4
    la $a0, cad0
    syscall
	#Push, reservo espacio para un marco de pila.
	addi $sp,-20
	jal funcion1
	
salida:
	li $v0,10
	syscall