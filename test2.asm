org 8000h
    mov ax, cs
    mov ds, ax
    mov bp, msg
    mov ax, ds
    mov es, ax
    mov cx, msgl
    mov ax, 1301h
    mov bx, 0007h 
    mov dx, 0200h
    int 10h
    
    retf

msg: db 'hello girl'
msgl equ ($-msg)

    times 512-($-$$) db 0
