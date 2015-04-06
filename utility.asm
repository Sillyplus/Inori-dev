[bits 16]

global get_kb_char, write_str, wirte_char, set_char, get_char
global sleep, read_disk, get_cursor, move_cursor, clear_scn

_start:
    

;==========================================================
; get_kb_char:
; get the keyboard character
; return: al -> ASCII character of the key pressed
;==========================================================
get_kb_char:
    mov ah, 10h
    int 16h
    ret


;==========================================================
; get_char:
; get the character at the current cursor position
; return: al -> the character
;==========================================================
get_char:
    mov bh, 0h
    mov ah, 08h
    int 10h
    ret


;==========================================================
; set_char:
; set a char at the given position
; paramaters:
;   0: char to set 
;   1: row and column of the position
;==========================================================
set_char:
    enter 0, 0
    push bx

    mov bh, 0
    mov dx, [bp+6]
    mov ah, 02h
    int 10h

    mov al, [bp+4]
    mov bx, 0fh
    mov cx, 1
    mov ah, 09h
    int 10h

    pop bx
    leave
    ret


;==========================================================
; write_str:
; paramaters: 
;   0: offset of the string to write (!!!ds)
;   1: length of the string 
;   2: row and column of the position 
;==========================================================
write_str:
    enter 0, 0
    push bx
    mov dx, [bp+8]
    mov cx, [bp+4]

    push bp
    mov bp, [bp+4]

    mov ax, ds
    mov es, ax
    mov ah, 13h
    mov al, 1h
    mov bx, 05h
    int 10h
    pop bp

    pop bx
    leave
    ret


;==========================================================
; wirte_char:
; wirte a char at the current position with teletype model
; paramaters:
;   0: char to write 
;==========================================================
wirte_char:
    enter 0, 0
    push bx
    mov al, [bp+4]
    mov bx, 0
    mov ah, e0h
    push bp 
    int 10h
    pop bp
    pop bx 
    leave 
    ret


;==========================================================
; sleep:
; sleep for some time 
; paramaters:
;   0: interval to sleep in 65536 microseconds
;==========================================================
sleep:
    enter 0, 0
    mov dx, 0
    mov cx, [bp+4]
    mov ah, 86h
    int 15h
    leave
    ret


;==========================================================
; get_cursor:
; get the cursor position
; return: ax -> the cursor position
;==========================================================
get_cursor:
    mov bh, 0h
    mov ah, 3h
    int 10h
    mov ax, ax
    ret


;==========================================================
; move_cursor:
; move the cursor to specified position
;   0: the position to be moved to
;==========================================================
move_cursor:
    enter 0, 0
    mov dx, [bp, 4]
    mov bh, 0h
    mov ah, 2h
    int 10h
    leave 
    ret


;==========================================================
; clear_scn 
; clear screen
;==========================================================
clear_scn:
    mov ax, 03h
    int 10h
    ret

;==========================================================
; read_disk:
; read some sectors into memory
; paramaters:
;   0: destination (ds should be set to the correct segment)
;   1: number of sectors to read (1-255)
;   2: staring LBA (couldn't access cylinder > 255)
;   3: drive number (0-255, bit 7 set for hard disk)
;==========================================================
read_disk:
    enter 0, 0
    push bx
    push si
    push di 

    mov ah, 08h
    mov dl, [bp+10]
    int 13h 

    mov ah, ds
    mov es, ax
    
    mov ah, 0h
    mov al, cl 
    mul dh

    mov dx, ax
    mov ax, [bp+8]
    div bl
    mov bl, al      ; bl store the cylinder number

    mov ax, [bp+8]
    div cl 
    mov ah, 0h 
    div dh
    mov bh, ah      ; bh store the head number

    mov ax, [bp+8]
    div cl 
    inc ah          ; ah store the sector number

    mov al, [bp+6]
    mov ch, bl 
    mov cl, ah 
    mov dh, bh
    mov dl, [bp+10]
    mov bx, [bp+4]
    mov ah, 02h
    int 13h

    pop di 
    pop si 
    pop bx 
    leave 
    ret 


