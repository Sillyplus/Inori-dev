/*******************************************************************************
	> File Name: user_program.h
	> Author: sillyplus
	> Mail: oi_boy@sina.cn
	> Created Time: Tue Apr  7 09:06:06 2015
*******************************************************************************/

#ifndef _USER_PROGRAM_H_
#define _USER_PROGRAM_H_

__asm__(".code16gcc\n");
__asm__("call main\n");
__asm__("lret\n");

#endif
