.code16                	       # Set 16-bit code

.global _start	       	       # Default entry point

	_start:		       # Beginning of the program

	call set_color	       # Call set_color function
	
	call set_cursor	       # Call set_cursor function
	 
	movw  $0x0, %bx	       # Iteration index
	loop:
	movb  msg(%bx), %al      # Move char at index 'bx' to 'al' register 
	cmp   $0x0, %al	       # Compare if 'al' register value is 0x0
	je    halt               # Jump to halt
	call  print_char	       # Call print_char function
	call delay
	add   $0x1, %bx	       # Increase index
	jmp   loop	       

	halt:
	hlt		       # Halt
	jmp   halt	       # Safeguard

	msg:
	.string    "Ola mundo!"  # String
	
	print_char:
	movb  $0xe, %ah	       # Teletype output mode
	int   $0x10	       # Interrupt 10 
	ret
	
	set_color:
	movb $0x6, %ah	        
	movw $0x184F, %dx        # Select the whole screen	
	movb $0x1e, %bh          # Select the background and text color 
	int $0x10	       # Interrupt 10
	ret
	
	set_cursor:
	movb $0x2, %ah           # Set cursor position mode
	movb $0x0, %bh 	       # Page number
	movb $0x0, %dh           # Row
	movb $0x0, %dl           # Column
	int $0x10                # Interrupt 10
	ret
	
	delay:
	movb $0x86, %ah
	movw $0x0f, %cx
	movw $0x4240, %dx
	int $0x15
	ret
	
	.fill 510 - (. - _start), 1, 0   # Fill the rest of the file with zeros
	.word 0xaa55	               # Adding boot signature at the end of the file


