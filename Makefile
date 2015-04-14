AS=nasm
ASFLAGS=
CC=i386-elf-gcc
CFLAGS=-mpreferred-stack-boundary=2 -ffreestanding -g3
LD=i386-elf-ld 
LDFLAGS=-N

all: Floppy.img program_list_0 help.com ls.com time.com date.com reboot.com my_int_demo.com
	dd if=program_list_0 of=Floppy.img seek=64 conv=notrunc
	printf '\x40' | dd bs=1 of=Floppy.img seek=446 count=1 conv=notrunc
	dd if=help.com of=Floppy.img seek=65 conv=notrunc
	dd if=ls.com of=Floppy.img seek=68 conv=notrunc
	dd if=time.com of=Floppy.img seek=71 conv=notrunc
	dd if=date.com of=Floppy.img seek=74 conv=notrunc
	dd if=reboot.com of=Floppy.img seek=77 conv=notrunc
	dd if=my_int_demo.com of=Floppy.img seek=78 conv=notrunc

Floppy.img: Inori.bin bootloader.bin 
	dd if=/dev/zero of=Floppy.img count=2880
	dd if=bootloader.bin of=Floppy.img conv=notrunc
	dd if=Inori.bin of=Floppy.img seek=1 conv=notrunc 
	printf '\x55\xaa' | dd of=Floppy.img bs=1 seek=510 count=2 conv=notrunc
	
bootloader.bin: bootloader.o utils.o
	$(LD) $(LDFLAGS) -Ttext 0x7c00 --oformat binary -o $@ $^

Inori.bin: Inori.o utils_32cc.o int_handler.o
	$(LD) $(LDFLAGS) -Ttext 0x0500 --oformat binary -o $@ $^

user_program: help.com ls.com time.com date.com reboot.com my_int_demo.com

#dependencies
Inori.o: Inori.c Inori.h utils_32cc.h int_handler.h  
help.com: help.o utils_32cc.o
help.o: help.c utils_32cc.h user_program.h 
ls.com: ls.o utils_32cc.o
ls.o: ls.c utils_32cc.h user_program.h
time.com: time.o utils_32cc.o
time.o: time.c utils_32cc.h user_program.h
date.com: date.o utils_32cc.o 
date.o: date.c utils_32cc.h user_program.h 
my_int_demo.com: my_int_demo.o utils.o
my_int_demo.o: my_int_demo.asm 

%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.asm
	$(AS) $(ASFLAGS) -f elf32 -o $@ $<

%.com: %.o
	$(LD) $(LDFLAGS) -Ttext 0x0100 --oformat binary -o $@ $^

reboot.com: reboot.asm
	$(AS) $(ASFLAGS) -o $@ $^

#my_int_demo.com: my_int_demo.asm
#	$(AS) $(ASFLAGS) -o $@ $^

clean:
	-rm -f *.img
	-rm -f *.o
	-rm -f *.com
	-rm -f *.bin
