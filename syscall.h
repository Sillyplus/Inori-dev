/*******************************************************************************
	> File Name: syscall.h
	> Author: sillyplus 
	> Mail: oi_boy@sina.cn 
	> Created Time: Tue Apr 21 16:20:53 2015
*******************************************************************************/

#ifndef _SYSCALL_H_
#define _SYSCALL_H_

#include "stdint.h"
#include "Inori.h"

typedef int32_t time_t;
typedef size_t ssize_t;

// ssize_t sys_read(int, void *, size_t);
// ssize_t sys_write(int, const void *, size_t);
// time_t  sys_time(time_t *);
// void    sys_exit(int); 

void    sys_exit();
void    sys_ouch();
void  sys_up2low(char *, size_t, size_t);
void    sys_low2up();
void    sys_num2str();
void    sys_str2num();
void    sys_pstr();

extern int errno;
#define EBADF       9   // Bad file descriptor
#define EINTR       4   // Interupted function call
#define ENOSYS      38  // Function not implemented

static inline void _sys_exit() {
    __asm__(
        ".intel_syntax noprefix;"
        "int 0x80;"
        ".att_syntax;"
        : 
        : "a"(0)
        :
    );
}

static inline void _sys_ouch() {
    __asm__ volatile(
        ".intel_syntax noprefix;"
        "int 0x21;"
        ".att_syntax;"
        :
        : "a"(6)
        :
    );   
}

static inline void _sys_up2low(char *buf, size_t len, size_t pos) { 
    //ssize_t ret;
    __asm__ volatile(
        ".intel_syntax noprefix;"
        "int 0x21;"
        ".att_syntax;"
        : 
        : "a"(1), "b"(buf), "c"(len), "d"(pos)
        : 
    );
    //return ret;
}

void    sys_low2up();
void    sys_num2str();
void    sys_str2num();
void    sys_pstr();
// static inline ssize_t read(int fd, void *buf, size_t len) {
//     ssize_t ret;
//     __asm__(
//         ".intel_syntax noprefix;"
//         "int 0x80;"
//         ".att_syntax;"
//         : "=a"(ret)
//         : "a"(3), "b"(fd), "c"(buf), "d"(len)
//         : "memory"
//     );
//     return ret;
// }
// 
// static inline ssize_t write(int fd, void *buf, size_t len) {
//     ssize_t ret;
//     __asm__(
//         ".intel_syntax noprefix;"
//         "int 0x80;"
//         ".att_syntax;"
//         : "=a"(ret)
//         : "a"(4), "b"(fd), "c"(buf), "d"(len)
//         : "memory"
//     );
//     return ret;   
// }
// 
// static inline time_t time(time_t *t) {
//     time_t ret;
//     __asm__(
//         ".intel_syntax noprefix;"
//         "int 0x80;"
//         ".att_syntax;"
//         : "=a"(ret)
//         : "a"(13), "b"(t)
//         :
//     );
//     return ret;
// }
// 


#endif
