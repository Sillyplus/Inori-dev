AS=nasm
ASFLAG=-f bin

Inori.fdd: test1.com test2.com test3.com
	$(AS) $(ASFLAG) -o $@ Inori.asm
	dd bs=512 if=test1.com of=Inori.fdd seek=1
	dd bs=512 if=test2.com of=Inori.fdd seek=2
	dd bs=512 if=test3.com of=Inori.fdd seek=3

test1.com: test1.asm
	$(AS) -f bin -o $@ $< 

test2.com: test2.asm
	$(AS) -f bin -o $@ $<

test3.com: test3.asm
	$(AS) -f bin -o $@ $<

clean:
	-rm *.com
	-rm *.fdd
