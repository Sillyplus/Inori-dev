[BITS 16]
extern sleep

_start:
    int 0x33
    
    push 0x8
    call sleep
    add sp, 2

    int 0x34 

    push 0x8
    call sleep
    add sp, 2
    
    int 0x35

    push 0x8
    call sleep
    add sp, 2
    
    int 0x36
    
    push 0x8
    call sleep
    add sp, 2
   
    jmp $
