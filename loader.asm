    org 0100h
    mov ax, 0b800h
    mov gs, ax
    mov ah, 0fh
    mov al, 'L'
    mov [gs:((80*0 + 39) * 2)], ax
    times 1*512-($-$$) db 0
    mov ax, 0b800h
    mov gs, ax
    mov ah, 0fh
    mov al, 'O'
    mov [gs:((80*1 + 39) * 2)], ax 
    times 2*512-($-$$) db 0
    mov ax, 0b800h
    mov gs, ax
    mov ah, 0fh
    mov al,'A'
    mov [gs:((80*2 + 39) * 2)], ax
    times 3*512-($-$$) db 0
    mov ax, 0b800h
    mov gs, ax
    mov ah, 0fh
    mov al, 'D'
    mov [gs:((80*3 + 39) * 2)], ax 
    times 4*512-($-$$) db 0 
