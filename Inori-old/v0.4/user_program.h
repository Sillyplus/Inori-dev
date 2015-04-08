/*******************************************************************************
	> File Name: user_program.h
	> Author: sillyplus
	> Mail: oi_boy@sina.cn
	> Created Time: Tue Apr  7 09:06:06 2015
 ******************************************************************************/

#ifndef _USER_PROGRAM_H
#define _USER_PROGRAM_H

__asm__(".code16gcc\n");
__asm__("pushw %ds;");
__asm__("pushw %es;");
__asm__("mov %cs, %ax\n");
__asm__("mov %ax, %ds\n");
__asm__("mov %ax, %es\n");
__asm__("call main\n");
__asm__("popw %es;");
__asm__("popw %ds;");
__asm__("lret\n");

#endif
