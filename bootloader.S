.code16                          # Set 16-bit code

.global _start                   # Default entry point

_start:                          # Beginning of the program

	call  set_color          # Call set_color function

	movb  $0x0, %dh          # Defining row
	call  set_cursor         # Call set_cursor function

	mov   $msg1, %di         # Moving the message label address to di register
	call  print_msg          # Call print_msg function

	movb  $0x1, %dh          # Defining row
	call  set_cursor         # Call set_cursor function

	mov   $msg2, %di         # Moving the message label address to di register
	call  print_msg          # Call print_msg function

	movw  $0x0f, %cx         # Interval in microseconds
	call  delay              # Call delay function

	call  shutdown           # Call shutdown function

halt:                            # If shutdown function dosen't work the program will be 'blocked' here
	hlt                      # Halt
	jmp   halt               # Safeguard

print_msg:
	movw  $0x0, %bx          # Iteration index
loop:
	movb  (%bx, %di, 1), %al # Move char at index 'bx' to 'al' register
	cmp   $0x0, %al          # Compare if 'al' register value is 0x0
	je    end                # Jump to end
	call  print_char         # Call print_char function
	
	movw  $0x03, %cx         # Interval in microseconds
	call  delay              # Call delay function
	
	add   $0x1, %bx          # Increase index
	jmp   loop
end:
	ret

print_char:
	movb  $0xe, %ah          # Teletype output mode
	int   $0x10              # Interrupt 10
	ret

set_color:
	movb  $0x6, %ah
	movw  $0x184F, %dx       # Select the whole screen
	movb  $0x1e, %bh         # Select the background and text color
	int   $0x10              # Interrupt 10
	ret

set_cursor:
	movb  $0x2, %ah          # Set cursor position mode
	movb  $0x0, %bh          # Page number
	movb  $0x0, %dl          # Column
	int   $0x10              # Interrupt 10
	ret

delay:
	movb  $0x86, %ah         # Wait mode
	int   $0x15              # Interrupt 15
	ret

shutdown:
	movw  $0x5307, %ax       # Advanced Power Management v1.0+ - SET POWER STATE
	movw  $0x0001, %bx       # Device ID
	movw  $0x0003, %cx       # System state ID
	int   $0x15              # Interrupt 15
	ret

msg1:
.string    "Ola mundo!"  # String

msg2:
.string    "O computador ira desligar"  # String

.fill 510 - (. - _start), 1, 0   # Fill the rest of the file with zeros
.word 0xaa55                     # Adding boot signature at the end of the file
