                PRESERVE8
                THUMB

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     0x20000000                ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     0                         ; NMI Handler
                DCD     0                         ; Hard Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; SVCall Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; PendSV Handler
                DCD     0                         ; SysTick Handler
                DCD     0                         ; IRQ0 Handler

                AREA    |.text|, CODE, READONLY

; Reset Handler

Reset_Handler   PROC
                GLOBAL  Reset_Handler
                ENTRY
                LDR R2, =0x40000030               ;R2 s_addr reg addr
                ADDS R3, R2, #4                   ;R3 e_addr reg addr
                ADDS R4, R3, #4                   ;R4 ena reg addr
; Finish function code 
BLINK          	LDR R6, =0x00	 	  ;s_addr VALUE
				STR R6,	[R2]
				LDR R6, =0x01		  ;e_addr VALUE
				STR R6,	[R3]
				LDR R6,	=0x01
				STR R6,	[R4]
				B BLINK



/*Finish waterlight code*/



/*end*/
;;;;;;;;;;;;;;;;;;;;;;

                ENDP
                    
                END
