		org 0x7c00 ;endereço de origem do programa
		bits 16    ;programa será de 16bits
	
		mov ax, 0
		mov ds, ax
		cli
	
		mov si, msg       ;registrador de vídeo
		
		mov bx, 0xb800    ;guarda endereço de memória de vídeo no registrador bx
		mov es, bx        ;guarda o endereço no es (registrador de segmento extendido)
	
		mov cx, 0
		
loop:	lodsb             ;al = mem[si], si++
		cmp al, 0         ;checa se al = 0
		mov di, cx
		je fim            ;jump se igual
		mov [es:di], al
		add cx, 2
		jmp loop
		
fim:	hlt
	
msg: 	db "hello world!", 0

		times 510 - ($ - $$) db 0
		db 0x55
		db 0xaa