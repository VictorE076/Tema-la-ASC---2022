// Cerintele 1 si 2;
.data
.text
.globl main
main:
etexit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80
