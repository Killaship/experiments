bits 16
org 0x0000

disk_buffer	equ	24576


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
	
	cmp dl, 0
	je no_change
	mov [bootdev], dl		; Save boot device number
	push es
	mov ah, 8			; Get drive parameters
	int 13h
	pop es
	and cx, 3Fh			; Maximum sector number
	mov [SecsPerTrack], cx		; Sector numbers start at 1
	movzx dx, dh			; Maximum head number
	add dx, 1			; Head numbers start at 0 - add 1 for total
	mov [Sides], dx
    


cls:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret

	cmp dl, 0
	je no_change
	mov [bootdev], dl		; Save boot device number
	push es
	mov ah, 8			; Get drive parameters
	int 13h
	pop es
	and cx, 3Fh			; Maximum sector number
	mov [SecsPerTrack], cx		; Sector numbers start at 1
	movzx dx, dh			; Maximum head number
	add dx, 1			; Head numbers start at 0 - add 1 for total
	mov [Sides], dx

no_change:
	mov ax, 1003h			; Set text output with certain attributes
	mov bx, 0			; to be bright, and not blinking
	int 10h

	
	; Let's see if there's a file called AUTORUN.BIN and execute
	; it if so, before going to the program launcher menu

	mov ax, autorun_bin_file_name
	call os_file_exists
			; Skip next three lines if AUTORUN.BIN doesn't exist

	mov cx, 32768			; Otherwise load the program into RAM...
	call os_load_file
	jmp execute_bin_program		; ...and move on to the executing part
	
	

execute_bin_program:
		; Clear screen before running

	mov ax, 0			; Clear all registers
	mov bx, 0
	mov cx, 0
	mov dx, 0
	mov si, 0
	mov di, 0

	call 32768			; Call the external program code,
					; loaded at second 32K of segment
					; (program must end with 'ret')

%include "disk.asm"
%include "string.asm"
autorun_bin_file_name	db 'HELLO.BIN', 0

