.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp buttons, new_buttons, avatar_x, avatar_y, player_sprite_facing

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

.import dungeon_increment_avatar_sprite_frame
.import load_title_screen
.import dungeon_logic
.import load_dialogue_screen
.import load_dungeon_screen
.import handle_treasure_collision
.import check_treasure_collisions
.import handle_stairs_down_collision
.import check_stairs_up_collision
.import check_stairs_down_collision
.import increment_dungeon_level