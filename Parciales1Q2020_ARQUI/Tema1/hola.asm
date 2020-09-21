global readFromShell
global strlength
global writeToShell
global numToString


section .text

;extern int readFromShell(char * buffer, int size);
readFromShell: 
    ENTER 0,0
    
    push ebx
    push ecx
    push edx 
	push esi
	push edi
	
	mov ebx, string1
    mov eax, length1
	call print

	mov ebx, STDIN          ; fd -> entrada por terminal
    mov ecx, [ebp+8]        ; lugar en donde guarda lo que lee
    mov edi, [ebp+12]       ; longitud de lectura maxima
	mov esi, 0				; bytes que llega a leer
	
keep_going:
	mov edx, 1				; indico que quiero leer solo un byte
	mov eax, SYS_READ       ; syscall read
	int 80h

	cmp byte [ecx], '0'		; verificamos que sea un numero
	jl end
	cmp byte [ecx], '9'
	jg end
	
	inc esi					; solo incrementa si es un numero
	dec edi
	cmp edi,0
	je end
	inc ecx
	jmp keep_going
end:
	mov eax, esi
	pop edi
	pop esi	
    pop edx
    pop ecx
    pop ebx
    LEAVE
    ret

;-----------------------------------------------------------
; print - imprimir una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;-----------------------------------------------------------
print:
	pushad		            ; hago backup de los registros

	;call strlen
	mov ecx, ebx	        ; la cadena esta en ebx
	mov edx, eax	        ; en eax viene el largo de la cadena

	mov ebx, STDOUT		    ; FileDescriptor
	mov eax, SYS_WRITE		; ID del Syscall WRITE
	int 80h
	
	popad 		            ; restauro los registros
	ret	

;-----------------------------------------------------------
; write - escribir a un file descriptor
; extern int writeToShell(char * buffer, int size);
;-----------------------------------------------------------
; Argumentos:
;   ebx: file descriptor
;   ecx: buffer donde se va a leer
;   edx: tamaño del buffer
;-----------------------------------------------------------
writeToShell:
    ENTER 0,0
    push ebx
    push ecx
    push edx

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, [ebp+8]
    mov edx, [ebp+12]
    int 80h

    pop edx
    pop ecx
    pop ebx

    LEAVE
    ret

;-----------------------------------------------------------
; strlen - calcula la longitud de una cadena terminada con 0
;-----------------------------------------------------------
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;-----------------------------------------------------------
strlength:
    ENTER 0,0       ; armado del stack frame
	push ecx        ; preservo ecx	
	push ebx        ; preservo ebx
    mov ebx, [ebp + 8]
    
	pushf	        ; preservo los flags

	mov ecx, 0  	; inicializo el contador en 0
    
.loop:			    ; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	    ; lo comparo con 0 o NULL
	jz .fin 	    ; Si es cero, termino.
	inc ecx		    ; Incremento el contador
	inc ebx
	jmp .loop
.fin:				; etiqueta local a strlen
	mov eax, ecx	
	
	popf            ; restauro flags
	pop ebx         ; restauro ebx	
	pop ecx         ; restauro ecx
	LEAVE
    ret
    
;-----------------------------------------------------------
; numtostr - convierte un entero en un string guardandolo en
; el stack
;-----------------------------------------------------------
; Argumentos:
;	el numero entero de 32 bit que se recibe en el stack
; ESP +4 a convertir.
; Retorno:
;	los caracteres ASCII en el stack se devuelven
;-----------------------------------------------------------
numToString:
    mov ebp,esp             ; guardo el puntero del stack
	pushad
	MOV ECX,10
	MOV EDX,0               ; Pongo en cero la parte mas significativa
	Mov EAX, dword[ebp +4]  ; Cargo el numero a convertir
	MOV EBX, dword[ebp +8]
	ADD EBX,9               ; me posiciono al final del string para empezar a colocar
	mov byte [ebx], 0       ; los caracteres ASCII de derecha a izquierda comenzando con cero
	dec ebx                 ; binario
.sigo:	
    DIV ECX
	OR Dl, 0x30             ; convierto el resto  menor a 10 a ASCII
	mov byte [ebx], Dl
	DEC EBX                 ; si el cociente es mayor a 0 sigo dividiendo
	cmp al,10
	jz .termino
	mov edx,0
	jmp .sigo
.termino: 
    inc ebx
	call print
    POPAD
	mov esp,ebp
	ret

;-----------------------------------------------------------
; read - leer de un file descriptor
; extern int read(int file_descriptor, char * buffer, int size);
;-----------------------------------------------------------
; Argumentos:
;   ebx: file descriptor
;   ecx: buffer donde se va a copiar lo leido
;   edx: tamaño del buffer
;-----------------------------------------------------------
read:
    mov eax, SYS_READ
    mov ebx, [esp+4]
    mov ecx, [esp+8]
    mov edx, [esp+12]
    int 80h
    ret

section .data                                   ; 1Data segment
    SYS_READ equ 3
    SYS_WRITE equ 4
    STDIN equ 0
    STDOUT equ 1
    string1 db "Please enter a number: ", 0     ; Ask the user to enter a number
    length1 equ $-string1                       ; The length of the message