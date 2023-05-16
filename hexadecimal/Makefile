hw.bin : hex2bin.py
	python3 $<

clean:
	rm -f *.bin

run: hw.bin
	qemu-system-x86_64 $<
