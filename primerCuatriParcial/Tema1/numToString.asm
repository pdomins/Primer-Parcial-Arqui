;-----------------------------------------------------------
;	Number to String
;-----------------------------------------------------------
;Argumentos 
;		ebx numero entero
;		ecx contiene el puntero a la direccion de memoria en la que quiero guardar el string
;-----------------------------------------------------------

numberToString:

	pushad		; hago backup de los registros
	mov edx, 0

	mov eax, ebx
	mov esi, 0x00	;creo un contador para los elementos que agregue al stack en 0

	cmp eax,0	; en el caso que el numero que me manden sea 0 
	jz addZero

addToStack:

	mov edi, 10
	mov edx, 0
	div edi ;divide lo que esta en el eax por 10
	push edx
	inc esi		;incremento el contador del stack

	cmp eax,0	;si no hay mas numeros que agregar al stack, vuelvo al end
	jz popStack

	jmp addToStack


addZero:
	add eax, 30h ;0x30
	mov [ecx], al	;muevo el byte menos significativo de eax a LA POSICION dentro de ecx
	jmp end

popStack:
	pop edx
	add edx, 0x30
	mov [ecx], dl
	dec esi ;decrementar el contador del stack

	cmp esi,0
	jz end

	inc ecx
	jmp popStack

end: 

	inc ecx
	mov byte [ecx], 0x00	;agrego el cero final del string

	popad 		; restauro los registros
	ret


;-----------------------------------------------------------