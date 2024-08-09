
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
	MOVF       _manual+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
	MOVLW      1
	MOVWF      _manual+0
L_interrupt1:
	INCF       _count+0, 1
L_interrupt0:
L_end_interrupt:
L__interrupt51:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_initial:

	CLRF       TRISD+0
	CLRF       TRISC+0
	MOVLW      3
	MOVWF      TRISB+0
	CLRF       PORTD+0
	CLRF       PORTC+0
	CLRF       PORTB+0
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
L_end_initial:
	RETURN
; end of _initial

_manual_:

	MOVF       _manual+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual_2
	MOVF       _count+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual_3
	BSF        PORTC+0, 0
	BCF        PORTC+0, 1
	BCF        PORTC+0, 2
	CLRF       _ind2+0
	BCF        PORTC+0, 3
	MOVLW      3
	MOVWF      _k+0
L_manual_4:
	MOVF       _k+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_manual_5
	MOVLW      1
	SUBWF      _ind1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_manual_7
	MOVF       _segment+0, 0
	MOVWF      PORTD+0
	GOTO       L_manual_6
L_manual_7:
	BSF        PORTC+0, 4
	MOVF       _k+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_manual_8:
	DECFSZ     R13+0, 1
	GOTO       L_manual_8
	DECFSZ     R12+0, 1
	GOTO       L_manual_8
	NOP
	NOP
L_manual_6:
	DECF       _k+0, 1
	GOTO       L_manual_4
L_manual_5:
	MOVLW      1
	MOVWF      _ind1+0
	BCF        PORTC+0, 3
	BCF        PORTC+0, 4
	BSF        PORTC+0, 5
	GOTO       L_manual_9
L_manual_3:
	MOVF       _count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_manual_10
	CLRF       _ind1+0
	BCF        PORTC+0, 0
	BCF        PORTC+0, 5
	BSF        PORTC+0, 3
	CLRF       _count+0
	MOVLW      3
	MOVWF      _k+0
L_manual_11:
	MOVF       _k+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_manual_12
	MOVLW      1
	SUBWF      _ind2+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_manual_14
	MOVF       _segment+0, 0
	MOVWF      PORTD+0
	GOTO       L_manual_13
L_manual_14:
	BSF        PORTC+0, 1
	MOVF       _k+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_manual_15:
	DECFSZ     R13+0, 1
	GOTO       L_manual_15
	DECFSZ     R12+0, 1
	GOTO       L_manual_15
	NOP
	NOP
L_manual_13:
	DECF       _k+0, 1
	GOTO       L_manual_11
L_manual_12:
	MOVLW      1
	MOVWF      _ind2+0
	BSF        PORTC+0, 2
	BCF        PORTC+0, 4
	BCF        PORTC+0, 1
L_manual_10:
L_manual_9:
L_manual_2:
L_end_manual_:
	RETURN
; end of _manual_

_automatic:

	MOVF       _manual+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_automatic16
	MOVF       PORTC+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__automatic47
	BTFSC      PORTC+0, 3
	GOTO       L__automatic47
	GOTO       L_automatic19
L__automatic47:
	MOVLW      23
	MOVWF      _i+0
L_automatic20:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic21
	BCF        PORTC+0, 0
	MOVF       _i+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_automatic23
	BSF        PORTC+0, 1
	GOTO       L_automatic24
L_automatic23:
	BCF        PORTC+0, 1
L_automatic24:
	MOVF       _i+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_automatic25
	BSF        PORTC+0, 2
	GOTO       L_automatic26
L_automatic25:
	BCF        PORTC+0, 2
L_automatic26:
	BSF        PORTC+0, 3
	BCF        PORTC+0, 4
	BCF        PORTC+0, 5
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_automatic27:
	DECFSZ     R13+0, 1
	GOTO       L_automatic27
	DECFSZ     R12+0, 1
	GOTO       L_automatic27
	DECFSZ     R11+0, 1
	GOTO       L_automatic27
	NOP
	DECF       _i+0, 1
	GOTO       L_automatic20
L_automatic21:
	MOVF       _manual+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_automatic28
	BCF        PORTC+0, 3
L_automatic28:
	GOTO       L_automatic29
L_automatic19:
	MOVLW      15
	MOVWF      _i+0
L_automatic30:
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic31
	BSF        PORTC+0, 0
	BCF        PORTC+0, 1
	BCF        PORTC+0, 2
	BCF        PORTC+0, 3
	MOVF       _i+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_automatic33
	BSF        PORTC+0, 4
	GOTO       L_automatic34
L_automatic33:
	BCF        PORTC+0, 4
L_automatic34:
	MOVF       _i+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_automatic35
	BSF        PORTC+0, 5
	GOTO       L_automatic36
L_automatic35:
	BCF        PORTC+0, 5
L_automatic36:
	MOVF       _i+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_automatic37:
	DECFSZ     R13+0, 1
	GOTO       L_automatic37
	DECFSZ     R12+0, 1
	GOTO       L_automatic37
	DECFSZ     R11+0, 1
	GOTO       L_automatic37
	NOP
	DECF       _i+0, 1
	GOTO       L_automatic30
L_automatic31:
	MOVF       _manual+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_automatic38
	BSF        PORTC+0, 0
L_automatic38:
L_automatic29:
L_automatic16:
L_end_automatic:
	RETURN
; end of _automatic

_switching:

	BTFSC      PORTB+0, 1
	GOTO       L_switching41
	MOVF       _manual+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_switching41
L__switching49:
	CALL       _manual_+0
L_switching41:
	BTFSS      PORTB+0, 1
	GOTO       L_switching44
	MOVF       _manual+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_switching44
L__switching48:
	CALL       _automatic+0
L_switching44:
L_end_switching:
	RETURN
; end of _switching

_main:

	CALL       _initial+0
L_main45:
	CALL       _switching+0
	GOTO       L_main45
L_end_main:
	GOTO       $+0
; end of _main
