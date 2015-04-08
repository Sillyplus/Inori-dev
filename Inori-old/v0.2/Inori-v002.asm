org 7c00h                       ;将引导扇区加载到7c00h处

OffSetOfUserPref1 equ 7e00h     ;
OffSetOfUserPref2 equ 8000h     ;
OffSetOfUserPref3 equ 8b00h     ;

ShowInfo:
    mov ax, cs                  ;置其他段寄存器值与CS相同
    mov ds, ax                  ;数据段
    mov bp, Message             ;BP=当前串的偏移地址
    mov ax, ds                  ;ES:BP = 串地址
    mov es, ax                  ;置ES = DS
    mov cx, MessageLength       ;CX = 串长
    mov ax, 1301h               ;调用10h号中断的13h号功能的第1个功能
    mov bx, 0007h               ;在第0页显示,以及设置显示属性
    mov dh, 0                   ;显示的行位置
    mov dl, 0                   ;显示的列位置
    int 10h                     ;

get_command:                    ;调用16h号中断 捕获输入的字符
    mov ah, 0                   ;
    int 16h                     ;

showch:                         ;调用10h号中断，0号功能，显示存储在al中的字符
    mov ah, 0eh                 ;
    mov bl, 0                   ;
    int 10h                     ;
    
    cmp al, 31h
    je Load_1
 
    cmp al, 32h
    je Load_2

    cmp al, 0dh
    je Load_3

    jmp get_command             ;如果没有输入调用其他程序的指令，则继续读入

Load_1:                         ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处
    mov ax, cs                  ;段地址 存放数据的内存基地址
    mov es, ax                  ;设置段地址（不能直接mov es, 段地址）
    mov bx, OffSetOfUserPref1   ;偏移地址 存放数据的内存偏移地址
    mov ah, 2                   ;功能号
    mov al, 1                   ;扇区数
    mov dl, 0                   ;驱动器号 软盘为0 硬盘和U盘为80H
    mov dh, 0                   ;磁头号 起始编号为0
    mov ch, 0                   ;柱面号 起始编号为0 
    mov cl, 2                   ;起始扇区号 起始编号为1
    int 13h                     ;调用读磁盘BIOS的13h功能 
    jmp OffSetOfUserPref1

Load_2:                         ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处
    mov ax, cs                  ;段地址 存放数据的内存基地址
    mov es, ax                  ;设置段地址（不能直接mov es, 段地址）
    mov bx, OffSetOfUserPref2   ;偏移地址 存放数据的内存偏移地址
    mov ah, 2                   ;功能号
    mov al, 1                   ;扇区数
    mov dl, 0                   ;驱动器号 软盘为0 硬盘和U盘为80H
    mov dh, 0                   ;磁头号 起始编号为0
    mov ch, 0                   ;柱面号 起始编号为0 
    mov cl, 3                   ;起始扇区号 起始编号为1
    int 13h                     ;调用读磁盘BIOS的13h功能 
    jmp OffSetOfUserPref2
    
Load_3:                         ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处
    mov ax, cs                  ;段地址 存放数据的内存基地址
    mov es, ax                  ;设置段地址（不能直接mov es, 段地址）
    mov bx, OffSetOfUserPref3   ;偏移地址 存放数据的内存偏移地址
    mov ah, 2                   ;功能号
    mov al, 1                   ;扇区数
    mov dl, 0                   ;驱动器号 软盘为0 硬盘和U盘为80H
    mov dh, 0                   ;磁头号 起始编号为0
    mov ch, 0                   ;柱面号 起始编号为0 
    mov cl, 4                   ;起始扇区号 起始编号为1
    int 13h                     ;调用读磁盘BIOS的13h功能 
    jmp OffSetOfUserPref3

AfterRun:
    jmp $

Message: db 'Command >> '
MessageLength equ ($-Message)

    times 510-($-$$) db 0 
    db 0x55, 0xaa

