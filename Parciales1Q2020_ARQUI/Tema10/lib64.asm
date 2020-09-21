GLOBAL f_read
GLOBAL f_write
GLOBAL f_open
GLOBAL f_close
GLOBAL f_create_file

section .text

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

;-----------------------------------------------------------
; f_create_file - crea un archivo vacio
; extern int f_create_file(const char *file_name, unsigned int mode);
;-----------------------------------------------------------
; Argumentos:
;   rdi: file a crear
;   rsi: permisos del file
;-----------------------------------------------------------
f_create_file:
	enter 0,0
    mov rax, SYS_creat
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

    SYS_creat equ 85
    SYS_exit equ 60
    SYS_read equ 0
    SYS_write equ 1
    SYS_open equ 2
    SYS_close equ 3
