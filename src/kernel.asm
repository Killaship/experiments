bits 16
org 0x0000


start:

	cli				; Clear interrupts
	mov ax, 0
	mov ss, ax			; Set stack segment and pointer
	mov sp, 0FFFFh
	sti				; Restore interrupts
	mov ax, 2000h			; Set all segments to match where kernel is loaded
	mov ds, ax			; After this, we don't need to bother with
	mov es, ax			; segments ever again, as MikeOS and its programs
	mov fs, ax			; live entirely in 64K
	mov gs, ax
    


cls:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret


run_prgm:
	call cls
	xor ax, ax
	xor bx, vx
	xor cx, cx
	xor dx, dx
	xor si, si
	xor di, di
	call 32768
	call cls
    jmp $
