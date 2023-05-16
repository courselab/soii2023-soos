
int __attribute__((fastcall, naked)) low_level_print(const char* string){
	__asm__(
"	call  set_cursor        \n"
"	mov   %cx, %di          \n"
"	call  print_msg         \n"
"end:                           \n"
"       mov   %bx, %ax          \n"
"	ret                     \n"
"print_msg:                     \n"
"	movw  $0x0, %bx         \n"
"loop:                          \n"
"	movb  (%bx, %di, 1), %al\n"
"	cmp   $0x0, %al         \n"
"	je    end               \n"
"	call  print_char        \n"
"	movw  $0x03, %cx        \n"
"	call  delay             \n"
"	add   $0x1, %bx         \n"
"	jmp   loop              \n"
"	ret                     \n"
"print_char:                    \n"
"	movb  $0xe, %ah         \n"
"	int   $0x10             \n"
"	ret                     \n"
"set_cursor:                    \n"
"	movb  $0x12, %dh         \n"
"	movb  $0x2, %ah         \n"
"	movb  $0x0, %bh         \n"
"	movb  $0x0, %dl         \n"
"	int   $0x10             \n"
"	ret                     \n"
"delay:                         \n"
"	movb  $0x86, %ah        \n"
"	int   $0x15             \n"
"	ret                     \n"
	   );
}
