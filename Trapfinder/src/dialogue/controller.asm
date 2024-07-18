.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp buttons, new_buttons, avatar_x, avatar_y, player_sprite_facing, treasure_flags, treasure_x_coords, treasure_y_coords

.segment "CODE"
.export dialogue_handle_controller
.proc dialogue_handle_controller
CheckA:
	LDA new_buttons		; load contents of controller 1 button variable into A
	AND #BTN_A		; perform logical & of A (the register) against A (the button)
	BEQ CheckB		; branch to CheckB if A was not pressed, otherwise continue to A press instructions
	; add instructions here to do something when button is pressed
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

	; go to dungeon
	JSR load_dungeon_screen
	JMP HandleControllerDone
CheckUp:
	LDA buttons
	AND #BTN_UP
	BEQ CheckDown
	; add instructions here to do something when button is pressed
CheckDown:
	LDA buttons
	AND #BTN_DOWN
	BEQ CheckLeft
	; add instructions here to do something when button is pressed
CheckLeft:
	LDA buttons
	AND #BTN_LEFT
	BEQ CheckRight
	; add instructions here to do something when button is pressed
CheckRight:
	LDA buttons
	AND #BTN_RIGHT
	BEQ HandleControllerDone
	; add instructions here to do something when button is pressed
HandleControllerDone:
	RTS
.endproc

.import load_dungeon_screen