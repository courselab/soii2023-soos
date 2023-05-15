CFLAGS = -m16 -O0 -I. -Wall -fno-pic -fcf-protection=none --freestanding -nostdlib

hw_utils.o hw_start.o: hw_utils.c hw_start.c
	gcc $(CFLAGS) -c $^

hw.bin: hw.c hw_start.o hw_utils.o hw_linker.ld
	gcc $(CFLAGS) -T hw_linker.ld -Wl,--orphan-handling=discard hw.c -o $@

all: hw.bin

run: hw.bin
	qemu-system-x86_64 hw.bin
clean:
	rm -f *.bin *.o
