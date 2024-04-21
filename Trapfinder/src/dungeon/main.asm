.include "../includes/constants.inc"
.include "../includes/ram_constants.inc"
.include "../macros/state.asm"

.segment "ZEROPAGE"
.importzp screen_state, buttons, new_buttons

.segment "CODE"
.export load_dungeon_screen
.proc load_dungeon_screen
	; disable PPU while we switch screens
	LDX #%00
	STX PPUMASK

	; reset controller buttons
	STX new_buttons

	SetDungeonState

	; move all sprites offscreen
	; TODO move this to a macro or subroutine that all mains can call
	LDX #$00
@sprite_reset_loop:
	LDA #$FE
	STA $0200, x
	INX
	BNE @sprite_reset_loop

	JSR bankswitch

	JSR load_dungeon_palettes
	JSR load_dungeon_map
	JSR load_dungeon_map_attributes
	JSR populate_treasure

	JSR draw_dungeon_background
	JSR draw_dungeon_attributes
	JSR dungeon_draw_stairs_up
	JSR dungeon_draw_stairs_down
	JSR draw_treasure

	JSR load_avatar_sprite

	; turn PPU back on
	LDA PPUMASK_STANDARD
	STA PPUMASK

	RTS
.endproc

.export dungeon_logic
.proc dungeon_logic
	JSR dungeon_handle_controller

	; if we return here but screen state is no longer dungeon, skip these commands
	LDA screen_state			; load screen_state flags into A
	AND #%00000111				; set high 5 bits of A to 0 without changing low 3 bits
	CMP #DUNGEON_STATE			; compare A to the flag value for dungeon
	BNE dungeon_logic_end		; if they're different, skip the rest of the logic

	JSR dungeon_handle_background_collision
	JSR dungeon_update_avatar_sprite
	JSR dungeon_draw_avatar_sprite
dungeon_logic_end:
	RTS
.endproc

bankswitch:
	; see Obsidian doc for a lengthy explanation of how bank switching works
	LDA #$01
	TAX
	STA bankvalues, X
	RTS

bankvalues:
	.byte $00, $01, $02, $03

.import load_dungeon_palettes
.import load_dungeon_map
.import load_dungeon_map_attributes
.import draw_dungeon_background
.import draw_dungeon_attributes
.import dungeon_draw_stairs_up
.import dungeon_draw_stairs_down
.import populate_treasure
.import draw_treasure
.import load_avatar_sprite

.import dungeon_handle_controller
.import dungeon_calculate_collision_offsets
.import dungeon_handle_collision
.import dungeon_handle_background_collision
.import dungeon_draw_avatar_sprite
.import dungeon_update_avatar_sprite