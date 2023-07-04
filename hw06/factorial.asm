;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Factorial
;;=============================================================
;;  Name: Eric Phan
;;============================================================

;;  In this file, you must implement the 'MULTIPLY' and 'FACTORIAL' subroutines.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'MULTIPLY' or 'FACTORIAL' labels
;;      * Add the [a, b] or [n] params separated by a comma (,) 
;;        (e.g. 3, 5 for 'MULTIPLY' or 6 for 'FACTORIAL')
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. 3 * 5 = 15 or 6! = 720)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  MULTIPLY Pseudocode (see PDF for explanation and examples)   
;;  
;;  MULTIPLY(int a, int b) {
;;      int ret = 0;
;;      while (b > 0) {
;;          ret += a;
;;          b--;
;;      }
;;      return ret;
;;  }

MULTIPLY ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the MULTIPLY subroutine here!
    ADD R6, R6, #-4
    STR R7, R6, #2
    STR R5, R6, #1
    ADD R5, R6, #0
    ADD R6, R6, #-5 ;; SET X TO -4 - NUM LVs OR -5 IF NO LVs
    STR R0, R6, #0
    STR R1, R6, #1
    STR R2, R6, #2
    STR R3, R6, #3
    STR R4, R6, #4

    ;; body of code
    AND R0, R0, #0 ;; R0 = 0
    STR R0, R5, #0 ;; ret = 0
    WLOOP
        LDR R0, R5, #5 ;; R0 = b
        BRnz ENDWLOOP
        LDR R0, R5, #0 ;; R0 = ret
        LDR R1, R5, #4 ;; R1 = a
        ADD R0, R0, R1 ;; R0 = ret + a
        STR R0, R5, #0 ;; ret = R0

        LDR R0, R5, #5 ;; R0 = b
        ADD R0, R0, #-1 ;; R0 -= 1
        STR R0, R5, #5 ;; b = R0
        BR WLOOP

    ENDWLOOP
        LDR R0, R5, #0 ;; R0 = ret
        STR R0, R5, #3 ;; return value = ret

    LDR R0, R6, #0
    LDR R1, R6, #1
    LDR R2, R6, #2
    LDR R3, R6, #3
    LDR R4, R6, #4
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3

    RET

;;  FACTORIAL Pseudocode (see PDF for explanation and examples)
;;
;;  FACTORIAL(int n) {
;;      int ret = 1;
;;      for (int x = 2; x <= n; x++) {
;;          ret = MULTIPLY(ret, x);
;;      }
;;      return ret;
;;  }

FACTORIAL ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the FACTORIAL subroutine here!
    ;; buildup
    ADD R6, R6, #-4 ;; Allocate Space
    STR R7, R6, #2  ;; Save Ret Addr
    STR R5, R6, #1  ;; Save Old FP
    ADD R5, R6, #0  ;; Set New FP
    ADD R6, R6, #-6  ;; SET X TO (-4 - NUM LVs) OR -5 IF NOT USING LVs
    STR R0, R6, #0  ;; Save R0
    STR R1, R6, #1  ;; Save R1
    STR R2, R6, #2  ;; Save R2
    STR R3, R6, #3  ;; Save R3
    STR R4, R6, #4  ;; Save R4

    ;; body of subroutine
    AND R0, R0, #0 ;; R0 = 0
    ADD R0, R0, #1 ;; R0 = 1
    STR R0, R5, #0 ;; ret = 1
    AND R0, R0, #0 ;; R0 = 0
    ADD R0, R0, #2 ;; R0 = 2
    STR R0, R5, #-1 ;; x = 2
    FORLOOP
        LDR R0, R5, #-1 ;; R1 = x
        LDR R1, R5, #4 ;; R1 = n
        NOT R1, R1 ;; not R1
        ADD R1, R1, #1 ;; -n
        ADD R0, R0, R1 ;; 2 - n
        BRp ENDFORLOOP
        LDR R0, R5, #0 ;; R0 = ret
        LDR R1, R5, #-1 ;; R1 = x
        ADD R6, R6, #-2 ;; push space for 2 arguments
        STR R0, R6, #0 ;; 1st argument = ret
        STR R1, R6, #1 ;; 2nd argument = x
        JSR MULTIPLY ;; calls multipy(ret, x)
        LDR R0, R6, #0 ;; R0 = multiply(ret, x)
        ADD R6, R6, #3 ;; soft pop
        STR R0, R5, #0 ;; ret = multiplfy(ret, x)
        LDR R0, R5, #-1 ;; R0 = x
        ADD R0, R0, #1 ;; R0++
        STR R0, R5, #-1 ;; x = x + 1
        BR FORLOOP
    ENDFORLOOP
        LDR R0, R5, #0 ;; R0 = ret
        STR R0, R5, #3 ;; return value = ret

    ;; teardown
    LDR R0, R6, #0 ;; Restore R0
    LDR R1, R6, #1 ;; Restore R1
    LDR R2, R6, #2 ;; Restore R2
    LDR R3, R6, #3 ;; Restore R3
    LDR R4, R6, #4 ;; Restore R4
    ADD R6, R5, #0 ;; Pop Saved Regs and LVs
    LDR R5, R6, #1 ;; Restore Old FP
    LDR R7, R6, #2 ;; Restore Ret Addr
    ADD R6, R6, #3 ;; Pop All But Ret Val
    RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end