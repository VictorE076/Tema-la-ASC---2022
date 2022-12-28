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
	f2: .asciz "%d\n"
.text

// Aceasta procedura stocheaza inmultirea matricelor patratice m1 si m2 in mres;
//
// 8(%ebp) = $m1
// 12(%ebp) = $m2
// 16(%ebp) = $mres
// 20(%ebp) = n
//
//
// -16(%ebp) = a
// -20(%ebp) = b
// -24(%ebp) = c
// -28(%ebp) = vl
// -32(%ebp) = m1[a][c]
// -36(%ebp) = m2[c][b]
//
//////////////////////////
matrix_mult:
	pushl %ebp
	movl %esp, %ebp
	
		pushl %ebx
		pushl %esi
		pushl %edi
	
		
	subl $24, %esp
	
// a = b = c = vl = 0
	movl $0, -16(%ebp)
	movl $0, -20(%ebp)
	movl $0, -24(%ebp)
	movl $0, -28(%ebp)

	xor %ecx, %ecx
	xor %edx, %edx
	
// Efectuam inmultirea celor doua matrici:	
for_a:
	movl -16(%ebp), %ecx
	cmp 20(%ebp), %ecx
	je exit_for_a
	
	
	movl $0, -20(%ebp)
	for_b:
		movl -20(%ebp), %ecx
		cmp 20(%ebp), %ecx
		je exit_for_b
		
		
		// vl = 0;
		movl $0, -28(%ebp)
		xor %eax, %eax
		
		movl $0, -24(%ebp)
		for_c:
			movl -24(%ebp), %ecx
			cmp 20(%ebp), %ecx
			je exit_for_c
			
			
			// Aflam pozitia a * n + c a elementului din m1;
			movl -16(%ebp), %eax
			xor %edx, %edx
			mull 20(%ebp)
			addl -24(%ebp), %eax
			
			// Stocam elementul intr-o variabila locala;
			movl 8(%ebp), %esi
			movl (%esi, %eax, 4), %ebx
			movl %ebx, -32(%ebp)
			
			
			// Aflam pozitia c * n + b a elementului din m2;
			movl -24(%ebp), %eax
			xor %edx, %edx
			mull 20(%ebp)
			addl -20(%ebp), %eax
			
			// Stocam elementul intr-o variabila locala;
			movl 12(%ebp), %esi
			movl (%esi, %eax, 4), %ebx
			movl %ebx, -36(%ebp)
			
			
			// Calculam -32(%ebp) * -36(%ebp) si il adaugam in -28(%ebp);
			movl -32(%ebp), %eax
			xor %edx, %edx
			mull -36(%ebp)
			addl %eax, -28(%ebp)
			
			
			incl -24(%ebp)
			jmp for_c
		
		exit_for_c:
		
		
		// Aflam pozitia a * n + b a elementului din mres;
		movl -16(%ebp), %eax
		xor %edx, %edx
		mull 20(%ebp)
		addl -20(%ebp), %eax
		
		// Mutam -28(%ebp) in mres[a][b];
		movl 16(%ebp), %esi
		movl -28(%ebp), %ebx
		movl %ebx, (%esi, %eax, 4)
		
		
		incl -20(%ebp)
		jmp for_b
		
	exit_for_b:
	
	incl -16(%ebp)
	jmp for_a

exit_for_a:	
		
	addl $24, %esp
	
		
		popl %edi
		popl %esi
		popl %ebx
	
	popl %ebp
	ret
/////////////////////////	

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

// Citim k = lungimea drumului:	
	pushl $k
	pushl $fscan
	call scanf
	addl $8, %esp
	
// Citim i = nodul sursa:
	pushl $i
	pushl $fscan
	call scanf
	addl $8, %esp
	
// Citim j = nodul destinatie:
	pushl $j
	pushl $fscan
	call scanf
	addl $8, %esp
	
// Copiem valorile din m1 in m2:
	xor %ecx, %ecx
	xor %edx, %edx
	movl $0, ii
	movl $0, jj
	
for_1_cpy:
	movl ii, %ecx
	cmp n, %ecx
	je exit_for_1_cpy
	
	movl $0, jj
	for_2_cpy:
		movl jj, %ecx
		cmp n, %ecx
		je next_for_1_cpy
		
		
		// Aflam pozitia index-ului in m1:
		movl ii, %eax
		xor %edx, %edx
		mull n
		addl jj, %eax
		
		// Mutam elementul m1[ii][jj] in m2[ii][jj]:
		lea m1, %esi
		movl (%esi, %eax, 4), %ebx
		
		lea m2, %esi
		movl %ebx, (%esi, %eax, 4)
		
		
		
		incl jj
		jmp for_2_cpy

next_for_1_cpy:
		
	incl ii
	jmp for_1_cpy


exit_for_1_cpy:

// Calculam efectiv matricea m1 ** k:
for_k:
	movl k, %ecx
	cmp $1, %ecx
	je exit_for_k
	
// Apelam functia matrix_mult care va calcula in mres, m1 * m2:
		pushl %ebx
		pushl %esi
		pushl %edi
	pushl n
	pushl $mres
	pushl $m2
	pushl $m1
	call matrix_mult
	addl $16, %esp
		pushl %edi
		pushl %esi
		pushl %ebx
	
	// Copiem matricea mres inapoi in m1;
	movl $0, ii
	movl $0, jj
	xor %ecx, %ecx
	xor %edx, %edx
	
	for_1_mres:
		movl ii, %ecx
		cmp n, %ecx
		je exit_for_1_mres
		
		
		movl $0, jj
		for_2_mres:
			movl jj, %ecx
			cmp n, %ecx
			je exit_for_2_mres
			
			
			// Aflam pozitia ii * n + jj din matricea mres;
			movl ii, %eax
			xor %edx, %edx
			mull n
			addl jj, %eax
			
			// Copiem mres[ii][jj] in m1[ii][jj];
			lea mres, %esi
			movl (%esi, %eax, 4), %ebx
			
			lea m1, %esi
			movl %ebx, (%esi, %eax, 4)
			
			
			
			incl jj
			jmp for_2_mres
		
		exit_for_2_mres:
		
		
		
		incl ii
		jmp for_1_mres
	

	exit_for_1_mres:

	
	decl k
	jmp for_k


exit_for_k:

// Calculam pozitia i * n + j in m1 si afisam m1[i][j] sa aflam raspunsul final;
	movl i, %eax
	xor %edx, %edx
	mull n
	addl j, %eax
	
	lea m1, %esi
	
// Afisam nr. de drumuri de lungime k de la nodul i la nodul j;	

	pushl (%esi, %eax, 4)
	pushl $f2
	call printf
	addl $8, %esp
	
	pushl $0
	call fflush
	addl $4, %esp
	
etexit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80

// C.1

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

// C.2

/*
		pushl (%esi, %eax, 4)
		pushl $fpr
		call printf
		addl $8, %esp
		
		pushl $0
		call fflush
		addl $4, %esp
*/


/*
	pushl $fen
	call printf
	addl $4, %esp
	
	pushl $0
	call fflush
	addl $4, %esp
*/

/////////////////////

/*
			pushl (%esi, %eax, 4)
			pushl $fpr
			call printf
			addl $8, %esp
			
			pushl $0
			call fflush
			addl $4, %esp
*/


/*
		pushl $fen
		call printf
		addl $4, %esp
		
		pushl $0
		call fflush
		addl $4, %esp
*/


/*
	pushl $fen
	call printf
	addl $4, %esp
		
	pushl $0
	call fflush
	addl $4, %esp
*/
		
