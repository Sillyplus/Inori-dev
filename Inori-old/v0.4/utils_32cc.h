/*******************************************************************************
	> File Name: utils_32cc.h
	> Author: sillyplus
	> Mail: oi_boy@sina.cn
	> Created Time: Tue Apr  7 08:23:58 2015
 ******************************************************************************/
//
// #ifndef _UTILS_32CC_H
// #define _UTILS_32CC_H
//
// #include <stdint.h>
//
// char get_kb_char();
// char get_char();
// void set_char(char, uint16_t);
// void write_str(const char *, uint16_t, uint16_t);
// void write_char(char);
// void sleep(uint16_t);
// uint16_t get_cursor();
// void move_cursor(uint16_t);
// void clear_scn();
// void read_disk(void *, uint8_t, uint16_t, uint8_t);
//
// static inline void write_str_current(const char *p_str, uint16_t len) {
//     while (len--)
//         write_char(*p_str++);
// }
//
// static inline char * strchr_(char *p_str, char c) {
//     while (*p_str != c && *p_str != '\0')
//         ++p_str;
//     return p_str;
// }
//
// static inline void strncpy_(char *dest, const char *source, uint16_t len) {
//     __asm__ volatile(
//         ".intel_syntax noprefix;"
//         "cld;"
//         "rep movsb;"
//         ".att_syntax;"
//         : /* no output*/
//         : "c"(len), "D"(dest), "S"(source)
//         : "memory"
//     );
//     dest[len] = '\0';
// }
//
// inline char strncmp_(const char *a, const char *b, uint16_t len) {
//     __asm__ volatile(
//         ".intel_syntax noprefix;"
//         "cld;"
//         "rep cmpsb;"
//         ".att_syntax;"
//         : "=c"(len)
//         : "c"(len+1), "D"(a), "S"(b)
//         : "cc"
//     );
//     return len;
// }
//
// #endif

#include "stdint.h"

char get_kb_char();
void clear_scn();
void write_str(const char *, uint16_t, uint16_t);
void write_char(char);
void set_char(char, uint16_t);
void read_disk(void *, uint8_t, uint16_t, uint8_t);
void sleep(uint16_t);
void move_cursor(uint16_t);
unsigned short get_cursor();
char get_char();

inline void write_str_current(const char *p_str, uint16_t len) {
    while(len--)
        write_char(*p_str++);
}

inline char * strchr_(char *p_str, char c) {
    while(*p_str != c && *p_str != '\0')
        ++p_str;
    return p_str;
}

inline void strncpy_(char *dest, const char *source, uint16_t len) {
    __asm__ volatile(
        ".intel_syntax;"
        "cld;"
        "rep movsb;"
        ".att_syntax;"
        : /* no output */
        : "c"(len), "D"(dest), "S"(source)
        : "memory"
    );
    dest[len] = '\0';
}

inline char strncmp_(const char *a, const char *b, uint16_t len) {
    __asm__ volatile(
        ".intel_syntax;"
        "cld;"
        "rep cmpsb;"
        ".att_syntax;"
        : "=c"(len)
        : "c"(len+1), "D"(a), "S"(b)
        : "cc"
    );
    return len;
}
