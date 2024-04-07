.include "../includes/constants.inc"
.include "../macros/state.asm"

.segment "CODE"
.export load_title_screen
.proc load_title_screen
	; disable PPU while we switch screens
	LDX #%00
	STX PPUMASK

	SetTitleScreenState

	; move all sprites offscreen
	LDX #$00
@sprite_reset_loop:
	LDA #$FE
	STA $0200, x
	INX
	BNE @sprite_reset_loop

	JSR bankswitch
	JSR load_title_screen_palettes
	JSR load_title_screen_background
	JSR load_title_screen_jewel_sprite

	; turn PPU back on
	LDA PPUMASK_STANDARD
	STA PPUMASK

	RTS
.endproc

.export title_screen_logic
.proc title_screen_logic
	JSR title_screen_handle_controller
	JSR title_screen_draw_jewel_sprite

	RTS
.endproc

bankswitch:
	; TODO move bankswitch subroutine to /core and call from various screen mains
	; (right now the code is copy-pasted just with different bank #s)
	; see Obsidian doc for a lengthy explanation of how bank switching works
	LDA #$00
	TAX
	STA bankvalues, X
	RTS

bankvalues:
	.byte $00, $01, $02, $03

.import load_title_screen_palettes
.import load_title_screen_background
.import load_title_screen_jewel_sprite
.import title_screen_handle_controller
.import title_screen_draw_jewel_sprite