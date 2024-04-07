.include "sprite_data.inc"

.segment "ZEROPAGE"
.importzp avatar_tile_location, avatar_x, avatar_y, avatar_sprite_attributes

.segment "CODE"
.export load_title_screen_jewel_sprite
.proc load_title_screen_jewel_sprite
	; first, store the first sprite's second attribute (assumed to be jewel sprite's tile location) in a ZP variable
	LDX #$01
	LDA title_screen_jewel, X
	STA avatar_tile_location

	LDX #$02
	LDA title_screen_jewel, X
	STA avatar_sprite_attributes

	; initialize loop counter to 0 - this will run four times
    LDX #$00
load_sprite_loop:
    ; load data from address (title_screen_jewel + X) into A
    LDA title_screen_jewel, x
    ; store into RAM address ($0200 + X)
    STA $0200, x
    ; increment X
    INX
    ; Compare X to hex $04, decimal 4
    CPX #$04
    ; Branch back to load_sprite_loop if compare was Not Equal to zero
    BNE load_sprite_loop

	; set starting location of jewel
	LDA #$61					; X value for the jewel
	PHA
	LDA #$AB					; Y value for the jewel
	PHA
	JSR set_jewel_location
	PLA
	PLA

	RTS
.endproc

.export set_jewel_location
.proc set_jewel_location
	TSX				; transfer stack pointer to X
	LDA $0104,X		; load contents at stack address X + 4 into A, this is the X position of the player
    STA avatar_x
	LDA $0103,X		; load contents at stack address X + 3 into A, this is the Y position of the player
    STA avatar_y

    RTS
.endproc

.export increment_jewel_palette
.proc increment_jewel_palette
	; get jewel attributes from ZP
	LDX avatar_sprite_attributes

	; copy to A
	TXA

	; wipe the current palette number
	AND #%11111100

	; write back to ZP
	STA avatar_sprite_attributes

	; add 1 to increase palette number in X (we'll deal with the overflow momentarily)
	INX

	; copy to A
	TXA

	; AND the value so we get 000000xx, where xx is the new palette number
	AND #%00000011

	; OR it with original attributes, so we get same original attributes but new palette number
	ORA avatar_sprite_attributes

	; write that to ZP
	STA avatar_sprite_attributes

	RTS
.endproc

.export title_screen_draw_jewel_sprite
.proc title_screen_draw_jewel_sprite
    ; **** top left tile (x, y) ****
	; write Y
    LDA avatar_y
    STA $0200

	; write X
    LDA avatar_x
    STA $0203

	; write tile location
	LDX avatar_tile_location
	STX $0201

	; write sprite attributes
	LDY avatar_sprite_attributes
	STY $0202
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA avatar_y
    STA $0204

	; write X
    LDA avatar_x

	; add 8 to X and write
    CLC
    ADC #$08
    STA $0207

	; increment tile location and write
	INX
	STX $0205

	; write sprite attributes
	STY $0206

    ; **** bottom left tile (x, y + 8) ****
	; add 8 to Y and write
    LDA avatar_y
    CLC
    ADC #$08
    STA $0208

	; write X (the original, not the +8 version)
    LDA avatar_x
    STA $020B

	; increment tile location and write
	INX
	STX $0209

	; write sprite attributes
	STY $020A

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA avatar_y
    CLC
    ADC #$08
    STA $020C

	; add 8 to X and write
    LDA avatar_x
    CLC
    ADC #$08
    STA $020F

	; increment tile location and write
	INX
	STX $020D

	; write sprite attributes
	STY $020E

    RTS
.endproc