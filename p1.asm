;**********************************************************************
;   This file is a basic code template for assembly code generation   *
;   on the PIC16F873. This file contains the basic code               *
;   building blocks to build upon.                                    *  
;                                                                     *
;   Refer to the MPASM User's Guide for additional information on     *
;   features of the assembler (Document DS33014).                     *
;                                                                     *
;   Refer to the respective PIC data sheet for additional             *
;   information on the instruction set.                               *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Filename:	    xxx.asm                                           *
;    Date:                                                            *
;    File Version:                                                    *
;                                                                     *
;    Author:                                                          *
;    Company:                                                         *
;                                                                     * 
;                                                                     *
;**********************************************************************
;                                                                     *
;    Files Required: P16F873.INC                                      *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Notes:                                                           *
;                                                                     *
;**********************************************************************


	list      p=16f873            ; list directive to define processor
	#include <p16f873.inc>        ; processor specific variable definitions
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _RC_OSC & _WRT_ENABLE_ON & _LVP_ON & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.






;***** VARIABLE DEFINITIONS
w_temp        EQU     0x20        ; variable used for context saving 
status_temp   EQU     0x21        ; variable used for context saving


vA		EQU 0x22
vB		EQU 0x23
vC		EQU 0x24





;**********************************************************************
		ORG     0x000             ; processor reset vector
		clrf    PCLATH            ; ensure page bits are cleared
  		goto    main              ; go to beginning of program


		ORG     0x004             ; interrupt vector location
		movwf   w_temp            ; save off current W register contents
		movf	STATUS,w          ; move status register into W register
		bcf     STATUS,RP0        ; ensure file register bank set to 0
		movwf	status_temp       ; save off contents of STATUS register


; isr code can go here or be located as a call subroutine elsewhere


		bcf     STATUS,RP0        ; ensure file register bank set to 0
		movf    status_temp,w     ; retrieve copy of STATUS register
		movwf	STATUS            ; restore pre-isr STATUS register contents
		swapf   w_temp,f
		swapf   w_temp,w          ; restore pre-isr W register contents
		retfie                    ; return from interrupt



main

; remaining code goes here

	call	ret_xx
	nop
	nop
	goto main
;--------------------------------------------------
ret_xx
	movlw	.30
	movwf	vC
loop3
	call ret_100mseg
	decfsz	vC,f
	goto	loop3
	return
;--------------------------------------------------
ret_100mseg
	movlw	.100
	movwf	vB
loop2
	call ret_1mseg
	decfsz	vB,f
	goto	loop2
	return
;--------------------------------------------------
ret_1mseg
	clrf	vA
	movlw	.199
	movwf	vA
loop
	nop
	nop
	decfsz	vA,f
	goto	loop
	return

;-------------------------------------------------




		END                       ; directive 'end of program'
