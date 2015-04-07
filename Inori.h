/*******************************************************************************
	> File Name: Inori.h
	> Author: sillyplus
	> Mail: oi_boy@sina.cn
	> Created Time: Tue Apr  7 09:08:20 2015
 ******************************************************************************/

#ifndef _INORI_H_
#define _INORI_H_

__asm__(".code16gcc\n");
__asm__("mov $0, %eax\n");
__asm__("mov %ax, %ds\n");
__asm__("mov %ax, %es\n");
__asm__("jmpl $0, $main\n");

#define CMD_BUF_LEN 64

struct FILE_TABLE_ENTRY {
    const char filename[14], loc, size;
} __attribute__ ((packed));

#endif
