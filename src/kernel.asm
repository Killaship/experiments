bits 16

start:
;do this tomorrow


cls:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret


run_prgm:
	call cls
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
	xor si, si
	xor di, di
	call 32768
	call cls
