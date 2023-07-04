;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Insertion Sort
;;=============================================================
;;  Name: Eric Phan
;;============================================================

;;  In this file, you must implement the 'INSERTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'INSERTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * INSERTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  INSERTION_SORT **RECURSIVE** Pseudocode (see PDF for explanation and examples)
;; 
;;  INSERTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;        return;
;;      }
;;  
;;      INSERTION_SORT(arr, length - 1);
;;  
;;      int last_element = arr[length - 1];
;;      int n = length - 2;
;;  
;;      while (n >= 0 && arr[n] > last_element) {
;;          arr[n + 1] = arr[n];
;;          n--;
;;      }
;;  
;;      arr[n + 1] = last_element;
;;  }

INSERTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the INSERTION_SORT subroutine here!
    ;; NOTE: Your implementation MUST be done recursively
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

    ;; code
    LDR R0, R5, #4 ;; R0 = arr
    LDR R1, R5, #5 ;; R1 = length
    ADD R2, R1, #-1 ;; length - 1
    ;; checks condition length - 1 <= 0 
    BRp END_IF
    BR TEARDOWN

    END_IF
    ;; start the function call
    ADD R6, R6, #-2 ;; pushing space for arguments
    STR R0, R6, #0 ;; pushing 1st arg (arr) onto stack
    STR R2, R6, #1 ;; pushing second arg (length - 1) onto stack
    JSR INSERTION_SORT ;; calling method again
    ;; don't store a value because it returns null
    ADD R6, R6, #3 ;; popping arguments and return value

    ;; int last_element = arr[length - 1];
    AND R3, R3, #0 ;; setting R3 = 0
    ADD R3, R0, R2 ;; R3 = address for arr[length - 1]
    LDR R3, R3, #0 ;; value of arr[length - 1]
    STR R3, R5, #0 ;; last_element = arr[length - 1]

    ;; int n = length - 2
    AND R3, R3, #0 ;; setting R3 = 0
    ADD R3, R2, #-1 ;; R3 = length - 2
    STR R3, R5, #-1 ;; n = length - 2

    ;; while loop
    WHILE
    ;; n >= 0 condition
    LDR R3, R5, #-1 ;; R3 = n
    BRn END_WHILE
    ;; arr[n] > last_element -> arr[n] - last_element > 0
    LDR R3, R5, #-1 ;; R3 = n
    ADD R3, R3, R0 ;; R3 = arr[n] address
    LDR R3, R3, #0 ;; R3 = arr[n] value
    LDR R4, R5, #0 ;; R4 = last_element
    NOT R4, R4
    ADD R4, R4, #1 ;; R4 = -last_element
    ADD R3, R3, R4 ;; arr[n] - last_element
    BRnz END_WHILE
    ;; arr[n + 1] = arr[n]
    LDR R3, R5, #-1 ;; R3 = n
    ADD R3, R3, R0 ;; R3 = arr[n] address
    LDR R4, R3, #0 ;; R4 = arr[n] value
    STR R4, R3, #1 ;; arr[n + 1] = arr[n]
    ;; n--
    LDR R3, R5, #-1 ;; R3 = n
    ADD R3, R3, #-1 ;; R3 = n - 1
    STR R3, R5, #-1 ;; n = n - 1 ;; maybe no need this line
    BR WHILE

    END_WHILE
    ;; arr[n + 1] = last_element
    LDR R3, R5, #-1 ;; R3 = n
    ADD R3, R3, #1 ;; R3 = n + 1
    ADD R3, R3, R0 ;; R3 = arr[n + 1] address
    LDR R4, R5, #0 ;; R4 = last_element
    STR R4, R3, #0 ;; arr[n + 1] = last_element
     

    ;; teardown
    TEARDOWN
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

.orig x4000	;; Array : You can change these values for debugging!
    .fill 3
    .fill 5
    .fill 2
    .fill 1
    .fill 7
.end