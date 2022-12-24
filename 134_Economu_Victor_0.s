// Cerintele 1 si 2;
.data
	nr: .space 4
	n: .space 4
	Mi: .space 400
	m1: .space 40000
	x: .space 4
	
	m2: .space 40000
	mres: .space 40000
	k: .space 4
	i: .space 4
	j: .space 4
	
	fscan: .asciz "%d"
	fpr: .asciz "%d "
	fen: .asciz "\n"
	ftest: .asciz "%d\n"
.text
.globl main
main:
// Citim numarul cerintei:
	pushl $nr
	pushl $fscan
	call scanf
	addl $8, %esp

// Citim nr. de noduri:
	pushl $n
	pushl $fscan
	call scanf
	addl $8, %esp
	
// Citim nr. de legaturi pt. fiecare nod:
	xor %ecx, %ecx
for_Mi:
	cmp n, %ecx
	je exit_for_Mi	
	
	
	
	incl %ecx
	jmp for_Mi

exit_for_Mi:
	
	
etexit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80


/*	
	pushl nr
	pushl $ftest
	call printf
	addl $8, %esp
	
	pushl $0
	call fflush
	addl $4, %esp
*/
