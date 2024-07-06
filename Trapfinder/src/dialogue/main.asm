.include "../includes/constants.inc"
.include "../macros/state.asm"

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

	; turn PPU back on
	LDA PPUMASK_STANDARD
	STA PPUMASK

	JSR render_dialogue

	RTS
.endproc

.export dialogue_screen_logic
.proc dialogue_screen_logic

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
.import render_dialogue
.import load_dialogue_palettes