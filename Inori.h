/*******************************************************************************
	> File Name: Inori.h
	> Author: sillyplus
	> Mail: oi_boy@sina.cn
	> Created Time: Tue Apr  7 09:08:20 2015
 ******************************************************************************/

#ifndef _INORI_H_
#define _INORI_H_

#include "stdint.h"

#define CMD_BUF_LEN 64

struct FILE_TABLE_ENTRY {
    const int8_t filename[14], loc, size;
} __attribute__ ((packed));

typedef uint32_t size_t;

extern void * prev_esp;

#endif
