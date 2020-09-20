;extern int sys_read(unsigned int fd, char* buffer, int len);
;extern int sys_write(unsigned int fd, char* buffer, int len);
;extern int fd_open(char* file_name, int access_mode, int file_permissions);
;extern int fd_close(unsigned int fd);


GLOBAL print
GLOBAL exit
GLOBAL numtostr
GLOBAL f_read
GLOBAL f_write
GLOBAL f_open
GLOBAL f_close

section .text

;-----------------------------------------------------------
; print - imprime una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;-----------------------------------------------------------
print:
	pushad		; hago backup de los registros

	call strlen
	mov ecx, ebx	; la cadena esta en ebx
	mov edx, eax	; en eax viene el largo de la cadena

	mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, SYS_WRITE		; ID del Syscall WRITE
	int 80h

	popad 		; restauro los registros
	ret


;-----------------------------------------------------------
; exit - termina el programa
;-----------------------------------------------------------
; Argumentos:
;	ebx: valor de retorno al sistema operativo
;-----------------------------------------------------------
exit:
	mov eax, SYS_exit		; ID del Syscall EXIT
	int 80h			        ; Ejecucion de la llamada


;-----------------------------------------------------------
; strlen - calcula la longitud de una cadena terminada con 0
;-----------------------------------------------------------
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;-----------------------------------------------------------
strlen:
	push ecx ; preservo ecx
	push ebx ; preservo ebx
	pushf	; preservo los flags

	mov ecx, 0	; inicializo el contador en 0
.loop:			; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	; lo comparo con 0 o NULL
	jz .fin 	; Si es cero, termino.
	inc ecx		; Incremento el contador
	inc ebx
	jmp .loop
.fin:				; etiqueta local a strlen
	mov eax, ecx

	popf
	pop ebx ; restauro ebx
	pop ecx ; restauro ecx
	ret

	
;-----------------------------------------------------------
; numtostr - convierte un entero en un string guardandolo en
; el stack
;-----------------------------------------------------------
; Argumentos:
;	el numero entero de 32 bit que se recibe en el stack
; ESP +4 a convertir
; Retorno:
;	los caracteres ASCII en el stack se devuelven
;-----------------------------------------------------------
numtostr:
	mov ebp,esp ; guardo el puntero del stack
	pushad
	MOV ECX,10
	MOV EDX,0   ; Pongo en cero la parte mas significativa
	Mov EAX, dword[EBp +4]  ;Cargo el numero a convertir
	MOV EBX,dword[ebp +8]
	ADD EBX,9               ; me posiciono al final del string para empezar a colocar
	mov byte [ebx], 0       ; los caracteres ASCII de derecha a izquierda comenzando con cero
	dec ebx                 ; binario
.sigo:	DIV ECX
	OR Dl, 0x30  ; convierto el resto  menor a 10 a ASCII
	mov byte [ebx], Dl
	DEC EBX      ; si el cociente es mayor a 0 sigo dividiendo
	cmp al,0
	jz .termino
	mov edx,0
	jmp .sigo
.termino: inc ebx
	 call print
         POPAD
	 mov esp,ebp
	 ret


;-----------------------------------------------------------
; f_read - leer de un file descriptor
; extern int read(unsigned int file_descriptor, char * buffer, size_t size);
;-----------------------------------------------------------
; Argumentos:
;   rdi: file descriptor
;   rsi: buffer donde se va a copiar lo leido
;   rdx: tamaño del buffer
;-----------------------------------------------------------
f_read:
	enter 0,0
    mov rax, SYS_read
    syscall
	leave
    ret
;Preguntar buffer overflow


;-----------------------------------------------------------
; f_write - escribir a un file descriptor
; extern int write(unsigned int file_descriptor, char * buffer, size_t size);
;-----------------------------------------------------------
; Argumentos:
;   rdi: file descriptor
;   rsi: buffer donde se va a leer
;   rdx: tamaño del buffer
;-----------------------------------------------------------
f_write:
	enter 0,0
    mov rax, SYS_write
    syscall
	leave
    ret


;-----------------------------------------------------------
; f_open - abrir un archivo
; extern int open(const char * file_name, int access_mode (flags), unsigned short file_permissions);
;-----------------------------------------------------------
; Argumentos:
;   rdi: filename a abrir
;   rsi: access mode (0 read-only, 1 write-only, 2 read-write)
;   rdx: file permissions /Necesarios solo al crear un archivo
;-----------------------------------------------------------
f_open:
		enter 0,0
        mov rax, SYS_open
        syscall
		leave
        ret


;-----------------------------------------------------------
; f_close - cerrar un archivo
; extern int close(int file_descriptor);
;-----------------------------------------------------------
; Argumentos:
;   rdi: file descriptor a cerrar
;-----------------------------------------------------------
f_close:
	enter 0,0
    mov rax, SYS_close
    syscall
	leave
    ret
;-----------------------------------------------------------

section .data

    STDIN equ 0
    STDOUT equ 1
    STDERR equ 2

    LF equ 10
    NULL equ 0

    SYS_exit equ 60
    SYS_read equ 0
    SYS_write equ 1
    SYS_open equ 2
    SYS_close equ 3