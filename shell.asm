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
    
;get_command:
;    mov ah, 0                   ;
;    int 16h                     ;
;
;showch:
;    mov ah, 0eh                 ;
;    mov bl, 0                   ;
;    int 10h                     ;
;    
;    cmp al, 0dh                 ;
;    mov al, 0ah                 ;
;    je showch                   ;
    
;    jmp get_command             ;

    jmp 7c00h
   
    times 512-($-$$) db 0
