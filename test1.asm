org 7e00h
    mov ax, cs
    mov ds, ax
    mov bp, msg
    mov ax, ds
    mov es, ax
    mov cx, msgl
    mov ax, 1301h
    mov bx, 0007h 
    mov dx, 0100h
    int 10h
    
    jmp 7c00h

msg: db 'hello world'
msgl equ ($-msg)

    times 512-($-$$) db 0
