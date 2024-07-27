.segment "ZEROPAGE"
.importzp screen_state

.macro SetTitleScreenState
	; set last 3 bits of game state to 000
	LDA screen_state
	AND #%11111000			; set last 3 bits to 000 without changing first 5 bits
	STA screen_state
.endmacro

.macro SetDialogueState
	LDA screen_state
	AND #%11111000			; set last 3 bits to 000 without changing first 5 bits
	ORA #DIALOGUE_STATE	; now set last 3 bits to 001 without changing first 5 bits
	STA screen_state
.endmacro

.macro SetDungeonState
	LDA screen_state
	AND #%11111000			; set last 3 bits to 000 without changing first 5 bits
	ORA #DUNGEON_STATE	; now set last 3 bits to 010 without changing first 5 bits
	STA screen_state
.endmacro

.macro SetRenderFlag
	; change bit 7 to 1 without changing the other bits
	LDA #%10000000
	ORA screen_state
	STA screen_state
.endmacro

.macro ClearRenderFlag
	; change bit 7 to 0 without changing the other bits
	LDA #%01111111
	AND screen_state
	STA screen_state
.endmacro

.macro ClearBufferDrawFlag
	; change bit 6 to 0 without changing the other bits
	LDA #%10111111
	AND screen_state
	STA screen_state
.endmacro

.macro SetBufferDrawFlag
	; change bit 6 to 1 without changing the other bits
	LDA screen_state
	ORA #%01000000
	STA screen_state
.endmacro