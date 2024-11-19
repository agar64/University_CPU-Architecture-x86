	org 0x7c00
	bits 16
	
	mov ax, 0
	mov ds, ax
	cli
	
	int 0x13
	mov ah, 0x02
	mov al, 18
	mov cl, 2
	mov ch, 0
	mov dh, 0
	mov bx, 0x7e00
	int 0x13
	
	mov ah, 0
	mov al, 0x13  ;320 x 200 pixels, 1 byte por pixel => 256 cores (VGA)
	int 0x10
	
	call carregapaleta
	
	mov ax, 0xA000
	mov es, ax
	
	mov si, 0x8100
	mov di, 0
	
	mov bx, 0
	
leimg:	mov ah, [ds:si]
	mov [es:di], ah
	inc si
	inc di
	inc bx
	cmp bx, 81
	je novalinha
cont:	cmp di, 64000
	je fim
	jmp leimg
	
novalinha:
	mov bx, 0
	add di, 239
	jmp cont
		
fim:	hlt

carregapaleta:
	push si
	push ax
	
	mov si, 0x7e00

	
	mov ax, 0
	mov dx, 0x3c8
	out dx, ax
	
	mov dx, 0x3c9
	
proxcor:
	mov al, [ds:si]
	out dx, ax
	inc si
	
	mov al, [ds:si]
	out dx, ax
	inc si
	
	mov al, [ds:si]
	out dx, ax
	inc si
	
	cmp si, 0x8100
	jne proxcor
	
	pop ax
	pop si
	ret
	
	times 510-($-$$) db 0
	dw 0xaa55
