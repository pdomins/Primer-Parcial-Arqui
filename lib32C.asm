

GLOBAL closef
GLOBAL read
GLOBAL write
GLOBAL openf
GLOBAL exit


STDIN equ 0
STDOUT equ 1

;en eax
SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
SYS_OPEN equ 5
SYS_CLOSE equ 6


section .text

;------------------------------------------------------------------------
;							EXIT
;				exit eax=0x01/ ebx= int error_code
;------------------------------------------------------------------------
exit:
    mov eax, SYS_EXIT
		mov ebx, 1
		int 80h

;------------------------------------------------------------------------

;------------------------------------------------------------------------
;							OPEN FILE
;open eax=0x05/ ebx=const char *filename/ ecx=int flags/ edx=umode_t mode
;------------------------------------------------------------------------
openf:

        push ebp
       	mov ebp, esp		    ; armado stackframe

       	mov eax, SYS_OPEN
        mov ebx, [ebp+8]        ; recibo por stack el archivo a abrir
		mov ecx, 0			    ; flags: read only mode = 0
        int 80h

        mov esp, ebp			; desarmado stackframe
        pop ebp
        ret
;------------------------------------------------------------------------

;------------------------------------------------------------------------
;							CLOSE FILE
;				close eax=0x06 ebx=unsigned int fd
;------------------------------------------------------------------------
closef:
       push ebp
       mov ebp, esp			; armado stackframe

       mov eax, SYS_CLOSE	; syscall close
       mov ebx, [ebp+8] 	; (file descriptor or fd -> nombre del archivo que voy a cerrar)
       int 80h

       mov esp, ebp			; desarmado stackframe
       pop ebp
       ret
;------------------------------------------------------------------------

;------------------------------------------------------------------------
;							  READ
;read eax=0x03/ ebx=unsigned int fd/ ecx=char *buf/ edx=size_t count
;------------------------------------------------------------------------
read:
       	push ebp
       	mov ebp, esp		    ; armado stackframe

       	mov eax, SYS_READ	    ; syscall read
       	mov ebx, [ebp+8]        ; fd
		mov ecx, [ebp+12]       ; buffer
		mov edx, [ebp+16]       ; length
	    int 80h

       	mov esp, ebp		    ; desarmado stackframe
       	pop ebp
       	ret
;------------------------------------------------------------------------

;------------------------------------------------------------------------
;								WRITE
;write eax=0x04/ ebx=unsigned int fd/ ecx=const char *buf/ edx=size_t count
;------------------------------------------------------------------------
write:
       	push ebp
       	mov ebp, esp		; armado stackframe

  		  mov eax, SYS_WRITE
  		  mov ebx, STDOUT   ; fd
  		  mov ecx, [ebp+8]  ; recibo por stack el puntero al lugar de memoria donde voy a escribir
  		  mov edx, [ebp+12] ; recibo el size
  		  int 80h
		
        mov esp, ebp		; desarmado stackframe
       	pop ebp
       	ret

;------------------------------------------------------------------------

