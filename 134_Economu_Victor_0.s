// Cerintele 1 si 2;
.data
	nr: .space 4
	n: .space 4
	Mi: .space 400
	m1: .space 40000
	x: .space 4
	ii: .space 4
	jj: .space 4
	
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

// Aceasta procedura stocheaza inmultirea matricelor patratice m1 si m2 in mres;
matrix_mult:
	pushl %ebp
	movl %esp, %ebp
	
		pushl %ebx
		pushl %esi
		pushl %edi
		
		
	////
		
		
		popl %edi
		popl %esi
		popl %ebx
	
	popl %ebp
	ret
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
	
		pushl %ecx
	pushl $x
	pushl $fscan
	call scanf
	addl $8, %esp
		popl %ecx
	
	lea Mi, %esi
	movl x, %eax
	movl %eax, (%esi, %ecx, 4)
	
	incl %ecx
	jmp for_Mi

exit_for_Mi:
// Citim acum vecinii tuturor nodurilor:
	xor %ecx, %ecx
	xor %edx, %edx
	movl $0, ii
	movl $0, jj
for_adi:
	movl ii, %ecx
	cmp n, %ecx
	je exit_for_adi
	
	movl $0, jj
	for_adj:
		movl jj, %ecx
		movl ii, %eax
		lea Mi, %esi
		movl (%esi, %eax, 4), %ebx
		cmp %ebx, %ecx
		je next_adi
		
		// Citim un vecin al indexului ii;
			pushl %eax
			pushl %ecx
		pushl $x
		pushl $fscan
		call scanf
		addl $8, %esp
			popl %ecx
			popl %eax
		
		// Aflam pozitia corespunzatoare in matricea de adiacenta;	
		xor %edx, %edx
		mull n
		addl x, %eax
		
		// Mutam valoarea 1 pe pozitia corespunzatoare;
		lea m1, %esi
		movl $1, (%esi, %eax, 4)
		
		incl jj
		jmp for_adj
		

next_adi:	
	incl ii
	jmp for_adi
	
exit_for_adi:
	movl nr, %ecx
	
// Verificam numarul cerintei;
	cmp $1, %ecx
	jne check_nr
	
CERINTA_1:
	
	xor %ecx, %ecx
	xor %edx, %edx
	movl $0, ii
	movl $0, jj
for_pr_adi:
	movl ii, %ecx
	cmp n, %ecx
	je etexit
	
	movl $0, jj
	for_pr_adj:
		movl jj, %ecx
		cmp n, %ecx
		je next_pr_adi
		
		// Aflam pozitia corespunzatoare in matricea de adiacenta;
		movl ii, %eax
		xor %edx, %edx
		mull n
		addl jj, %eax
		
		lea m1, %esi
		
		// Afisam valoarea elementului din matricea de adiacenta;
		pushl (%esi, %eax, 4)
		pushl $fpr
		call printf
		addl $8, %esp
		
		pushl $0
		call fflush
		addl $4, %esp
		
		
		incl jj
		jmp for_pr_adj

next_pr_adi:
// Afisam "endl" dupa fiecare linie;
	pushl $fen
	call printf
	addl $4, %esp
	
	pushl $0
	call fflush
	addl $4, %esp
	
	
	incl ii
	jmp for_pr_adi

check_nr:
	cmp $2, %ecx
	jne etexit
	
CERINTA_2:

/////	
	
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


/*	
		pushl %ecx
	pushl (%esi, %ecx, 4)
	pushl $fpr
	call printf
	addl $8, %esp
	
	pushl $0
	call fflush
	addl $4, %esp
		popl %ecx
*/		
