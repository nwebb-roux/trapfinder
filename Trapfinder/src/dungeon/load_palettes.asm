.include "palettes.inc"
.include "maps.inc"
.include "../includes/constants.inc"

.segment "BSS"
.import DUNGEON_ZONE

.segment "CODE"
.export load_dungeon_palettes
.proc load_dungeon_palettes
	LDA PPUSTATUS
	LDA #$3F
	STA PPUADDR
	LDA #$00
	STA PPUADDR

	LDY DUNGEON_ZONE
	LDX floor_offsets, Y
LoadBGPaletteLoop:
	LDA dungeon_palettes, X
    STA PPUDATA
    INX
	TXA
	AND #%00001111
    CMP #$00
    BNE LoadBGPaletteLoop

    LDX floor_offsets, Y
LoadSpritePaletteLoop:
    LDA sprite_palettes, X
    STA PPUDATA
    INX
    TXA
	AND #%00001111
    CMP #$00
    BNE LoadSpritePaletteLoop

    RTS
.endproc