;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Preorder Traversal
;;=============================================================
;;  Name: Eric Phan
;;============================================================

;;  In this file, you must implement the 'PREORDER_TRAVERSAL' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'PREORDER_TRAVERSAL' label
;;      * Add the [root (addr), arr (addr), index] params separated by a comma (,) 
;;        (e.g. x4000, x4020, 0)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. Node 8 is found at x4008)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  PREORDER_TRAVERSAL Pseudocode (see PDF for explanation and examples)
;;  - Nodes are blocks of size 3 in memory:
;;      * The data is located in the 1st memory location (offset 0 from the node itself)
;;      * The node's left child address is located in the 2nd memory location (offset 1 from the node itself)
;;      * The node's right child address is located in the 3rd memory location (offset 2 from the node itself)

;;  PREORDER_TRAVERSAL(Node root (addr), int[] arr (addr), int index) {
;;      if (root == 0) {
;;          return index;
;;      }
;;
;;      arr[index] = root.data;
;;      index++;
;;
;;      index = PREORDER_TRAVERSAL(root.left, arr, index);
;;      return PREORDER_TRAVERSAL(root.right, arr, index);
;;  }


PREORDER_TRAVERSAL ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the PREORDER_TRAVERSAL subroutine here!
    ;; buildup 
    ADD R6, R6, #-4 ;; Allocate Space
    STR R7, R6, #2  ;; Save Ret Addr
    STR R5, R6, #1  ;; Save Old FP
    ADD R5, R6, #0  ;; Set New FP
    ADD R6, R6, #-5  ;; SET X TO (-4 - NUM LVs) OR -5 IF NOT USING LVs
    STR R0, R6, #0  ;; Save R0
    STR R1, R6, #1  ;; Save R1
    STR R2, R6, #2  ;; Save R2
    STR R3, R6, #3  ;; Save R3
    STR R4, R6, #4  ;; Save R4

    ;; body of code
    ;; if (root == 0)
    LDR R0, R5, #4 ;; R0 = root
    ADD R0, R0, #0 ;; add nothing to check condition code
    BRnp END_IF
    ;; return index
    LDR R0, R5, #6 ;; R0 = index
    STR R0, R5, #3 ;; return value = index
    BR TEARDOWN

    END_IF
    ;; arr[index] = root.data
    LDR R0, R5, #5 ;; R0 = arr
    LDR R1, R5, #6 ;; R1 = index
    ADD R0, R0, R1 ;; R0 arr[index] address
    LDR R1, R5, #4 ;; R1 = root
    LDR R1, R1, #0 ;; R1 = root.data?
    STR R1, R0, #0 ;; arr[index] = root.data

    ;; index++
    LDR R0, R5, #6 ;; R0 = index
    ADD R0, R0, #1 ;; R0 = index + 1
    STR R0, R5, #6 ;; index = index + 1

    ;; index = PREORDER_TRAVERSAL(root.left, arr, index)
    ADD R6, R6, #-3 ;; push space for 3 arguments
    LDR R0, R5, #4 ;; R0 = root
    LDR R0, R0, #1 ;; R0 = root.left
    STR R0, R6, #0 ;; pushing 1st arg (root.left) onto stack
    LDR R0, R5, #5 ;; R0 = arr
    STR R0, R6, #1 ;; pushing 2nd arg (arr) onto stack
    LDR R0, R5, #6 ;; R0 = index
    STR R0, R6, #2 ;; pushing 3rd arg (index) onto stack
    JSR PREORDER_TRAVERSAL ;; calling function
    LDR R0, R6, #0 ;; R0 = PREORDER_TRAVERSAL(root.left, arr, index)
    ADD R6, R6, #4 ;; popping arguments + return from stack 
    STR R0, R5, #6 ;; index = PREORDER_TRAVERSAL(root.left, arr, index)

    ;; return PREORDER_TRAVERSAL(root.right, arr, index)
    ADD R6, R6, #-3 ;; push space for 3 arguments
    LDR R0, R5, #4 ;; R0 = root
    LDR R0, R0, #2 ;; R0 = root.right
    STR R0, R6, #0 ;; pushing 1st arg (root.right) onto stack
    LDR R0, R5, #5 ;; R0 = arr
    STR R0, R6, #1 ;; pushing 2nd arg (arr) onto stack
    LDR R0, R5, #6 ;; R0 = index
    STR R0, R6, #2 ;; pushing 3rd arg (index) onto stack
    JSR PREORDER_TRAVERSAL ;; calling function
    LDR R0, R6, #0 ;; R0 = PREORDER_TRAVERSAL(root.right, arr, index)
    ADD R6, R6, #4 ;; popping arguments + return from stack 
    STR R0, R5, #3 ;; return value = PREORDER_TRAVERSAL(root.right, arr, index)


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

; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

;;  Assuming the tree starts at address x4000, here's how the tree (see below and in the PDF) is represented in memory
;;
;;              6
;;            /   \
;;           2     9
;;         /   \
;;        1     5

.orig x4000 ;; 6    ;; node itself lives here at x4000
    .fill 6         ;; node.data (6)
    .fill x4004     ;; node.left lives at address x4004
    .fill x4008     ;; node.right lives at address x4008
.end

.orig x4004	;; 2    ;; node itself lives here at x4004
    .fill 2         ;; node.data (2)
    .fill x400C     ;; node.left lives at address x400C
    .fill x4010     ;; node.right lives at address x4010
.end

.orig x4008	;; 9    ;; node itself lives here at x4008
    .fill 9         ;; node.data (9)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

.orig x400C	;; 1    ;; node itself lives here at x400C
    .fill 1         ;; node.data (1)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

.orig x4010	;; 5    ;; node itself lives here at x4010
    .fill 5         ;; node.data (5)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

;;  Another way of looking at how this all looks like in memory
;;              6
;;            /   \
;;           2     9
;;         /   \
;;        1     5
;;  Memory Address           Data
;;  x4000                    6          (data)
;;  x4001                    x4004      (6.left's address)
;;  x4002                    x4008      (6.right's address)
;;  x4003                    Don't Know
;;  x4004                    2          (data)
;;  x4005                    x400C      (2.left's address)
;;  x4006                    x4010      (2.right's address)
;;  x4007                    Don't Know
;;  x4008                    9          (data)
;;  x4009                    0(NULL)
;;  x400A                    0(NULL)
;;  x400B                    Don't Know
;;  x400C                    1          (data)
;;  x400D                    0(NULL)
;;  x400E                    0(NULL)
;;  x400F                    Dont't Know
;;  x4010                    5          (data)
;;  x4011                    0(NULL)
;;  x4012                    0(NULL)
;;  x4013                    Don't Know
;;  
;;  *Note: 0 is equivalent to NULL in assembly

.orig x4020 ;; Result Array : You can change the block size for debugging!
    .blkw 5
.end