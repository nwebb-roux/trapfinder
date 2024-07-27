.include "../includes/constants.inc"
.include "status_bar.inc"
.include "../macros/state.asm"

.segment "ZEROPAGE"
.importzp avatar_x, avatar_y, treasure_flags, treasure_x_coords, treasure_y_coords

.segment "BSS"
.import COUNTER, GOLD_PIECES, HEX_VALUE, ASCII_RESULT

.segment "CODE"
.export check_treasure_collisions
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
	JSR handle_treasure_collision

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

.export handle_treasure_collision
.proc handle_treasure_collision
    ; store counter temporarily because SFX messes with X (and A)
	STX COUNTER

	; trigger sfx
	JSR sfx_chest_open

	; reload counter
	LDX COUNTER

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


    ; add to GP (aka score)
    JSR increment_score


@noCollide:
    RTS
.endproc

.proc increment_score
    ; add 1 to GP
    LDA GOLD_PIECES
    CLC
    ADC #$01
    STA GOLD_PIECES

    ; translate GP to ASCII in memory
    STA HEX_VALUE

    STX COUNTER

    JSR draw_gp

    LDX COUNTER

    RTS
.endproc

.export draw_gp
.proc draw_gp
    JSR hex_to_ascii_8bit

    ; write number of tiles to draw buffer
    LDA #$07
    STA $0100

    ; write high and low byte of score draw location to draw buffer
    ; ($2057, or the 88th tile of the status bar)
    LDA #$20
    STA $0101
    LDA #$57
    STA $0102

    LDX #$00

draw_digit_loop:
    LDY ASCII_RESULT, X
    LDA level_to_number_tile, Y

    STA $0103, X

    INX
    CPX #$05
    BNE draw_digit_loop

    ; write two zeroes
    LDA level_to_number_tile
    STA $0108
    STA $0109

    ; write stop byte to draw buffer
    LDA #$00
    STA $010A

    ; set buffer draw flag
    SetBufferDrawFlag

    RTS
.endproc


.import sfx_chest_open
.import draw_open_treasure
.import hex_to_ascii_8bit
