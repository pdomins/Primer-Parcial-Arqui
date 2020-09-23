GLOBAL readFromShell
GLOBAL writeToShell
GLOBAL clear_buffer
section .text
;-----------------------------------------------------------
;readFromShell - lee desde terminal hasta recibir un '\n'
; LEE STRINGS DESDE TERMINAL
;extern int readFromShell(char * buffer, int size);
;-----------------------------------------------------------
readFromShell: 
    push ebp
    mov ebp, esp		    ; armado stackframe

    mov eax, SYS_READ	    ; syscall read
    mov ebx, STDIN          ; fd
	mov ecx, [ebp+8]        ; buffer
	mov edx, [ebp+12]       ; length
    int 80h

    mov esp, ebp		    ; desarmado stackframe
    pop ebp
    ret
;-----------------------------------------------------------

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

;-----------------------------------------------------------
; print - imprimir una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;-----------------------------------------------------------
print:
	pushad		            ; hago backup de los registros

	mov ecx, ebx	        ; la cadena esta en ebx
	mov edx, eax	        ; en eax viene el largo de la cadena

	mov ebx, STDOUT		    ; FileDescriptor
	mov eax, SYS_WRITE		; ID del Syscall WRITE
	int 80h
	
	popad 		            ; restauro los registros
	ret	
;-----------------------------------------------------------


;-----------------------------------------------------------
; clear_buffer - borrar buffer de stdin
; extern void clear_buffer();
;-----------------------------------------------------------
; Argumentos:
;   No recibe
;-----------------------------------------------------------
clear_buffer:
    mov eax, SYS_WRITE
    mov ebx, STDIN
    mov ecx, placeholder
    mov edx, 1 ;Tamaño de placeholder
    int 80h
    cmp eax, 0
    jl end
    jmp clear_buffer

end:
    ret


section .data                                   ; Data segment
    SYS_READ equ 3
    SYS_WRITE equ 4
    STDIN equ 0
    STDOUT equ 1
    string1 db "Please enter a 15 character string: ", 0     ; Ask the user to enter a number
    length1 equ $-string1                       ; The length of the message

section .bss
    placeholder resb 1