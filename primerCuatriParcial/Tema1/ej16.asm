section .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numberToString
EXTERN toMayus

;Investigar la manera de llamar al syscall read. Realizar un programa que reciba por entrada estándar (file descriptor 0) un string, lo convierta a mayúscula y lo imprima por salida estándar (file descriptor 1).

_start:
	mov ebx, string1
	call print
	mov eax, 3 ;syscall read
	mov ebx, 2
	mov ecx, placeholder
	mov edx, 25
	int 0x80

	mov ebx, ecx
	call toMayus

	mov ebx, placeholder
	call print

	call exit

section .bss
	placeholder resb 128

section .data                           ;Data segment
   string1 db 'Please enter a word: ' ;Ask the user to enter a word
   length1 equ $-string1             ;The length of the message