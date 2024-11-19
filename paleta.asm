	org 0x7c00
	bits 16
	
	mov ax, 0
	mov ds, ax
	cli
	
	mov al, 0
	mov dx, 0x03C8
	out dx, al
	
	mov dx, 0x03C9
	
	mov al, 63
	out dx, al
	
	mov al, 63
	out dx, al
	
	mov al, 0
	out dx, al
	
	mov al, 7
	mov dx, 0x03C8
	out dx, al
	
	mov dx, 0x3c9
	
	mov al, 0
	out dx, al
	
	mov al, 63
	out dx, al
	
	mov al, 0
	out dx, al
	
	hlt		
	
	times 510 - ($-$$) db 0
	dw 0xaa55
