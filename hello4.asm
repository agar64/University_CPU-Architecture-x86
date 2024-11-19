		org 0x7c00
		bits 16

		mov ax, 0x00
		mov ds, ax
		cli
		mov si, msg
		call prints
		mov si, ola
		call prints
		call prints
		call prints
		hlt

prints:
		push si
		push ax
		mov ah, 0x0e
.loop:
		lodsb
		or al, al
		jz retorno
		int 0x10
		jmp .loop
retorno:
		pop ax
		pop si
		ret

msg: db "Hello world!", 13, 10, 0
ola: db "Ol", 160, " mundo!", 13, 10
		times 510 - ($-$$) db 0
		dw 0xaa55
