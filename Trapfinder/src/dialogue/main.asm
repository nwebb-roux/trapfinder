.include "../includes/constants.inc"
.include "../macros/state.asm"

.segment "BSS"
.import SCRATCH_D

.segment "CODE"
.export load_dialogue_screen
.proc load_dialogue_screen
	; disable PPU while we switch screens
	LDX #%00
	STX PPUMASK

	SetDialogueState

	; TODO make this a macro or subroutine
	; move all sprites offscreen
	LDX #$00
@sprite_reset_loop:
	LDA #$FE
	STA $0200, X
	INX
	BNE @sprite_reset_loop

	JSR bankswitch
	JSR load_dialogue_palettes
	JSR init_background
	JSR prep_dialogue_screen

	; turn PPU back on
	LDA PPUMASK_STANDARD
	STA PPUMASK

	RTS
.endproc

.export dialogue_screen_logic
.proc dialogue_screen_logic
	JSR dialogue_handle_controller

	; if "finished writing text" flag (in SCRATCH_D) is set, jump directly to end
	LDX SCRATCH_D
	CPX #$01
	BEQ end_dialogue_logic

	; flag wasn't set; draw next character
	JSR draw_next_character

end_dialogue_logic:
	RTS
.endproc

bankswitch:
	; TODO move bankswitch subroutine to /core and call from various screen mains
	; (right now the code is copy-pasted just with different bank #s)
	; see Obsidian doc for a lengthy explanation of how bank switching works
	LDA #$02
	TAX
	STA bankvalues, X
	RTS

bankvalues:
	.byte $00, $01, $02, $03

.import init_background
.import prep_dialogue_screen
.import render_dialogue
.import load_dialogue_palettes
.import dialogue_handle_controller
.import draw_next_character