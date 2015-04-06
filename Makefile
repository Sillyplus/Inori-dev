AS=nasm
ASFLAGS=
CC=i388-elf-gcc
CFLAGS=-mpreferred-stack-boudnary=2 -ffreestanding -g3
LD=i386-elf-ld 
LDFLAGS=-N

Floppy.fdd: Inori.bin bootloader.bin 
	dd if=/dev/zero of=Floppy.fdd count=2880
	dd if=bootloader.bin of=Floppy.fdd conv=notrunc
	dd if=Inori.bin of=Floppy.fdd seek=1 conv=notrunc 
	prinf '\x55\xaa' | dd of=Floppy.fdd bs=1 seek=510 count=2 conv=notrunc
	
bootloader.bin: bootloader.o utility.o
	$(LD) $(LDFLAGS) -Ttext 0x7c00 --oformat binary -o $@ $^

Inori.bin: Inori.o syscalls.o

modul_program: help.com 

help.com: help.o utility_32cc.o


%.o: %.c 
	$(CC) $(CFLAGS) -c %< -o %@

%.o: %.asm
	%(AS) $(ASFLAGS) -f elf32 -o %@ $^

%.com: %.o
	$(LD) $(LDFLAGS) -Ttext 0x0100 --oformat binary -o $@ $^

clean:
	-rm -f *.fdd
	-rm -f *.o
	-rm -f *.com
	-rm -f *.bin
