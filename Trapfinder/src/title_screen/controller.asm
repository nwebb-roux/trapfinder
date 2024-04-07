.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp buttons, new_buttons, avatar_y

.segment "CODE"
.export title_screen_handle_controller
.proc title_screen_handle_controller
CheckA:
	LDA new_buttons		; load contents of controller 1 button variable into A
	AND #BTN_A		; perform logical & of A (the register) against A (the button)
	BEQ CheckB		; branch to CheckB if A was not pressed, otherwise continue to A press instructions
	; add instructions here to do something when button is pressed
CheckB:
	LDA new_buttons
	AND #BTN_B
	BEQ CheckSelect
CheckSelect:
	LDA new_buttons
	AND #BTN_SELECT
	BEQ CheckStart
	JSR increment_jewel_palette
CheckStart:
	LDA new_buttons
	AND #BTN_START
	BEQ CheckUp
	JSR initialize_rng
	JSR load_dungeon_screen
	RTS
CheckUp:
	LDA new_buttons
	AND #BTN_UP
	BEQ CheckDown
CheckDown:
	LDA new_buttons
	AND #BTN_DOWN
	BEQ CheckLeft
CheckLeft:
	LDA new_buttons
	AND #BTN_LEFT
	BEQ CheckRight
CheckRight:
	LDA new_buttons
	AND #BTN_RIGHT
	BEQ HandleControllerDone
HandleControllerDone:
	RTS
.endproc

.import set_player_location
;.import load_dialogue_screen
.import load_dungeon_screen
.import increment_jewel_palette
.import initialize_rng