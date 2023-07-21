
;; Timed Lab 3, Summer 2023
;; For this Timed Lab, you will be given a binary tree.
;; Your task will be to modify the tree by making the appropriate subroutine calls.
;; Specific instructions provided in tl03.pdf


.orig x3000
	HALT

;; FIBONACCI subroutine
;;
;; Pseudocode
;;
;; FIBONACCI(int num) {
;; 	   if (num <= 1) {
;; 		   return num;
;; 	   } else {
;; 		   int a = FIBONACCI(num - 1);
;; 		   int b = FIBONACCI(num - 2);
;; 		   return a + b;
;; 	   }
;; }

FIBONACCI
	;; todo
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
	LDR R0, R5, #4 ;; R0 = num
	ADD R0, R0, #-1 ;; R0 = num - 1 ;; -> num - 1 <= 0
	BRnz ENDIF
	ADD R6, R6, #-1 ;; pushing space for argument
	LDR R0, R5, #4 ;; R0 = num
	ADD R0, R0, #-1 ;; R0 = num - 1
	STR R0, R6, #0 ;; store num - 1 on top of the stack
	JSR FIBONACCI ;; call the method
	LDR R0, R6, #0 ;; grab the reutrn value from the top of the stack
	ADD R6, R6, #2 ;; pop the arguments
	STR R0, R5, #0 ;; int a = FIBONACCI(num - 1);

	ADD R6, R6, #-1 ;; pushing space for argument
	LDR R0, R5, #4 ;; R0 = num
	ADD R0, R0, #-2 ;; R0 = num - 2
	STR R0, R6, #0 ;; store num - 2 on top of the stack
	JSR FIBONACCI ;; call the method
	LDR R0, R6, #0 ;; grab the reutrn value from the top of the stack
	ADD R6, R6, #2 ;; pop the arguments
	STR R0, R5, #-1 ;; int b = FIBONACCI(num - 1);

	LDR R0, R5, #0 ;; R0 = a
	LDR R1, R5, #-1 ;; R1 = b
	ADD R0, R0, R1 ;; R0 = a + b
	STR R0, R5, #3 ;; stores a + b into return spot

	ENDIF
	LDR R0, R5, #4 ;; R0 = num
	STR R0, R5, #3 ;; stores num into reutrn value

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

;; ADDALL subroutine
;;
;; Pseudocode
;;
;; ADDALL(int num) {
;;     int sum = 0;
;; 	
;;     for (int i = 1; i <= num; i++) {
;; 	       sum = sum + i;
;; 	   }
;; 	
;; 	   return sum;
;; }

ADDALL
        ;; todo
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

		;; code

		AND R0, R0, #0 ;; R0 = 0;
		LDR R1, R5, #4 ;; R1 = num
		BRnz ENDLOOP
		AND R2, R2, #0 ;; R2 = 0
		ADD R2, R2, #1 ;; R2 = i = 1
		NOT R1, R1
		ADD R1, R1, #1 ;; R1 = -num
		LOOP
		ADD R0, R0, R2 ;; sum + i
		ADD R2, R2, #1 ;; i++
		ADD R4, R2, R1 ;; i - num
		BRnz LOOP
		BR ENDLOOP

		ENDLOOP
		STR R0, R5, #3 ;; storing sum into return slot

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

;; CHANGETREE subroutine
;;
;; Pseudocode
;;
;; CHANGETREE(Node node (address)) {
;; 	   if (node == 0) {
;; 		   return -1;
;; 	   }
;; 	
;; 	   int data = mem[node];
;; 	
;; 	   if (data % 2 == 0) {
;; 		   mem[node] = FIBONACCI(data);
;; 	   } else {
;; 		   mem[node] = ADDALL(data);
;; 	   }
;; 	
;; 	   Node left = mem[node + 1];
;; 	   CHANGETREE(left);
;; 	
;; 	   Node right = mem[node + 2];
;; 	   CHANGETREE(right);
;; 	
;; 	   return 0;
;; }

CHANGETREE
		;; todo
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

		;; code
		LDR R0, R5, #4 ;; R0 = address of node
		BRz ENDIFSTATE
		LDR R0, R0, #0 ;; R4 = node.data

		AND R0, R0, #1 ;; check if data is even
		BRz ZERO
		BR ODD
		;; even
		ZERO
		ADD R6, R6, #-1 ;; push space on stack
		LDR R0, R5, #4 ;; R0 = node
		LDR R0, R0, #0 ;; R0 = node.data
		STR R0, R6, #0 ;; data onto stack
		JSR FIBONACCI
		LDR R1, R6, #0 ;; get return value from stack
		ADD R6, R6, #2 ;; pop args
		LDR R0, R5, #4 ;; R0 = node
		STR R1, R0, #0 ;; mem[node] = fib
		BR LEFT


		ODD
		ADD R6, R6, #-1 ;; push space on stack
		LDR R0, R5, #4 ;; R0 = node
		LDR R0, R0, #0 ;; R0 = node.data
		STR R0, R6, #0 ;; data onto stack
		JSR ADDALL
		LDR R1, R6, #0 ;; get return value from stack
		ADD R6, R6, #2 ;; pop args
		LDR R0, R5, #4 ;; R0 = node
		STR R1, R0, #0 ;; mem[node] = addall
		BR LEFT

		LEFT
		LDR R0, R5, #4 ;; R0 = node
		LDR R0, R0, #1 ;; R0 = mem[node + 1]
		ADD R6, R6, #-1 ;; push space on stack
		STR R0, R6, #0 ;; store on stack
		JSR CHANGETREE
		ADD R6, R6, #2 ;; pop args

		LDR R0, R5, #4 ;; R0 = node
		LDR R0, R0, #2 ;; R0 = mem[node + 2]
		ADD R6, R6, #-1 ;; push space on stack
		STR R0, R6, #0 ;; store on stack
		JSR CHANGETREE
		ADD R6, R6, #2 ;; pop args

		AND R0, R0, #0 ;; R0 = 0
		STR R0, R5, #3 ;; store 0 as return value
		BR TD

		ENDIFSTATE
		AND R0, R0, #0 ;; R0 = 0
		ADD R0, R0, #-1 ;; R0 = -1
		STR R0, R5, #3 ;; -1 in return value
		BR TD

		TD
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
.end