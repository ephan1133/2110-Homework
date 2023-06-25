;;=============================================================
;; CS 2110 - Summer 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Eric Phan
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  int x = 14;
;;  int mod = 3;
;;  while (x >= mod) {
;;      x -= mod;
;;  }
;;  mem[ANSWER] = x;

.orig x3000
    LD R0, X ;; int x = 14
    LD R1, MOD ;; int mod = 3

    NOT R1, R1
    ADD R1, R1, #1 ;; -mod

    WLOOP
    ADD R0, R0, R1 ;; x -= mod
    BRzp WLOOP ;; stops the loop once x is negative

    NOT R1, R1
    ADD R1, R1, #1 ;; +mod

    ADD R0, R0, R1 ;; restores R0 back to correct modulus answer
    ST R0, ANSWER ;; stores x into answer
    HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 14
    MOD    .fill 3     
    ANSWER .blkw 1
.end