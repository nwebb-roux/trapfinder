.include "maps.inc"
.include "../includes/constants.inc"
.include "../includes/ram_constants.inc"

.segment "ZEROPAGE"
.importzp indirect_address

.segment "CODE"
.export load_dungeon_map
.proc load_dungeon_map
	; load dungeon floor (0-4) into X
	LDX DUNGEON_FLOOR

	; use that as offset into floor_offsets to get part of the offset into the superpattern table
	LDA floor_offsets, X
	STA DUNGEON_FLOOR_OFFSET

	; set loop variables
	LDX DUNGEON_FLOOR_OFFSET
	LDY #$00

top_row_loop:
	; get metatile
	LDA top_row_superpatterns, X

	; write to screen map
	STA SCREEN_MAP, Y

	; write zeroes to attribute map
	; TODO GET RIGHT ATTRIBUTE
	LDA #$00
	STA SCREEN_MAP_ATTRIBUTES, Y

	; increment counters and loop if not 32 yet
	INX
	INY

	; if X is 16, reset it to 0 to run through the same top row superpattern again
	CPX #$16
	BNE @continue_top_row_loop
	LDX #$00

@continue_top_row_loop:
	CPY #$20
	BNE top_row_loop

	; save 16 to screen map location
	STY SCREEN_MAP_LOCATION

	; reset X for next loop
	LDX #$00

@mid_row_loop:
	; load random # 0-15 in A (note: also screws with Y!)
	JSR lfsr
	AND #%00001111

	; add offset for what floor we're on by looking it up in floor_offsets table
	CLC
	ADC DUNGEON_FLOOR_OFFSET

	; multiply by two because the table is a double-byte array
	ASL

	; put offset into Y
	TAY

	; load high byte of superpattern location from table
	; (stored reversed in table, i.e. high low instead of the usual low high)
	LDA superpattern_locations, Y
	STA indirect_address+1

	; load low byte
	INY
	LDA superpattern_locations, Y
	STA indirect_address

	; reset Y and COUNTER for next loop
	LDY #$00
	STY COUNTER

@metatileLoop:
	; use postindexing to load the data pointed to
	; by the superpattern location in indirect_address
	; (i.e. load the byte, or metatile, of the superpattern)
	LDA (indirect_address),Y

	; save Y to loop counter
	STY COUNTER

	; load screen map location into Y
	LDY SCREEN_MAP_LOCATION

	; write to screen map
	STA SCREEN_MAP, Y

	; increment screen map location and save (for next time through loop)
	INY
	STY SCREEN_MAP_LOCATION

	; reload counter into Y
	LDY COUNTER

	; increment Y and loop if counter isn't 16 yet (runs 16 times)
	INY
	CPY #$10
	BNE @metatileLoop

	; increment X for overall loop and loop 11 times total
	INX
	CPX #$0B
	BNE @mid_row_loop

	; reset X and Y for next loop
	;LDX #$00
	LDX DUNGEON_FLOOR_OFFSET
	LDY SCREEN_MAP_LOCATION

@bottom_row_loop:
	; get metatile
	LDA bottom_row_superpatterns, X

	; write to screen map
	STA SCREEN_MAP, Y

	; increment counters and loop until end of screen map location in Y
	INX
	INY
	CPY #$EF
	BNE @bottom_row_loop

	; make sure SCREEN_MAP_END is set to $FF
	LDA #$FF
	STA SCREEN_MAP_END

	; reset X for loop
	LDX #$00

@load_collision_data_loop:
	LDA metatile_collisions, X
	CMP #$FF
	BEQ @end_collision_load
	STA COLLISION_TABLE, X
	INX
	JMP @load_collision_data_loop

@end_collision_load:
	RTS
.endproc

.export load_dungeon_map_attributes
.proc load_dungeon_map_attributes
	; initialize counters
	LDX #$00
	STX SCREEN_MAP_LOCATION
	STX COUNTER_X
	LDY #$00
	STY COUNTER

