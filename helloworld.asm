		org 0x7c00 ;endereço de origem do programa
		bits 16    ;programa será de 16bits
	
		mov ax, 0
		mov ds, ax
		cli
	
		mov si, msg       ;registrador de vídeo
	
		mov ah, 0x0e      ;ah = 0x0e       (escreva na tela)
loop:	lodsb             ;al = mem[si], si++
		cmp al, 0         ;checa se al = 0
		je fim           ;jump se igual
		int 0x10          ;chama interrupção de vídeo
		jmp loop
		
fim:	hlt
	
msg: 	db "hello world!", 0

		times 510 - ($ - $$) db 0
		db 0x55
		db 0xaa