	org 0x7c00
	bits 16
	
	mov ax, 0
	mov ds, ax
	cli
	
	mov si, pergunta
	call prints
	
	mov di, nome
	call gets
	
	mov si, resposta
	call prints
	
	mov si, nome
	call prints
	
	mov si, pontua
	call prints
	
        jmp halt
        
gets:   push ax
        push di
loopg:  mov ah, 0
        int 0x16
        cmp al, 13
        je fimg
        mov [ds:di], al
        mov ah, 0x0e
        int 0x10
        inc di
        jmp loopg
fimg:   mov [ds:di], byte 0
	mov ah, 0x0e
	mov al, 13
	int 0x10
	mov al, 10
	int 0x10
        pop di
        pop ax
        ret
	
	
prints: push si
        push ax
        mov ah, 0x0e
loop:	lodsb
        cmp al, 0
        je fim
	int 0x10
	jmp loop
fim:    pop ax
        pop si
        ret

halt:	hlt

pergunta: db "Qual o seu nome? ", 0
resposta: db "Ola, ", 0
pontua:   db "!", 0
nome:     db 0
	
	times 510 - ($-$$) db 0
	dw 0xaa55

