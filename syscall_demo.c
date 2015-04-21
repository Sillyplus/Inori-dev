/*******************************************************************************
	> File Name: syscall_demo.c
	> Author: sillyplus 
	> Mail: oi_boy@sina.cn 
	> Created Time: Tue Apr 21 20:25:27 2015
*******************************************************************************/

#include "user_program.h"
#include "syscall.h"

int main() {
    _sys_ouch();
    char *str1 = "HELLOWORLD!"; 
    _sys_up2low(str1, __builtin_strlen(str1), 0x0d23);
    _sys_exit();
    return 0;
}
