	mov ecx, 0
	mov ebx, filename
	mov eax, 5
	;eax filedescriptor

	mov ebx, eax
	mov edi,150 ;tamano del buffer
	mov edx, 1 ;indico que quiero leer un solo byte
	mov ecx, buffer
sigo:
	mov eax, 3 ;SYSCALL_READ
	int 80h

	cmp eax,0 ;cuando me da un valor negativo significa que termine de leer


	jl fin
	inc ecx ;para que la proxima lectura no me pise el dato que ya lei
	dec edi
	cmp edi,0
	jmp sigo