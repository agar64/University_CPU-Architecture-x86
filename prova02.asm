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
loop:	mov di, cx
	mov [es:di], byte(15)
	call keyboard
	jne loop
	
keyboard:
	push ax
	mov ah, 0
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
	add cx, 1
	jmp endkey
left:
	sub cx, 1
	jmp endkey
down:
	add cx, 320
	jmp endkey
up:
	sub cx, 320
	jmp endkey
	
endkey:
	pop ax
	ret

	hlt

        times 510 - ($ - $$) db 0
        dw 0xaa55
