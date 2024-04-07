.include "maps.inc"
.include "../includes/constants.inc"
.include "../includes/ram_constants.inc"

.segment "CODE"
.export draw_dungeon_background
.proc draw_dungeon_background
	; set nametable address in PPU
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$00
	STA PPUADDR

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
	LDY DUNGEON_FLOOR
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

@loop:
	LDA SCREEN_MAP_ATTRIBUTES, X
	CMP #$FF
	BEQ Done
	STA PPUDATA
	INX
	JMP @loop

Done:
	RTS
.endproc

.export dungeon_draw_stairs_up
.proc dungeon_draw_stairs_up
    ; **** top left tile (x, y) ****
	; write Y
    LDA #$D0
    STA $02E0

	; write X
    LDA #$00
    STA $02E3

	; write tile location
	LDX #$50
	STX $02E1

	; write sprite attributes
	LDY #%00000011
	STY $02E2
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA #$D0
    STA $02E4

	; write X
    LDA #$00

	; add 8 to X and write
    CLC
    ADC #$08
    STA $02E7

	; increment tile location and write
	INX
	STX $02E5

	; write sprite attributes
	STY $02E6

    ; **** bottom left tile (x, y + 8) ****
	; add 8 to Y and write
    LDA #$D0
    CLC
    ADC #$08
    STA $02E8

	; write X (the original, not the +8 version)
    LDA #$00
    STA $02EB

	; increment tile location and write
	INX
	STX $02E9

	; write sprite attributes
	STY $02EA

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA #$D0
    CLC
    ADC #$08
    STA $02EC

	; add 8 to X and write
    LDA #$00
    CLC
    ADC #$08
    STA $02EF

	; increment tile location and write
	INX
	STX $02ED

	; write sprite attributes
	STY $02EE

    RTS
.endproc

.export dungeon_draw_stairs_down
.proc dungeon_draw_stairs_down
    ; **** top left tile (x, y) ****
	; write Y
    LDA #$00
    STA $02F0

	; write X
    LDA #$F0
    STA $02F3

	; write tile location
	LDX #$54
	STX $02F1

	; write sprite attributes
	LDY #%00000011
	STY $02F2
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA #$00
    STA $02F4

	; write X
    LDA #$F0

	; add 8 to X and write
    CLC
    ADC #$08
    STA $02F7

	; increment tile location and write
	INX
	STX $02F5

	; write sprite attributes
	STY $02F6

    ; **** bottom left tile (x, y + 8) ****
	; add 8 to Y and write
    LDA #$00
    CLC
    ADC #$08
    STA $02F8

	; write X (the original, not the +8 version)
    LDA #$F0
    STA $02FB

	; increment tile location and write
	INX
	STX $02F9

	; write sprite attributes
	STY $02FA

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA #$00
    CLC
    ADC #$08
    STA $02FC

	; add 8 to X and write
    LDA #$F0
    CLC
    ADC #$08
    STA $02FF

	; increment tile location and write
	INX
	STX $02FD

	; write sprite attributes
	STY $02FE

    RTS
.endproc