.segment "BSS"
.import HEX_VALUE, ASCII_RESULT

.segment "RODATA"
decimal_table:
.byte 0,0,0,0,1
.byte 0,0,0,0,2
.byte 0,0,0,0,4
.byte 0,0,0,0,8
.byte 0,0,0,1,6
.byte 0,0,0,3,2
.byte 0,0,0,6,4
.byte 0,0,1,2,8
.byte 0,0,2,5,6
.byte 0,0,5,1,2
.byte 0,1,0,2,4
.byte 0,2,0,4,8
.byte 0,4,0,9,6
.byte 0,8,1,9,2
.byte 1,6,3,8,4
.byte 3,2,7,6,8

.segment "CODE"
; .export hex_to_ascii
; .proc hex_to_ascii
; ; this assumes that HEX_VALUE has already been set
; LDA #$00
; LDY #$05
; clear:
; 	DEY
; 	STA ASCII_RESULT,y
; 	BNE clear

; LDX #$4F
; loop1:
; 	CLC
; 	ROL HEX_VALUE
; 	ROL HEX_VALUE+1

; 	BCS calculate

; 	TXA
; 	SEC
; 	SBC #$05
; 	TAX

; 	BPL loop1

; 	RTS

; calculate:
; 	CLC
; 	LDY #$04
; loop2:
; 	LDA decimal_table,x
; 	ADC #$00
; 	BEQ zero
; 	ADC ASCII_RESULT,y
; 	CMP #$0a
; 	BCC notten
; 	SBC #$0A
; notten:
; 	STA ASCII_RESULT,y
; zero:
; 	DEX
; 	DEY
; 	BPL loop2

; 	JMP loop1
; .endproc

.export hex_to_ascii_8bit
.proc hex_to_ascii_8bit
; this assumes that HEX_VALUE has already been set
LDA #$00
LDY #$05
clear:
	DEY
	STA ASCII_RESULT,y
	BNE clear

LDX #$27
loop1:
	CLC
	ROL HEX_VALUE

	BCS calculate

	TXA
	SEC
	SBC #$05
	TAX

	BPL loop1

	RTS

calculate:
	CLC
	LDY #$04
loop2:
	LDA decimal_table,x
	ADC #$00
	BEQ zero
	ADC ASCII_RESULT,y
	CMP #$0a
	BCC notten
	SBC #$0A
notten:
	STA ASCII_RESULT,y
zero:
	DEX
	DEY
	BPL loop2

	JMP loop1
.endproc