.include "maps.inc"
.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp indirect_address, indirect_address_2

.segment "BSS"
.import DUNGEON_FLOOR, DUNGEON_FLOOR_OFFSET, SCREEN_MAP, SCREEN_MAP_ATTRIBUTES, SCREEN_MAP_ATTRIBUTES_END, ATTRIBUTE_MASK, COUNTER, SCRATCH_B, SCREEN_MAP_LOCATION, COLLISION_TABLE, SCREEN_MAP_END, CURRENT_DECODE_VALUE, CURRENT_DECODE_LENGTH, METATILES_DECODED, CURRENT_DECODE_BYTE, SCRATCH_C, SCRATCH_D

.segment "CODE"
.proc check_current_codeword
	; X: current codeword length
	; if length is 2, return immediately (there are no codewords of length 2)
	CPX #$02
	BEQ check_done

	; load max value at the current length into Y
	LDY max_value_per_length, X

	; compare length max in Y to CURRENT_DECODE_VALUE
	CPY CURRENT_DECODE_VALUE

	; if length max is less than CURRENT_DECODE_VALUE (carry clear), not a codeword, return
	BCC check_done

	; if we're here, we have a codeword

	; subtract CURRENT_DECODE_VALUE from length max and store result in Y 
	TYA
	SEC
	SBC CURRENT_DECODE_VALUE
	TAY

	; double the value in X because we're about to use it to index into a double byte array
	TXA
	ASL
	TAX

	; load high byte of sorted_alphabet sub-array location from table
	; (stored reversed in table, i.e. high low instead of the usual low high)
	LDA sorted_alphabet_locations, X
	STA indirect_address_2+1

	; load low byte
	INX
	LDA sorted_alphabet_locations, X
	STA indirect_address_2

	; use postindexing to load the data pointed to
	; by the sub-array location in indirect_address
	; (i.e. load the decoded alphabet symbol from the sub-array of the correct length)
	; (this ultimately gives us sorted_alphabet[length][max-current])
	LDA (indirect_address_2),Y

	; load screen map location into Y
	LDY SCREEN_MAP_LOCATION

	; write to screen map
	STA SCREEN_MAP, Y

	; increment screen map location and save (for next time)
	INY
	STY SCREEN_MAP_LOCATION

	; increment METATILES_DECODED and save
	LDY METATILES_DECODED
	INY
	STY METATILES_DECODED

	; reset CURRENT_DECODE_VALUE and length
	LDX #$00
	STX CURRENT_DECODE_VALUE
	STX CURRENT_DECODE_LENGTH
check_done:
	RTS
.endproc

.proc decompress_byte
	; initialize bit counter
	LDY #$00
bit_shift_loop:
	; load byte being stripped into A
	LDA CURRENT_DECODE_BYTE

	; take the leftmost bit of A and push it onto the end of CURRENT_DECODE_VALUE
	ASL
	ROL CURRENT_DECODE_VALUE

	; store changed version of byte being stripped
	STA CURRENT_DECODE_BYTE

	; increment and store bit counter
	INY
	STY COUNTER

	; increment CURRENT_DECODE_LENGTH
	LDX CURRENT_DECODE_LENGTH
	INX
	STX CURRENT_DECODE_LENGTH

	; check if CURRENT_DECODE_VALUE is a valid codeword
	; and decode it into SCREEN_MAP if so
	JSR check_current_codeword

	; if METATILES_DECODED is 32, or 16 and the second-pass flag is false, we're done
	LDY METATILES_DECODED
	CPY #$10
	BNE check_if_32

	LDY SCRATCH_D
	CPY #$00
	BEQ bit_shift_done
check_if_32:
	CPY #$20
	BEQ bit_shift_done
	
	; reload bit counter
	LDY COUNTER

	; if bit counter is not 8, there's more of the byte left, keep looping
	CPY #$08
	BNE bit_shift_loop
	
	; if we're here, bit counter is 8 and we shifted every bit of the byte, we're done
bit_shift_done:
	RTS
.endproc

