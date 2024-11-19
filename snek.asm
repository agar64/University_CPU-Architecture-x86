	org 0x7c00 
	bits 16
	
	mov ax, 0
	mov ds, ax
	cli
	
	mov ah, 0x00
	mov al, 0x13   ;VGA = 320x200 e 256 cores
	int 0x10
	
	mov ax, 0xA000
	mov es, ax
	
	mov cx, 32160
loop:	add cx, [snek] 
	call chkrig
	mov di, cx
	mov [es:di], byte(15)
	call keyboard
	call waity
	jne loop
	
keyboard:
	push ax
	mov ah, 01h
	int 0x16
	jz endkey
	mov ah, 00h
	int 0x16
	
	cmp al, 'd'
	je right
	
	cmp al, 'a'
	je left
	
	cmp al, 's'
	je down
	
	cmp al, 'w'
	je up
	
	jmp endkey
		
right:
	add cx, 0
	mov ax, 1
	mov [snek], ax
	jmp endkey
left:
	sub cx, 0
	mov ax, -1
	mov [snek], ax
	jmp endkey
down:
	add cx, 0
	mov ax, 320
	mov [snek], ax
	jmp endkey
up:
	sub cx, 0
	mov ax, -320
	mov [snek], ax
	jmp endkey
	
endkey:
	add cx, 0
	pop ax
	ret

	;hlt
	
waity:
	push ax
	push cx
	push dx

	mov dx, 0
	mov cx, 5
	mov al, 0
	mov ah, 86h
	int 0x15
	
	pop dx
	pop cx
	pop ax
	
	ret
	
chkrig:
	push ax
	push bx
	
	mov ax, cx     ;move cx para ax para ser divido
	mov bx, 320    ;mover 319 para dividir ax
	div bx
	cmp ah, 0      ;checa se o resto é 0
	jne notzero    ;se não for, retorna
	cmp cx, di     ;checa se cx > di
	jl notzero    ;se for, retorna
	sub cx, 320
	
	pop bx
	pop ax
	ret

notzero:
	pop bx
	pop ax
	ret

snek: dw 1

        times 510 - ($ - $$) db 0
        dw 0xaa55
