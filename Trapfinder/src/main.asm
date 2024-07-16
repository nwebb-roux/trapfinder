.include "includes/constants.inc"
.include "includes/header.inc"
.include "includes/zero_page.inc"
.include "includes/ram_map.inc"
.include "macros/state.asm"

.segment "ZEROPAGE"
.importzp screen_state

.segment "CODE"

.import nmi_handler
.import reset_handler
.import irq_handler

.export main
.proc main
	; do any first-time init
	JSR audio_init
	JSR load_title_screen
game_loop:
	JSR read_controller

	; choose logic based on screen_state
	LDA screen_state			; load screen_state flags into A
	AND #%00000111				; set high 5 bits of A to 0 without changing low 3 bits
check_title_screen:
	CMP #TITLE_SCREEN_STATE		; compare A to the flag value for title screen
	BNE check_dialogue			; if not equal, jump to check_dungeon
	JSR title_screen_logic		; if we didn't jump ahead, run title screen logic
	JMP run_loop				; once title screen logic is done, jump to the wait loop
check_dialogue:
	CMP #DIALOGUE_STATE
	BNE check_dungeon
	JSR dialogue_screen_logic
	JMP run_loop
check_dungeon:
	CMP #DUNGEON_STATE		; compare A to the flag value for dungeon
	BNE run_loop				; CHANGE THIS WHEN WE HAVE MORE SCREENS
	JSR dungeon_logic
	JMP run_loop				; not actually needed for final check block, should fall through

run_loop:
	; set render flag and loop forever until render flag is cleared
	SetRenderFlag
@wait_for_nmi:
	BIT screen_state
	BMI @wait_for_nmi

	; after NMI interrupt, do this whole loop again
	JMP game_loop
.endproc

.import audio_init
.import load_title_screen
.import read_controller
.import title_screen_logic
.import dungeon_logic
.import dialogue_screen_logic

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

; load CHR banks - 0: title screen, 1: dungeon, 2: dialogue, 3: ?
.segment "CHR0"
.incbin "src/graphics/tf_title_screen.chr"

.segment "CHR1"
.incbin "src/graphics/tf_dungeons.chr"

.segment "CHR2"
.incbin "src/graphics/tf_dialogue.chr"