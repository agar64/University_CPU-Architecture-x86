	org 0x7c00
	bits 16
	
	mov ax, 0
	mov ds, ax
	cli
	
	int 0x13
	
	mov ah, 0x02   ;leia setores
	mov al, 1      ;1 setor deve ser lido
	mov cl, 2      ;a partir do setor 2
	mov ch, 0      ;cilindro 0
	mov dh, 0      ;cabeçote 0
	mov bx, 0x7e00 ;endereço de destino
	
	int 0x13
	
	mov si, 0x7e00
	call prints
	
	jmp fimp
        
geti:   push ax
	push cx
        push di
        mov [ds:di], word 0
loopgi: mov ah, 0
        int 0x16
        cmp al, 13
        je fimgi
        mov ah, 0x0e
        int 0x10
        mov ah, 0
        mov cx, ax
        sub cx, 48
        mov ax, [ds:di]
        imul ax, 10
        add ax, cx 
        mov [ds:di], ax
        jmp loopgi
fimgi:  mov ah, 0x0e
	mov al, 13
	int 0x10
	mov al, 10
	int 0x10
        pop di
        pop cx
        pop ax
        ret
        
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

fimp:	hlt

pergunta: db "Qual o seu nome? ", 0
resposta: db "Ola, ", 0
pontua:   db "!", 0
quebra:   db 13, 10, 0
nome:     db 0
valor:    dw 4
resto:    dw 0
	
	times 510 - ($-$$) db 0
	dw 0xaa55
