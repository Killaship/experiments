bits 16
org 0x7C00

    
    ; Load stage 2 to memory.
    mov ah, 0x02
    mov al, 0x06 ; amount of sectors to load
    ; This may not be necessary as many BIOS setup is as an initial state.
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov bx, 0x1000
    int 0x13

    jmp 0x1000

    ; Magic bytes.    
    times ((0x200 - 2) - ($ - $$)) db 0x00
    dw 0xAA55

