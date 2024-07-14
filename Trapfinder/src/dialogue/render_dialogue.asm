.include "dialogue.inc"
.include "digrams.inc"
.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp indirect_address

.segment "BSS"
.import DUNGEON_FLOOR, COUNTER, SCRATCH_B, SCRATCH_C

.segment "CODE"
.export init_background
.proc init_background
	; this subroutine draws a blank black background
	; TODO maybe we want to make this accessible from everywhere in the code

	; set target address in PPU - the top left nametable
	; first, read PPUSTATUS to clear the PPU's address latch so we know we're doing a clean write
	LDA PPUSTATUS

	; then write high byte of the target address
	LDA #$20
	STA PPUADDR

	; then low byte
	LDA #$00
	STA PPUADDR

	; write 960 bytes of $01 to PPUDATA (remember, PPUDATA auto-increments after each write)
	LDA #$01

	LDX #$00
loop_1:
	STA PPUDATA
	INX
	CPX #$00
	BNE loop_1

	LDX #$00
loop_2:
	STA PPUDATA
	INX
	CPX #$00
	BNE loop_2

	LDX #$00
loop_3:
	STA PPUDATA
	INX
	CPX #$00
	BNE loop_3

	LDX #$00
loop_4:
	STA PPUDATA
	INX
	CPX #$C0
	BNE loop_4

	; write 64 bytes of attribute data, for now we'll just set everything to attribute 0
	LDA #$00

	LDX #$00
attribute_loop:
	STA PPUDATA
	INX
	CPX #$40
	BNE attribute_loop

	RTS
.endproc

.proc draw_letter
	; letter must be in A when we jump here

	; if A holds the newline symbol ($5E) go to a newline
	CMP #$5E
	BEQ do_newline

	; if not, draw a single letter and return
	STA PPUDATA

	RTS

do_newline:
	; reset PPU address latch
	LDA PPUSTATUS

	; set PPU address high byte
	LDA SCRATCH_C
	STA PPUADDR

	; get current line number
	LDA SCRATCH_B

	; increment it
	CLC
	ADC #$01

	; store new value
	STA SCRATCH_B

	; multiply it by 32
	ASL
	ASL
	ASL
	ASL
	ASL

	; set PPU address low byte
	STA PPUADDR

	RTS
.endproc

.export render_dialogue
.proc render_dialogue
	; set which quarter of the screen the dialogue is in (top 20, upper mid 21, lower mid 22, bottom 23)
	LDA #$21
	STA SCRATCH_C

	; set starting line of dialogue - this number gets multiplied by 32 to become low byte of PPUADDR
	LDA #$00
	STA SCRATCH_B

	; set nametable address in PPU
	LDA PPUSTATUS

	LDA SCRATCH_C
	STA PPUADDR
	LDA SCRATCH_B
	STA PPUADDR

	; load dungeon floor and double it to make it an index into the dialogue_locations lookup table
	LDA DUNGEON_FLOOR
	ASL
	TAX

	; load high byte of this floor's dialogue location and store in ZP var
	; (it's stored reversed in dialogue_locations table, i.e. high-low instead of the usual low-high,
	; so we store this byte in the second byte of the ZP var)
	LDA dialogue_locations, X
	STA indirect_address+1

	; load low byte and store
	INX
	LDA dialogue_locations, X
	STA indirect_address

	; set Y for loop
	LDY #$00

write_words_loop:
	; with the magic of postindexing, we load the next encoded symbol of dialogue into A
	; (i.e. we get it from the location stored in indirect_address, plus Y)
	LDA (indirect_address),Y

	; if bit 7 of the encoded symbol is 1, it's an encoded digram
	; and the negative flag will have been set by the LDA above
	; so BMI (Branch if MInus) will trigger only for encoded digrams
	BMI decode_digram

	; if A holds the end symbol ($7F, aka 127), we're done
	CMP #$7F
	BEQ done_rendering

	; if not, draw whatever's in A
	JSR draw_letter

	; increment Y and loop
	INY
	JMP write_words_loop

decode_digram:
	; shift the digram code left - this doubles the lower seven bits while dropping the leftmost
	; bit, resulting in an index to the digram table
	ASL

	; now pass the digram code to X
	TAX

	; use it as an offset to the digram table to get the first character
	LDA digrams,X

	; draw the character
	JSR draw_letter

	; and the second
	INX
	LDA digrams,X

	JSR draw_letter

	; increment Y and loop
	INY
	JMP write_words_loop

done_rendering:
	RTS
.endproc