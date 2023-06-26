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
;;	int length = 3; -> length = 2
;;
;;	int i = 0;
;;	while (i < length) { -> (length + 1 > 0)
;;		if (A[i] <= B[i]) { -> A[length] <= B[length]
;;			C[length - i - 1] = 1; -> C[i] = 1
;;		}
;;		else {
;;			C[length - i - 1] = 0; -> C[i] = 0
;;		}
;;		length-- 
;;		i++;
;;	}

.orig x3000
	;; YOUR CODE HERE
	LD R0, LENGTH ;; R0 = length
	ADD R0, R0, #-1 ;; R0 = 2 (length - 1)
	AND R1, R1, #0 ;; clears R1, R1 = 0

	WLOOP
	; ADD R0, R0, #1 ;; length + 1
	; BRnz ENDWLOOP
	LD R2, A ;; address of a[0]
	ADD R2, R2, R0 ;; address of a[length]
	LD R3, B ;; address of b[0]
	ADD R3, R3, R0 ;; address of b[length]
	LDR R2, R2, #0 ;; data at a[length]
	LDR R3, R3, #0 ;; data at b[length]
	NOT R3, R3 ;; not b[length]
	ADD R3, R3, #1 ;; -b[length]
	ADD R2, R2, R3 ;; a[length] - b[length]
	BRp ELSE
	AND R3, R3, #0
	ADD R3, R3, #1 ;; 1 value to store in C
	BR STORE_C_VALUE

	ELSE
	AND R3, R3, #0 ;; 0 value to store in C
	BR STORE_C_VALUE

	STORE_C_VALUE
	LD R2, C ;; address of c[0]
	ADD R2, R2, R1 ;; address of c[i]
	STR R3, R2, #0 ;; stores R3 value (0 or 1) into c[i]
	BR END_IF

	END_IF
	ADD R1, R1, #1 ;; i++
	ADD R0, R0, #-1 ;; length--
	BRzp WLOOP
	HALT

	ENDWLOOP
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