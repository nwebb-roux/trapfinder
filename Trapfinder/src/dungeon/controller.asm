.include "../includes/constants.inc"
.include "../includes/ram_constants.inc"

.segment "ZEROPAGE"
.importzp buttons, new_buttons, avatar_x, avatar_y, player_sprite_facing, treasure_flags, treasure_x_coords, treasure_y_coords

.segment "CODE"
.export dungeon_handle_controller
.proc dungeon_handle_controller
CheckA:
	LDA buttons		; load contents of controller 1 button variable into A
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
	JSR dungeon_logic
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

.proc check_treasure_collisions
	; init loop var
	LDX #$00

TreasureLoop:
	LDA avatar_x
	CLC
	ADC #$10
	CMP treasure_x_coords, X
	BCC @noCollide
	LDA treasure_x_coords, X
	CLC
	ADC #$10
	CMP avatar_x
	BCC @noCollide
	LDA avatar_y
	CLC
	ADC #$10
	CMP treasure_y_coords, X
	BCC @noCollide
	LDA treasure_y_coords, X
	CLC
	ADC #$10
	CMP avatar_y
	BCC @noCollide

	; collision occurred
	; load treasure flags into A
	LDA treasure_flags, X

	; mask out all but "is it closed" bit
	AND #%10000000

	; if already open, we're done
	CMP #$00
	BEQ @noCollide

	; treasure is closed, continue with collision
	; reload treasure flags
	LDA treasure_flags, X

	; set "is it closed" bit to 0 and store
	AND #%01111111
	STA treasure_flags, X

	; redraw the chest sprite as open
	JSR draw_open_treasure

@noCollide:
	; increment loop counter
	INX

	; if X is 5, we're done
	CPX #$05
	BEQ CheckComplete

	; otherwise, loop again
	JMP TreasureLoop

CheckComplete:
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

	; collision occurred
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
	LDA avatar_x
	CLC
	ADC #$10
	CMP #STAIRS_DOWN_X
	BCC @noCollide
	LDA #STAIRS_DOWN_X
	CLC
	ADC #$0F
	CMP avatar_x
	BCC @noCollide
	LDA avatar_y
	CLC
	ADC #$10
	CMP #STAIRS_DOWN_Y
	BCC @noCollide
	LDA #STAIRS_DOWN_Y
	CLC
	ADC #$10
	CMP avatar_y
	BCC @noCollide

	; collision occurred
	; increment dungeon floor
	LDX DUNGEON_FLOOR
	INX
	STX DUNGEON_FLOOR
	; clear out buttons
	LDX #$00
	STX buttons
	STX new_buttons
	JSR load_dungeon_screen
	; set carry flag for check on return
	SEC
	RTS
@noCollide:
	; clear carry flag for check on return
	CLC
	RTS
.endproc

.import dungeon_increment_avatar_sprite_frame
.import draw_open_treasure
.import load_title_screen
.import load_dungeon_screen
.import dungeon_logic