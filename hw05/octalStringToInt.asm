;;=============================================================
;; CS 2110 - Summer 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Eric Phan
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String octalString = "2023";
;;  int length = 4;
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 3;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      int digit = octalString[i] - 48;
;;      value += digit;
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    ;; YOUR CODE HERE
    LD R0, LENGTH ;; R0 = 4 (length)
    AND R1, R1, #0 ;; R1 = 0 (value)
    AND R2, R2, #0 ;; R2 = 0 (i)
    WLOOP1
        NOT R3, R2
        ADD R3, R3, #1 ;; R3 = -i
        ADD R3, R0, R3 ;; i - length
        BRnz ENDWLOOP1
            AND R4, R4, #0
            ADD R4, R4, #3 ;; R4 = 3 (leftShifts)
        WLOOP2
            ADD R4, R4, #0
            BRnz ENDWLOOP2
            ADD R1, R1, R1 ;; R1 += R1 (value += value)
            ADD R4, R4, #-1 ;; R4-- (leftShifts--)
            BR WLOOP2
        ENDWLOOP2
            LD R5, OCTALSTRING ;; R5 = x5000 (OCTALSTRING)
            ADD R5, R5, R2 ;; address of octalString[i]
            LDR R5, R5, #0 ;; data of octalString[i]
            LD R6, ASCII ;; R6 = -48
            ADD R5, R5, R6 ;; R5 = octalString[i] - 48 (digit)
            ADD R1, R1, R5 ;; R1 += R5 (value += digit)
            ADD R2, R2, #1 ;; R2++ (i++)
            BR WLOOP1

    ENDWLOOP1
    STI R1, RESULTADDR
    HALT
    
;; Do not change these values! 
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2023"            ;;  You can change this string for debugging!
.end
