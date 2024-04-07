.include "sprite_data.inc"

.import main
.segment "ZEROPAGE"
.importzp avatar_x, avatar_y, avatar_tile_location, avatar_sprite_attributes, player_sprite_facing, player_sprite_frame

.segment "CODE"
.export load_avatar_sprite
.proc load_avatar_sprite
	LDA #$01
	STA player_sprite_facing
	LDA #$01
	STA player_sprite_frame

	; set avatar sprite attributes
	LDA #$00
	STA avatar_sprite_attributes
	
	JSR dungeon_update_avatar_sprite

	LDA #$00	; starting X
	PHA
	LDA #$CF	; starting Y
	PHA
	JSR set_player_location
	PLA
	PLA

    RTS
.endproc

.export dungeon_increment_avatar_sprite_frame
.proc dungeon_increment_avatar_sprite_frame
	LDX player_sprite_frame
	INX
	CPX #$14
	BNE NotTwenty
	LDX #$00
NotTwenty:
	STX player_sprite_frame
	RTS
.endproc

.export dungeon_update_avatar_sprite
.proc dungeon_update_avatar_sprite
	LDX player_sprite_frame
	LDY player_sprite_facing
CheckUp:
	CPY #$00
	BNE CheckDown
	LDA walk_up_tiles, X
	JMP SetPlayerTile
CheckDown:
	CPY #$01
	BNE CheckLeft
	LDA walk_down_tiles, X
	JMP SetPlayerTile
CheckLeft:
	CPY #$02
	BNE SetRight
	LDA walk_left_tiles, X
	JMP SetPlayerTile
SetRight:
	LDA walk_right_tiles, X
SetPlayerTile:
	STA avatar_tile_location
    RTS
.endproc

.export dungeon_draw_avatar_sprite
.proc dungeon_draw_avatar_sprite
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

.export set_player_location
.proc set_player_location
	TSX				; transfer stack pointer to X
	LDA $0104,X		; load contents at stack address X + 4 into A, this is the X position of the player
    STA avatar_x
	LDA $0103,X		; load contents at stack address X + 3 into A, this is the Y position of the player
    STA avatar_y

    RTS
.endproc

	; set horizontal flip without changing any other bits
	;LDA avatar_sprite_attributes
	;ORA #%01000000
	;STA avatar_sprite_attributes

	; remove horizontal flip without changing any other bits
	;LDA avatar_sprite_attributes
	;AND #%10111111
	;STA avatar_sprite_attributes