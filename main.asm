;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
			.data
X:			.word 0x1234
Y:			.word 0xABCD
Z1:			.byte 0x12
Z2:			.byte 0x0F
Mem:		.space 68

            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
			mov.w #Mem, R15			;Put address of memory into register 15
			mov.w X, R4				;Copy value of X into R4
			mov.w Y, R5				;Copy value of Y into R5
			mov.b Z1, R6			;Copy value of Z1 into R6
			mov.b Z2, R7			;Copy value of Z2 into R7

			mov.w R4, 0(R15)		;Copy first 16 bits of X to Mem + 0

			mov.b R4, 4(R15)		;Copy first 8 bits of X to Mem + 4

			swpb R4					;Swap the bytes of R4
			mov.b R4, 8(R15)		;Copy 2nd byte of R4 to Mem + 8
			swpb R4					;Reset R4

			add.w R4, R5			;Add R4 and R5 and put into R5
			mov.w R5, 12(R15)		;Move result into Mem + 12
			mov.w Y, R5				;Reset R5

			add.b R6, R7			;Add 1st byte of R6 and R7
			mov.b R7, 16(R15)		;Move result into Mem + 16
			mov.b Z2, R7			;Reset R7

			sub.b R7, R6			;Subtract 1st byte of R7 from R6
			mov.b R6, 20(R15)		;Move result into Mem + 20
			mov.b Z1, R6			;Reset R6

            sub.b R6, R7			;Subtract 1st byte of R6 from R7
			mov.b R7, 24(R15)		;Move result into Mem + 24
			mov.b Z2, R7			;Reset R7

			sub.w R4, R5			;Subtract R4 from R5
			mov.w R5, 28(R15)		;Store result into Mem + 28
			mov.w Y, R5				;Reset R5

			sub.w R5, R4			;Subtract R5 from R4
			mov.w R4, 32(R15)		;Store result into Mem + 32
			mov.w X, R4				;Reset R4

			inv.w R5				;Inverts R5
			mov.w R5, 36(R15)		;Stores result into Mem + 36
			mov.w Y, R5				;Reset R5

			inv.b R6				;Inverts 1st byte of R6
			mov.b R6, 40(R15)		;Stores result into Mem + 40
			mov.b Z1, R6			;Reset R6

			mov.w X, 44(R15)		;Moves X into Mem + 44

			and.w R6, R7			;AND of R6 and R7
			mov.w R7, 48(R15)		;Stores result into Mem + 48
			mov.b Z2, R7			;Reset R7

			xor.w R6, R7			;XOR of R6 and R7
			mov.w R7, 52(R15)		;Stores result into Mem + 52
			mov.b Z2, R7			;Reset R7

			dec.w R6				;Decrement R6 by 1
			mov.w R6, 56(R15)		;Store result into Mem + 56
			mov.b Z1, R6			;Reset R6

			decd.w R7				;Decrement R6 by 2
			mov.w R7, 60(R15)		;Store result into Mem + 60
			mov.b Z2, R7			;Reset R7

			swpb R4					;Swap bytes of R4
			mov.w R4, 64(R15)		;Store result into Mem + 64

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
