/*******************************************************************************
	> File Name: Inori.c
	> Author: sillyplus
	> Mail: oi_boy@sina.cn
	> Created Time: Tue Apr  7 16:38:13 2015
 ******************************************************************************/

__asm__(".code16gcc\n");
__asm__("mov $0, %eax\n");
__asm__("mov %ax, %ds\n");
__asm__("mov %ax, %es\n");
__asm__("jmpl $0, $main\n");

#include "Inori.h"
#include "utils_32cc.h"

const char * const welcome_msg = "Welcome to Inori Operating System.\r\n"
"Copyright at sillyplus\r\n"
"Chen Yuanjie 13349014\r\n"
"Enter 'help' to see help\r\n";

const char * const prompt = "\r\n >> ";
const int8_t cmd_col = 4;
char cmd_buf[CMD_BUF_LEN];

int8_t wait_cmd();
int8_t load_program(const char *, uint16_t);
void run_program();

int main() {
    int8_t cmd_len;
    char cmd[32];
    char * current_comma_pos, * prev_comma_pos;
    clear_scn();
    write_str(welcome_msg, __builtin_strlen(welcome_msg), 0);

    while (1) {
        write_str_current(prompt, cmd_col + 2);
        cmd_len = wait_cmd();
        if (cmd_len) {
            prev_comma_pos = cmd_buf - 1;
            while (prev_comma_pos < cmd_buf + cmd_len) {
                current_comma_pos = strchr_(prev_comma_pos + 1, ',');
                strncpy_(cmd, prev_comma_pos + 1, current_comma_pos - prev_comma_pos - 1);
                if (load_program(cmd, current_comma_pos - prev_comma_pos - 1))
                    run_program();
                else {
                    write_str_current("Command not found: ", 19);
                    write_str_current(cmd, current_comma_pos - prev_comma_pos - 1);
                    write_str_current("\r\n", 2);
                }
                prev_comma_pos = current_comma_pos;
            }
        }
    }
}


int8_t wait_cmd() {
    char c, len = 0;
    uint16_t current_pos, i;
    while ('\r' != (c = get_kb_char())) {
        if (c == '\b') {
            current_pos = get_cursor();
            if((current_pos & 0xff) > cmd_col) {
                write_char(c);
                write_char(' ');
            }
            else
                continue;
        }
        write_char(c);
    }

    current_pos = get_cursor();
    for (i = (current_pos & 0xff00) + cmd_col; i < current_pos; i += 0x1) {
        move_cursor(i);
        cmd_buf[len++] = get_char();
    }
    cmd_buf[len] = '\0';

    write_char('\r');
    write_char('\n');

    return len;
}

int8_t load_program(const char * cmd, uint16_t len) {
    struct FILE_TABLE_ENTRY file_table[32];
    uint16_t p, i;
    for (p = 0x7dbe; p != 0x7dfe; p += 0x10) {
        read_disk((void *)file_table, 1, *(uint16_t *)p, 0);
        for (i = 0; i < 32; i++) {
            if (strncmp_(file_table[i].filename, cmd, len) == 0) {
                read_disk((void *)0x7e00, file_table[i].size, file_table[i].loc, 0);
                return 1;
            }
        }
    }
    return 0;
}

void run_program() {
    __asm__ volatile(
        ".intel_syntax;"
        "call 0x7d0:0x0100;"
        ".att_syntax;"
    );
}
