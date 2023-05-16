extern void __END_STACK__;

void __attribute__((naked)) _start(){
	__asm__(
		"	mov 	$__END_STACK__,	%sp	\n"
		"	call 	main			\n"
		"shutdown:                              \n"
		"	movw    $0x5307, %ax            \n"
		"	movw    $0x0001, %bx            \n"
		"	movw    $0x0003, %cx            \n"
		"	int     $0x15                   \n"
		"halt:					\n"
		"	hlt				\n"
		"	jmp	halt			\n"
	       );
}
