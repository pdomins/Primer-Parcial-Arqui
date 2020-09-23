GLOBAL f_read
GLOBAL f_write
GLOBAL exit
section .text
;-----------------------------------------------------------
;readFromShell - lee desde terminal hasta recibir un '\n'
; LEE STRINGS DESDE TERMINAL
;extern int f_read(char * buffer, int size);
;-----------------------------------------------------------
f_read: 
    ENTER 0,0
    
    push ebx
    push ecx
    push edx 
	push esi
	push edi
	
    push length1
    push string1
	call f_write
    add esp,8

	mov ebx, STDIN          ; fd -> entrada por terminal
    mov ecx, [ebp+8]        ; lugar en donde guarda lo que lee
    mov edi, [ebp+12]       ; longitud de lectura maxima
	mov esi, 0				; bytes que llega a leer
	
continue:
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
	jmp continue
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

;-----------------------------------------------------------
; write - escribir a un file descriptor
; extern int f_write(char * buffer, int size);
;-----------------------------------------------------------
; Argumentos:
;   ebx: file descriptor
;   ecx: buffer donde se va a leer
;   edx: tamaño del buffer
;-----------------------------------------------------------
f_write:

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

;-----------------------------------------------------------
; exit
; Argumentos
;   ebx: int error_code
;-----------------------------------------------------------
exit:
    mov eax, SYS_EXIT
	mov ebx, [esp+4]
	int 80h
;-----------------------------------------------------------


section .data                                   ; Data segment
    
    SYS_READ equ 3
    SYS_WRITE equ 4
    SYS_EXIT equ 1

    STDIN equ 0
    STDOUT equ 1
    string1 db "Please enter a number: ", 0     ; Ask the user to enter a number
    length1 equ $-string1                       ; The length of the message