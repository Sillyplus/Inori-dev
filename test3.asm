org 8b00h

cleanup:
    mov ah, 6
    mov al, 0
    mov bh, 0fh
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 10h
    
    jmp 7c00h
   
    times 512-($-$$) db 0
