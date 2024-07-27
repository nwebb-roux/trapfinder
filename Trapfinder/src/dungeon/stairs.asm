.include "maps.inc"
.include "status_bar.inc"
.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp avatar_x, avatar_y

.segment "BSS"
.import DUNGEON_ZONE, DUNGEON_LEVEL_ONES, DUNGEON_LEVEL_TENS

.segment "CODE"
.export dungeon_draw_stairs_up
.proc dungeon_draw_stairs_up
    ; **** top left tile (x, y) ****
	; write Y
    LDA #STAIRS_UP_Y
    STA $02E0

	; write X
    LDA #STAIRS_UP_X
    STA $02E3

	; write tile location
	LDX #$50
	STX $02E1

	; write sprite attributes
	LDY #%00000011
	STY $02E2
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA #STAIRS_UP_Y
    STA $02E4

	; add 8 to X and write
    LDA #STAIRS_UP_X
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
    LDA #STAIRS_UP_Y
    CLC
    ADC #$08
    STA $02E8

	; write X (the original, not the +8 version)
    LDA #STAIRS_UP_X
    STA $02EB

	; increment tile location and write
	INX
	STX $02E9

	; write sprite attributes
	STY $02EA

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA #STAIRS_UP_Y
    CLC
    ADC #$08
    STA $02EC

	; add 8 to X and write
    LDA #STAIRS_UP_X
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
	; if we're on level 25 (last level of underworld)
	; don't draw stairs down
	LDA DUNGEON_LEVEL_TENS
	CMP #$02
	BNE draw_them
	LDA DUNGEON_LEVEL_ONES
	CMP #$05
	BNE draw_them

	RTS

draw_them:
    ; **** top left tile (x, y) ****
	; write Y
    LDA #STAIRS_DOWN_Y
    STA $02F0

	; write X
    LDA #STAIRS_DOWN_X
    STA $02F3

	; write tile location
	LDX #$54
	STX $02F1

	; write sprite attributes
	LDY #%00000011
	STY $02F2
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA #STAIRS_DOWN_Y
    STA $02F4

	; write X
    LDA #STAIRS_DOWN_X

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
    LDA #STAIRS_DOWN_Y
    CLC
    ADC #$08
    STA $02F8

	; write X (the original, not the +8 version)
    LDA #STAIRS_DOWN_X
    STA $02FB

	; increment tile location and write
	INX
	STX $02F9

	; write sprite attributes
	STY $02FA

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA #STAIRS_DOWN_Y
    CLC
    ADC #$08
    STA $02FC

	; add 8 to X and write
    LDA #STAIRS_DOWN_X
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

.export check_stairs_up_collision
.proc check_stairs_up_collision
	LDA avatar_x
	CLC
	ADC #$10
	CMP #STAIRS_UP_X
	BCC @noCollide
	LDA #STAIRS_UP_X
	CLC
	ADC #$10
	CMP avatar_x
	BCC @noCollide
	LDA avatar_y
	CLC
	ADC #$10
	CMP #STAIRS_UP_Y
	BCC @noCollide
	LDA #STAIRS_UP_Y
	CLC
	ADC #$10
	CMP avatar_y
	BCC @noCollide

	; collision occurred, go to title screen
	JSR load_title_screen

	; set carry flag for check on return
	SEC
	RTS
@noCollide:
	; clear carry flag for check on return
	CLC
	RTS
.endproc

.export check_stairs_down_collision
.proc check_stairs_down_collision
	; if we're on level 25 (last level of underworld)
	; don't collide
	LDA DUNGEON_LEVEL_TENS
	CMP #$02
	BNE do_check
	LDA DUNGEON_LEVEL_ONES
	CMP #$05
	BNE do_check

	RTS

do_check:
	; if right side of avatar is less than STAIRS_DOWN_X, no collide
	LDA avatar_x
	CLC
	ADC #$0D
	CMP #STAIRS_DOWN_X
	BCC @noCollide

	; if right side of stairs is less than avatar x, no collide
	LDA #STAIRS_DOWN_X
	CLC
	ADC #$0F
	CMP avatar_x
	BCC @noCollide

	; if bottom of avatar is less than STAIRS_DOWN_Y, no collide
	LDA avatar_y
	CLC
	ADC #$10
	CMP #STAIRS_DOWN_Y
	BCC @noCollide

	; if bottom of stairs is less than avatar y, no collide
	LDA #STAIRS_DOWN_Y
	CLC
	ADC #$10
	CMP avatar_y
	BCC @noCollide

	; collision occurred
	JSR handle_stairs_down_collision

	; set carry flag for check on return
	SEC
	RTS
@noCollide:
	; clear carry flag for check on return
	CLC
	RTS
.endproc

.export handle_stairs_down_collision
.proc handle_stairs_down_collision
	; increment dungeon level/zone
	JSR increment_dungeon_level

	; check if we're on the first level of a new zone
	LDX DUNGEON_LEVEL_ONES
	CPX #$01
	BEQ show_dialogue
	CPX #$06
	BEQ show_dialogue

	; if not, go directly to next dungeon screen
	JSR load_dungeon_screen
	RTS

show_dialogue:
	JSR load_dialogue_screen
	RTS
.endproc

.export increment_dungeon_level
.proc increment_dungeon_level
	; load and increment dungeon level ones place
	; (remember these vars are zero-indexed)
	LDX DUNGEON_LEVEL_ONES
	INX
	STX DUNGEON_LEVEL_ONES

	; if we hit 1 or 6 in the ones place, increment zone
	CPX #$01
	BEQ increment_zone
	CPX #$06
	BEQ increment_zone

	; if we hit 10 in the ones place, increment tens place instead
	CPX #$0A
	BEQ increment_tens

	; no need to increment zone or tens, we're done
	RTS
increment_tens:
	LDX #$00
	STX DUNGEON_LEVEL_ONES
	LDX DUNGEON_LEVEL_TENS
	INX
	STX DUNGEON_LEVEL_TENS

	RTS
increment_zone:
	LDX DUNGEON_ZONE
	INX
	STX DUNGEON_ZONE

	RTS
.endproc

.import load_title_screen
.import load_dialogue_screen
.import load_dungeon_screen