.export load_dungeon_map
.proc load_dungeon_map
	; load dungeon floor (0-4) into X
	LDX DUNGEON_FLOOR

	; use that as offset into top_and_bottom_superpattern_offsets_by_floor
	; to get the offset into the top row superpattern table
	LDA top_and_bottom_superpattern_offsets_by_floor, X
	STA DUNGEON_FLOOR_OFFSET

	; set loop variables
	;LDX DUNGEON_FLOOR_OFFSET
	TAX
	LDY #$00
	STY SCREEN_MAP_LOCATION

	; initialize decompression variables to 0
	STY CURRENT_DECODE_VALUE
	STY CURRENT_DECODE_LENGTH
	STY METATILES_DECODED
	STY SCRATCH_D ; flag for whether we're drawing the second top row (0 no, 1 yes)

top_row_loop:
	; get compressed byte
	LDA top_row_superpatterns, X
	STA CURRENT_DECODE_BYTE

	; save offset value in X
	STX SCRATCH_B

	; decompress byte
	JSR decompress_byte

	; if we're here, either we decompressed all 16 metatiles or we finished the current byte and need to load the next

	LDY METATILES_DECODED
	; if METATILES_DECODED is 32, we're done with the top rows
	CPY #$20
	BEQ done_with_top

	; if we're here, we still have more metatiles to decode

	; if METATILES_DECODED is 16, reset X and set second-time flag before continuing
	; so we can start from the beginning of the top row map data again
	; (we draw the entire top row twice)
	CPY #$10
	BNE next_byte_and_loop
	
	LDX DUNGEON_FLOOR_OFFSET
	STX SCRATCH_B

	LDY #$01
	STY SCRATCH_D

	JMP top_row_loop

next_byte_and_loop:
	; reload offset counter in X and increment
	LDX SCRATCH_B
	INX

	; loop again
	JMP top_row_loop

done_with_top:
	; save 32 to screen map location
	STY SCREEN_MAP_LOCATION

	; load dungeon floor (0-4) into X
	LDX DUNGEON_FLOOR

	; use that as offset into floor_offsets to get part of the offset into the superpattern table
	LDA floor_offsets, X
	STA DUNGEON_FLOOR_OFFSET

	; reset X (row counter) for next loop and second-pass flag
	LDX #$00
	STX SCRATCH_B
	STX SCRATCH_D

mid_row_loop:
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
	STY SCRATCH_C
	STY CURRENT_DECODE_VALUE
	STY CURRENT_DECODE_LENGTH
	STY METATILES_DECODED

@metatileLoop:
	; use postindexing to load the data pointed to
	; by the superpattern table location in indirect_address
	; (i.e. load the next byte of compressed data from the superpatterns table)
	LDA (indirect_address),Y
	STA CURRENT_DECODE_BYTE

	; save Y (offset counter)
	STY SCRATCH_C

	; decompress the byte
	JSR decompress_byte

	; if we're here, either we decompressed all 16 metatiles or we finished the current byte and need to load the next

	; if METATILES_DECODED is 16, we're done
	LDY METATILES_DECODED
	CPY #$10
	BEQ done_with_row
	
	; if we're here, we still have more metatiles to decode

	; reload offset counter in Y and increment
	LDY SCRATCH_C
	INY

	; loop again
	JMP @metatileLoop

done_with_row:
	; increment row counter
	LDX SCRATCH_B
	INX
	STX SCRATCH_B

	; if less than 11, do another row
	CPX #$0B
	BNE mid_row_loop

	; reset X and Y for next loop
	LDX DUNGEON_FLOOR_OFFSET
	LDY SCREEN_MAP_LOCATION

bottom_row_loop:
	; get metatile
	LDA bottom_row_superpatterns, X

	; write to screen map
	STA SCREEN_MAP, Y

	; increment counters and loop until end of screen map location in Y
	INX
	INY

	; if Y is 224, reset X to run through the same bottom row superpattern again
	CPY #$E0
	BNE @continue_bottom_row_loop
	LDX DUNGEON_FLOOR_OFFSET

@continue_bottom_row_loop:
	; loop until screen map location is 240
	CPY #$F0
	BNE bottom_row_loop

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
	STX SCRATCH_B
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

	; divide screen map location by 2 and subtract SCRATCH_B to get attributes map location
	LSR
	SEC
	SBC SCRATCH_B

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

	; increase SCRATCH_B, which tracks the offset between screen map and attribute map rows
	LDA SCRATCH_B
	CLC
	ADC #$08
	STA SCRATCH_B
	
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