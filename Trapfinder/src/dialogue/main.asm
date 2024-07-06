.include "../includes/constants.inc"
.include "../macros/state.asm"

.segment "CODE"
.export load_dialogue_screen
.proc load_dialogue_screen
	; disable PPU while we switch screens
	LDX #%00
	STX PPUMASK

	SetDialogueScreenState

	; TODO make this a macro or subroutine
	; move all sprites offscreen
	LDX #$00
@sprite_reset_loop:
	LDA #$FE
	STA $0200, X
	INX
	BNE @sprite_reset_loop

	JSR bankswitch
	JSR load_title_screen_palettes
	JSR load_title_screen_background

	; turn PPU back on
	LDA PPUMASK_STANDARD
	STA PPUMASK

	RTS
.endproc

.export title_screen_logic
.proc title_screen_logic
	JSR title_screen_handle_controller

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

.import load_title_screen_palettes
.import load_title_screen_background
.import title_screen_handle_controller