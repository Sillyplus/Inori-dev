; 本程序在文本方式显示器上从左边射出一个*号,以45度向右下运动，撞到边框后反射,如此类推.

Dn_Rt    equ 1                  ;D-Down,U-Up,R-right,L-Left
Up_Rt    equ 2                  ;
Up_Lt    equ 3                  ;
Dn_Lt    equ 4                  ;
delay    equ 50000				; 计时器延迟计数,用于控制画框的速度
ddelay   equ 580				; 计时器延迟计数,用于控制画框的速度

    org 100h					; 程序加载到7c00h

start:
    mov ax, cs
	mov es, ax					; ES = 0
	mov ds, ax					; DS = CS
	mov es, ax					; ES = CS
	mov	ax, 0xB800				; 文本窗口显存起始地址
	mov	gs, ax					; GS = B800h
loop1:
	dec word[count]				; 递减计数变量
	jnz loop1					; >0：跳转;
	mov word[count], delay
	dec word[dcount]			; 递减计数变量
    jnz loop1
	mov word[count], delay
	mov word[dcount], ddelay
    
    mov al, 1
    cmp al, byte[rdul]
	jz  DnRt
    mov al, 2
    cmp al, byte[rdul]
	jz  UpRt
    mov al, 3
    cmp al, byte[rdul]
	jz  UpLt
    mov al, 4
    cmp al, byte[rdul]
	jz  DnLt
    jmp $

DnRt:
	inc word[x]
	inc word[y]
	mov bx, word[x]
	mov ax, 25
	sub ax, bx
    jz  dr2ur
	mov bx, word[y]
	mov ax, 80
	sub ax, bx
    jz  dr2dl
	jmp show
dr2ur:
    mov word[x],    23
    mov byte[rdul], Up_Rt
    jmp show
dr2dl:
    mov word[y],    78
    mov byte[rdul], Dn_Lt
    jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx, word[y]
	mov ax, 80
	sub ax, bx
    jz  ur2ul
	mov bx, word[x]
	mov ax, -1
	sub ax, bx
    jz  ur2dr
	jmp show
ur2ul:
    mov word[y],    78
    mov byte[rdul], Up_Lt
    jmp show
ur2dr:
    mov word[x],    1
    mov byte[rdul], Dn_Rt
    jmp show


UpLt:
	dec word[x]
	dec word[y]
	mov bx, word[x]
	mov ax, -1
	sub ax, bx
    jz  ul2dl
	mov bx, word[y]
	mov ax, -1
	sub ax, bx
    jz  ul2ur
	jmp show

ul2dl:
    mov word[x],    1
    mov byte[rdul], Dn_Lt
    jmp show
ul2ur:
    mov word[y],    1
    mov byte[rdul], Up_Rt
    jmp show

DnLt:
	inc word[x]
	dec word[y]
	mov bx, word[y]
	mov ax, -1
	sub ax, bx
    jz  dl2dr
	mov bx, word[x]
	mov ax, 25
	sub ax, bx
    jz  dl2ul
	jmp show

dl2dr:
    mov word[y],    1
    mov byte[rdul], Dn_Rt
    jmp show

dl2ul:
    mov word[x],    23
    mov byte[rdul], Up_Lt
    jmp show

show:
    xor ax, ax                  ; 计算显存地址
    mov ax, word[x]             
	mov bx, 80
	mul bx
	add ax, word[y]
	mov bx, 2
	mul bx
	mov bp, ax
	mov ah, 0Fh		    		;  0000：黑底、1111：亮白字（默认值为07h）
	mov al, byte[char]			;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp], ax  		;  显示字符的ASCII码值

    ;inc byte[char]              ;  显示字母自增
    ;mov al, byte[char2]         ;  
    ;cmp al, byte[char]          ;  比较字母是否已超过Z
    ;je chage_char               ;  是的话调用函数，变回A
back:                           ;  修改后回跳到这里
    call show_info              ;  显示个人信息
	jmp loop1

end:
    jmp $                       ; 停止画框，无限循环

show_info:
    mov ax, cs
    mov es, ax
    mov ds, ax 

    mov bp, str1                ; 显示字符串1 
    mov dx, 0a20h               ; 设置显示位置
    call show_XX                ; 调用显示函数
    
    mov bp, str2                ; 功能同上
    mov dx, 0b20h
    call show_XX

    mov bp, str3                ; 同上
    mov dx, 0c20h
    call show_XX

    mov bp, str4                ; 同上
    mov dx, 0d20h
    call show_XX

    ret

show_XX:
    mov ah, 13h                 ; 功能号
    mov al, 0                   ; 设置光标会起始位置
    mov bl, 0ah                 ; 设置颜色属性
    mov bh, 0                   ; 设置在第0页显示
    mov cx, 15                  ; 字符串长度
    int 10h                     ; 调用10h号中断
    ret

chage_char:
    mov byte[char], 'A'
    jmp back 

datadef:
	count dw delay
	dcount dw ddelay
    rdul db Dn_Rt               ; 向右下运动
    x dw 7                      ; 起始位置(7, 0) 
	y dw 0                      ; 
	char db 'A'                 ; 起始字符
    char2 db 5bh                ; ASCII字符表'Z'后的字符编码
    str1 db " ------------- "   ; 个人信息字符串
    str2 db "|  13349014   |"
    str3 db "| ChenYuanjie |"
    str4 db " ------------- " 

    times 512-($-$$) db 0
