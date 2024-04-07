.include "maps.inc"
.include "../includes/ram_constants.inc"

.segment "ZEROPAGE"
.importzp treasure_flags, treasure_x_coords, treasure_y_coords

.segment "CODE"
.export populate_treasure
.proc populate_treasure
	; reset loop counters: X is position in screen map, Y is position in treasure pool
	LDX #$10
	LDY #$00

	; TODO: CLEAR TREASURE POOL?

TreasureLoop:
	; if treasure counter is 5 (i.e. position 6 in pool, which does not exist), we're done
	CPY #$05
	BEQ TreasureDone

	; load metatile into A
	LDA SCREEN_MAP, X

	; if SCREEN_MAP gave us $FF, we reached the end, break out
	CMP #$FF
	BEQ TreasureDone

	; get rid of high 4 bits so we just have the pattern number
	AND #%00001111

	; save treasure counter and move A to Y so we can index with it
	STY COUNTER
	TAY

	; load metatile collision data into A
	LDA COLLISION_TABLE, Y

	; load treasure count back into Y
	LDY COUNTER

	; if it's not an open space, this time through the loop is done
	CMP #$00
	BNE NextLoop

	; load random # 0-31 in A (note: also screws with Y!)
	JSR lfsr
	AND #%00011111

	; load treasure count back into Y
	LDY COUNTER

	; if it's not 0, this time through the loop is done
	; (i.e. 0 indicates we randomly place a treasure here)
	CMP #$00
	BNE NextLoop

	; move screen map counter to A
	TXA

	; mask out high nybble and multiply by 16
	; this gives us X coordinate
	AND #%00001111
	ASL
	ASL
	ASL
	ASL

	; save to treasure_x_coords
	STA treasure_x_coords, Y

	; move screen map counter to A (again)
	TXA

	; mask out low nybble
	AND #%11110000

	; save to treasure_y_coords
	STA treasure_y_coords, Y

	; load random # 0-15 in A (note: also screws with Y!) for treasure type
	JSR lfsr
	AND #%00001111

	; set closed flag to 1 (true)
	ORA #%10000000

	; TODO generate random 0-1 and put it in bit 1 to represent trap yes/no
	; TODO if trap, generate random 0-7 and put it in bits 2 and 3--trap type
	; TODO use dungeon floor and trap presence/type to alter random treasure roll

	; load treasure count back into Y
	LDY COUNTER

	; save treasure flag byte to treasure_flags
	STA treasure_flags, Y

	; increment treasure count
	INY

NextLoop:
	; increment screen map counter and go to start of loop
	INX
	JMP TreasureLoop

TreasureDone:
	RTS
.endproc

.import lfsr