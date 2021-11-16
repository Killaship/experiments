org 0x2000	
bits 16                         ; We're working at 16-bit mode here

start:
	cli                     ; Disable the interrupts
	mov si, msg             ; SI now points to our message
	mov ah, 0x0E            ; Indicate BIOS we're going to print chars
.loop	lodsb                   ; Loads SI into AL and increments SI [next char]
	or al, al               ; Checks if the end of the string
	jz halt                 ; Jump to halt if the end
	int 0x10                ; Otherwise, call interrupt for printing the char
	jmp .loop               ; Next iteration of the loop

halt:	hlt                     ; CPU command to halt the execution
msg:	db "Hello, World!", 0   ; Our actual message to print