attribute_loop:
	; reset attribute mask
	LDA #%11111100
	STA ATTRIBUTE_MASK

	; load screen map location into X
	LDX SCREEN_MAP_LOCATION

	; load metatile into A
	LDA SCREEN_MAP, X

	; if it's $FF, we're done
	CMP #$FF
	BNE ContinueAttributeLoad
	JMP DoneAttributeLoad

ContinueAttributeLoad:
	; mask out non-tile number bits from metatile
	AND #%00001111

	; move metatile number to X so we can use it as an offset
	TAX

	; load palette for this metatile into Y
	LDY metatile_palettes, X

	; load screen map location into A
	LDA SCREEN_MAP_LOCATION

	; divide screen map location by 2 and subtract COUNTER_X to get attributes map location
	LSR
	SEC
	SBC COUNTER_X

	; move it to X so we can index with it
	TAX

	; load screen map location into A
	LDA SCREEN_MAP_LOCATION

	; wipe all but lowest bit
	AND #%000000001

	; if lowest bit of screen map location is 0, column is even, skip ahead
	CMP #$00
	BEQ EvenColumn

	; if we're here, column is odd
	; shift palette number 2 bits left, filling right bits with 0
	TYA
	ASL
	ASL
	TAY

	; shift attribute mask 2 bits left, filling right bits with 1s from carry flag
	LDA ATTRIBUTE_MASK
	SEC
	ROL
	SEC
	ROL
	STA ATTRIBUTE_MASK

EvenColumn:
	; load counter into A
	LDA COUNTER

	; if counter is 0, it's an even row
	CMP #$00
	BEQ SetPalette

	; if we're here, row is odd
	; shift palette number 4 bits left, filling right bits with 0
	TYA
	ASL
	ASL
	ASL
	ASL
	TAY

	; shift attribute mask 4 bits left, filling right bits with 1s from carry flag
	LDA ATTRIBUTE_MASK
	SEC
	ROL
	SEC
	ROL
	SEC
	ROL
	SEC
	ROL
	STA ATTRIBUTE_MASK

SetPalette:
	; load current attribute byte into A
	LDA SCREEN_MAP_ATTRIBUTES, X

	; AND attribute byte with attribute mask, thus setting the palette number we want to 0
	AND ATTRIBUTE_MASK

	; transfer palette number to attribute mask
	STY ATTRIBUTE_MASK

	; OR attribute byte with palette number, thus setting the palette number we want
	; without changing the others
	ORA ATTRIBUTE_MASK

	; save new attribute byte
	STA SCREEN_MAP_ATTRIBUTES, X

	; increment SCREEN_MAP_LOCATION
	LDX SCREEN_MAP_LOCATION
	INX
	STX SCREEN_MAP_LOCATION
	
	; load screen map location into A
	LDA SCREEN_MAP_LOCATION

	; wipe all sixteens down
	AND #%00011111

	; if the wiped version equals sixteen, the new location starts an odd row
	CMP #$10
	BEQ OddRow

	; if the wiped version equals zero, the new location starts an even row
	CMP #$00
	BEQ EvenRow

	; if neither, just keep going
	JMP attribute_loop
OddRow:
	; set counter to 1 (odd row)
	LDA #$01
	STA COUNTER

	; increase COUNTER_X, which tracks the offset between screen map and attribute map rows
	LDA COUNTER_X
	CLC
	ADC #$08
	STA COUNTER_X
	
	; run loop again
	JMP attribute_loop

EvenRow:
	; set counter to 0 (even row)
	LDA #$00
	STA COUNTER

	; run loop again
	JMP attribute_loop

DoneAttributeLoad:
	; set SCREEN_MAP_ATTRIBUTES_END
	LDA #$FF
	STA SCREEN_MAP_ATTRIBUTES_END

	RTS
.endproc

.import lfsr