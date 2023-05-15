OUTPUT_FORMAT(binary)


SECTIONS{

	. = 0x7c00;
	.text :
	{
		*(.text)
		*(.rodata)
	}
	. = 0x7c00 + 510
	.signature :
	{
		BYTE(0x55)
		BYTE(0xAA)
	}
	__END_STACK__ = 0x8200;

}
STARTUP(hw_start.o);
INPUT(hw_utils.o)
