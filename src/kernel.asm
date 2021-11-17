ORG 0x0000

start:
    mov ax, 0x2000             ; Mike OS'es bootloader loads us at 0x2000:0x0000
    mov ds, ax                 ; Set DS = ES = 0x2000
    mov es, ax

    ; Stack just below 0x2000:0x0000 starting at 0x1000:0x0000.
    ; First push will set SS:SP to 0x1000:0xfffe because SP will wrap.
    mov ax, 0x1000
    mov ss, ax
    xor sp, sp

    cld                        ; Clear Direction Flag (DF=0 is forward string movement)

    mov si, testCodeStr
    call print_string

    cli
.end_loop:
    hlt
    jmp .end_loop

testCodeStr: db 0x0d, 0x0a, "KERNEL.BIN loaded and running...", 0

; Function: print_string
;           Display a string to the console on display page 0
;
; Inputs:   SI = Offset of address to print
; Clobbers: AX, BX, SI

print_string:
    mov ah, 0x0e                ; BIOS tty Print
    xor bx, bx                  ; Set display page to 0 (BL)
    jmp .getch
.repeat:
    int 0x10                    ; print character
.getch:
    lodsb                       ; Get character from string
    test al,al                  ; Have we reached end of string?
    jnz .repeat                 ;     if not process next character
.end:
    ret
