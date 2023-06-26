;;=============================================================
;; CS 2110 - Summer 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Eric PHan
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "racecar";
;;  boolean isPalindrome = true
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0
;;  int right = length - 1
;;  while(left < right) {
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;			break;
;;		}
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000
	;; YOUR CODE HERE
	AND R0, R0, #0 ;; length = 0
	AND R7, R7, #0
	ADD R7, R7, #1 ;; R7 = isPalindrome = 1 (true)

	WLOOP1
		LD R1, STRING ;; R1 = x4004
		ADD R2, R0, R1 ;; R2 = address of str[length]
		LDR R3, R2, #0 ;; R2 = str[length]
		BRz ENDWLOOP1
		ADD R0, R0, #1 ;; R0 = length++
		BRnzp WLOOP1
	
	ENDWLOOP1
		AND R2, R2, #0 ;; clears R2, now R2 = 0 (left)
		AND R4, R4, #0 ;; R4 = 0
		ADD R4, R4, R0 ;; R4 = length
		ADD R4, R4, #-1 ;; R4 = length - 1 (right)

	WLOOP2
		AND R5, R5, #0 ;; R5 = 0
		ADD R5, R5, R4 ;; R5 = right = length - 1
		NOT R5, R5 
		ADD R5, R5, #1 ;; R5 = -right = -(legnth - 1)
		BRzp ENDWLOOP2
		LD R1, STRING ;; R1 = x4004 (STRING)
		ADD R1, R1, R2 ;; address of str[left]
		LDR R6, R1, #0 ;; data at str[left]
		LD R1, STRING ;; R1 = x4004 (STRING)
		ADD R1, R1, R4 ;; address at str[left]
		LDR R5, R1, #0 ;; data at str[right]
		NOT R5, R5
		ADD R5, R5, #1 ;; -str[right]
		ADD R6, R6, R5 ;; str[left] - str[right]
		BRz ENDIF
		AND R7, R7, #0 ;; isPalindrome = 0 (false)
		BRnzp ENDWLOOP2

	ENDIF
		ADD R2, R2, #1
		ADD R4, R4, #-1
		BR WLOOP2

	ENDWLOOP2
		STI R7, ANSWERADDR

	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004				   
	.stringz "racecar" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end