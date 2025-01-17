.include "maps.inc"
.include "status_bar.inc"
.include "../includes/constants.inc"

.segment "BSS"
.import DUNGEON_ZONE, DUNGEON_LEVEL_ONES, DUNGEON_LEVEL_TENS, SCREEN_MAP, SCREEN_MAP_ATTRIBUTES, SCREEN_MAP_SECOND_PASS, COUNTER, ASCII_RESULT, GOLD_PIECES, HEX_VALUE

.segment "CODE"
.proc draw_status_bar
	; set nametable address in PPU
	; first, read PPUSTATUS to clear the PPU's address latch so we know we're doing a clean write
	LDA PPUSTATUS

	; then write high byte of the target address
	LDA #$20
	STA PPUADDR

	; then low byte
	LDA #$00
	STA PPUADDR

	; init status bar loop vars
	LDA #$FF
	LDX #$00

	; draw two rows and two more tiles of black
empty_bar_loop:
	STA PPUDATA
	INX
	CPX #$42
	BNE empty_bar_loop

	; draw the word "Zone:"
	LDA #$BC
	STA PPUDATA
	LDA #$BD
	STA PPUDATA
	LDA #$BE
	STA PPUDATA
	LDA #$BF
	STA PPUDATA
	LDA #$FA
	STA PPUDATA

	; draw the zone number
	LDX DUNGEON_ZONE
	LDA zero_indexed_number_tiles+1, X
	STA PPUDATA

	; draw twelve tiles of black
	LDA #$FF
	LDX #$00

twelve_loop:
	STA PPUDATA
	INX
	CPX #$0C
	BNE twelve_loop

	; draw the word "GP:"
	LDA #$FB
	STA PPUDATA
	LDA #$FC
	STA PPUDATA
	LDA #$FA
	STA PPUDATA

	; draw GP count
	LDA GOLD_PIECES
    STA HEX_VALUE

	JSR hex_to_ascii_8bit

    LDX #$00

draw_digit_loop:
    LDY ASCII_RESULT, X
    LDA zero_indexed_number_tiles, Y

    STA PPUDATA

    INX
    CPX #$05
    BNE draw_digit_loop

	LDA zero_indexed_number_tiles
	STA PPUDATA
	STA PPUDATA

	; fill rest of row with black and draw two more black tiles
	LDA #$FF
	LDX #$00

post_gp_loop:
	STA PPUDATA
	INX
	CPX #$04
	BNE post_gp_loop

	; draw word "Level:"
	LDA #$CC
	STA PPUDATA
	LDA #$BF
	STA PPUDATA
	LDA #$CD
	STA PPUDATA
	LDA #$BF
	STA PPUDATA
	LDA #$CE
	STA PPUDATA
	LDA #$FA
	STA PPUDATA

	; draw the level number
	LDX DUNGEON_LEVEL_TENS
	LDA zero_indexed_number_tiles, X
	STA PPUDATA
	LDX DUNGEON_LEVEL_ONES
	LDA zero_indexed_number_tiles, X
	STA PPUDATA

	; draw ten black tiles
	LDA #$FF
	LDX #$00

ten_loop:
	STA PPUDATA
	INX
	CPX #$0A
	BNE ten_loop

	; draw hearts (hardcoded three hearts now)
	LDA #$FD
	LDX #$00

heart_loop:
	STA PPUDATA
	INX
	CPX #$03
	BNE heart_loop

	; draw nine black tiles
	LDA #$FF
	LDX #$00

nine_loop:
	STA PPUDATA
	INX
	CPX #$09
	BNE nine_loop

	RTS
.endproc

.export draw_dungeon_background
.proc draw_dungeon_background
	JSR draw_status_bar

	; reset X and COUNTER for looping
	LDX #$00
	STX COUNTER

@double_loop:
	; turn SCREEN_MAP_SECOND_PASS flag off
	LDA #$00
	STA SCREEN_MAP_SECOND_PASS

@line_loop:
	; load metatile into A
	LDA SCREEN_MAP, X

	; if SCREEN_MAP gave us $FF, we reached the end, break out
	CMP #$FF
	BEQ @map_done

	; get rid of high 4 bits so we just have the pattern number
	AND #%00001111

	; copy to Y so we can index with it
	TAY

	; load lop left sprite of this metatile into A
	LDA metatile_sprites, Y

	; add dungeon floor offset
	LDY DUNGEON_ZONE
	CLC
	ADC floor_tile_offsets, Y

	; if we're on the second pass through this row, add 2 to the sprite location
	LDY SCREEN_MAP_SECOND_PASS
	CPY #$00
	BEQ @draw_tiles

	CLC
	ADC #$02

@draw_tiles:
	; write first sprite to PPU
	STA PPUDATA

	; move to next sprite and write to PPU
	CLC
	ADC #$01
	STA PPUDATA

	; increment metatile counter
	INX

	; increment 0-15 loop counter (counting metatiles of this row)
	LDY COUNTER
	INY
	STY COUNTER

	; loop again if counter isn't 16 yet
	CPY #$10
	BNE @line_loop

	; reset metatile loop counter to 0
	LDY #$00
	STY COUNTER

	; check SCREEN_MAP_SECOND_PASS flag
	LDA SCREEN_MAP_SECOND_PASS
	CMP #$00
	BEQ @end_first_pass

	JMP @double_loop

@end_first_pass:
	; if we're here, SCREEN_MAP_SECOND_PASS flag was off
	; turn it on
	LDA #$01
	STA SCREEN_MAP_SECOND_PASS

	; subtract 16 from metatile counter in X to bring us back to the first metatile in the line
	TXA
	SEC
	SBC #$10
	TAX

	; run the loop again
	JMP @line_loop

@map_done:
	RTS
.endproc

.export draw_dungeon_attributes
.proc draw_dungeon_attributes
	; this must be run directly after draw_dungeon_map,
	; as it assumes PPUADDR is pointed to the attribute part
	; (i.e. we just finished drawing the map part)
	LDX #$00
	LDA #%11111111

bar_loop:
	STA PPUDATA
	INX
	CPX #$08
	BNE bar_loop

	LDX #$00

loop:
	LDA SCREEN_MAP_ATTRIBUTES, X
	CMP #$FF
	BEQ Done
	STA PPUDATA
	INX
	JMP loop

Done:
	RTS
.endproc

.import hex_to_ascii_8bit
.import dungeon_draw_stairs_down
.import dungeon_draw_stairs_up