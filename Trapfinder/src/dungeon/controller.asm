.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp buttons, new_buttons, avatar_x, avatar_y, player_sprite_facing

.segment "BSS"
.import DUNGEON_LEVEL_ONES, DUNGEON_LEVEL_TENS, DUNGEON_ZONE, COUNTER

.segment "CODE"
.export dungeon_handle_controller
.proc dungeon_handle_controller
CheckA:
	LDA new_buttons		; load contents of controller 1 button variable into A
	AND #BTN_A		; perform logical & of A (the register) against A (the button)
	BEQ CheckB		; branch to CheckB if A was not pressed, otherwise continue to A press instructions
	JSR check_treasure_collisions
	JSR check_stairs_up_collision
	; if carry is set, we did stairs up, so we're done
	BCS HandleControllerDone
	JSR check_stairs_down_collision
	; if carry is clear, we didn't do stairs down, so move to next button check
	BCC CheckB
	; otherwise, we did stairs down, so we're done
	JMP HandleControllerDone
CheckB:
	LDA buttons
	AND #BTN_B
	BEQ CheckSelect
	; add instructions here to do something when button is pressed
CheckSelect:
	LDA buttons
    AND #BTN_SELECT
    BEQ CheckStart
	; add instructions here to do something when button is pressed
CheckStart:
	LDA new_buttons
    AND #BTN_START
    BEQ CheckUp
	; add instructions here to do something when button is pressed
CheckUp:
	LDA buttons
	AND #BTN_UP
	BEQ CheckDown

	; change sprite tile
	LDA #$00
	STA player_sprite_facing
	JSR dungeon_increment_avatar_sprite_frame

	; move player sprite up
	LDA avatar_y	; load sprite Y position
	SEC				; make sure carry flag is set
	SBC #$01		; A = A - 1
	STA avatar_y	; save sprite Y position
CheckDown:
	LDA buttons
	AND #BTN_DOWN
	BEQ CheckLeft

	LDA #$01
	STA player_sprite_facing
	JSR dungeon_increment_avatar_sprite_frame

	; move player sprite down
	LDA avatar_y
	CLC				; make sure the carry flag is clear
	ADC #$01		; A = A + 1
	STA avatar_y
CheckLeft:
	LDA buttons
	AND #BTN_LEFT
	BEQ CheckRight

	; change sprite tile
	LDA #$02
	STA player_sprite_facing
	JSR dungeon_increment_avatar_sprite_frame

	; move sprite left
	LDA avatar_x
	SEC
	SBC #$01
	STA avatar_x
CheckRight:
	LDA buttons
	AND #BTN_RIGHT
	BEQ HandleControllerDone

	; change sprite tile
	LDA #$03
	STA player_sprite_facing
	JSR dungeon_increment_avatar_sprite_frame

	; move sprite right
	LDA avatar_x
	CLC
	ADC #$01
	STA avatar_x
HandleControllerDone:
	RTS
.endproc

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

.proc check_stairs_down_collision
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

.import dungeon_increment_avatar_sprite_frame
.import load_title_screen
.import dungeon_logic
.import load_dialogue_screen
.import load_dungeon_screen
.import handle_treasure_collision
.import check_treasure_collisions