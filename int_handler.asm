[BITS 16]
%macro INT_HANDLER 1
[extern _%1]
[global %1]
%1:
    call dword _%1
    iret
%endmacro

INT_HANDLER clock_int
INT_HANDLER syscall 
; INT_HANDLER key_board_int

INT_HANDLER int33_demo
INT_HANDLER int34_demo
INT_HANDLER int35_demo
INT_HANDLER int36_demo



