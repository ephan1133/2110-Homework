;;=============================================================
;; CS 2110 - Summer 2023
;; Homework 5 - buildMinArray
;;=============================================================
;; Name: Eric Phan
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;	int A[] = {-4, 6, 0};
;;	int B[] = {1, 5, 2};
;;	int C[3];
;;	int length = 3;
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] <= B[i]) {
;;			C[length - i - 1] = 1;
;;		}
;;		else {
;;			C[length - i - 1] = 0;
;;		}
;;		i++;
;;	}

.orig x3000
	;; YOUR CODE HERE
	LD R0, LENGTH ;; length = 3
	LD R1, #0 ;; i = 0
	LD R2, A ;; the address of A[0]
	LD R3, B ;; the address of B[0]
	LD R4, C ;; the address of C[0]

	WLOOP
		NOT R0, R0
		ADD R0, R0, #1 ;; -length
		ADD R5, R0, R1 ;; i - length
		BRzp STOP

		LDR R2, R2, #0 ;; A[i] 
		LDR R3, R3, #0 ;; B[i]

		NOT R3, R3
		ADD R3, R3, #1 ;; -B[i]

		ADD R2, R2, R3 ;; A[i] - B[i]
		BRnz ASSIGN_ONE
		BRp ASSIGN_ZERO
		ADD R1, R1, #1
		BRnzp WLOOP

		ASSIGN_ONE
		LD R6, LENGTH
		NOT R1, R1
		ADD R1, R1, #1 ;; -i
		ADD R6, R6, R1
		ADD R6, R6, #-1 ;; [length - i - 1]
		
		ADD R4, R4, R6 ;; C[length - i - 1]

		;; clear R6 so i can put #1 into R6 and store it 
		AND R6, R6, #0 ;; clears R6
		LD R6, #1 ;; loads #1 into R6
		STR R6, R4, #0 ;; C[length - i - 1] = 1
		
		NOT R1, R1
		ADD R1, R1, #1 ;; +i

		ASSIGN_ZERO
		LD R6, LENGTH
		NOT R1, R1
		ADD R1, R1, #1 ;; -i
		ADD R6, R6, R1
		ADD R6, R6, #-1 ;; [length - i - 1]
		
		ADD R4, R4, R6 ;; C[length - i - 1]

		AND R6, R6, #0 ;; clears R6
		LD R6, #0 ;; loads #0 into R6
		STR R6, R4, #0 ;; C[length - i - 1] = 1
		
		NOT R1, R1
		ADD R1, R1, #1 ;; +i

		STOP
		HALT

;; Do not change these addresses! 
;; We populate A and B and reserve space for C at these specific addresses in the orig statements below.
A 		.fill x3200		
B 		.fill x3300		
C 		.fill x3400		
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -4
	.fill 6
	.fill 0
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 5
	.fill 2
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end