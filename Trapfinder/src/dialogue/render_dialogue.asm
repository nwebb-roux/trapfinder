.include "dialogue.inc"
.include "digrams.inc"
.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp indirect_address

.segment "BSS"
.import DUNGEON_FLOOR, COUNTER

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

.export render_dialogue
.proc render_dialogue
	; set nametable address in PPU
	LDA PPUSTATUS

	LDA #$20
	STA PPUADDR
	LDA #$00
	STA PPUADDR

	LDX DUNGEON_FLOOR

	; load high byte of this floor's dialogue location and store in ZP var
	; (it's stored reversed in dialogue_locations table, i.e. high-low instead of the usual low-high,
	; so we store this byte in the second byte of the ZP var)
	LDA dialogue_locations, X
	STA indirect_address+1

	; load low byte and store
	INX
	LDA dialogue_locations, X
	STA indirect_address

	; set Y for loop, X will be our junk var
	LDY #$00

write_words_loop:
	; with the magic of postindexing, we load the next encoded symbol of dialogue into A
	; (i.e. we get it from the location stored in indirect_address, plus X)
	LDA (indirect_address),Y

	; if bit 7 of the encoded symbol is 1, it's an encoded digram
	; and the negative flag will have been set by the LDA above
	; so BMI (Branch if MInus) will trigger only for encoded digrams
	BMI decode_digram

	; if A holds the end symbol ($7F, aka 127), we're done
	CMP #$7F
	BEQ done_rendering

	; if not, draw a single letter
	STA PPUDATA

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
	STA PPUDATA

	; and the second
	INX
	LDA digrams,X
	STA PPUDATA

	; increment Y and loop
	INY
	JMP write_words_loop

done_rendering:
	RTS
.endproc