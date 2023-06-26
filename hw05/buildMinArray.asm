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
	LD R0, A ;; address of a[0]
	LD R1, B ;; address of b[0]
	LD R2, C ;; address of c[0]
	LD R3, LENGTH ;; R3 = 3 (length)
	AND R4, R4, #0 ;; R4 = 0 (i)

	WLOOP
		NOT R5, R3
		ADD R5, R5, #1 ;; R5 = -length
		ADD R5, R4, R5 ;; i - length
		BRzp ENDWLOOP
		ADD R0, R0, R4 ;; address of a[i]
		ADD R1, R1, R4 ;; address of b[i]
		LDR R0, R0, #0 ;; data at a[i]
		LDR R1, R1, #0 ;; data at b[i]
		NOT R1, R1
		ADD R1, R1, #1 ;; R1 = -b[i]
		AND R6, R6, #0 ;; R6 = 0
		ADD R6, R0, R1 ;; a[i] - b[i]
		BRp ELSE
		AND R7, R7, #0 ;; R7 = 0
		ADD R7, R7, #1 ;; R7 = 1
		NOT R6, R4 
		ADD R6, R6, #1 ;; R6 = -i
		ADD R6, R6, #-1 ;; R6 = -i - 1
		ADD R6, R3, R6 ;; R6 = length - i - 1
		ADD R2, R2, R6 ;; address of c[length - i - 1]
		STR, R7, R2, #0
		ADD R4, R4, #1 ;; R4 = i++
		BR WLOOP

		ELSE
		AND R7, R7, #0 ;; R7 = 0
		NOT R6, R4 
		ADD R6, R6, #1 ;; R6 = -i
		ADD R6, R6, #-1 ;; R6 = -i - 1
		ADD R6, R3, R6 ;; R6 = length - i - 1
		ADD R2, R2, R6 ;; address of c[length - i - 1]
		STR, R7, R2, #0

		ENDWLOOP
		HALT

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