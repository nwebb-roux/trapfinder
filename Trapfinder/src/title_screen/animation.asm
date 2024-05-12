.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp timer

.segment "CODE"
.proc load_title_screen_zap
	; first, store the first sprite's second attribute (assumed to be jewel sprite's tile location) in a ZP variable
	LDX #$01
	LDA title_screen_jewel, X
	STA avatar_tile_location

	LDX #$02
	LDA title_screen_jewel, X
	STA avatar_sprite_attributes

	; initialize loop counter to 0 - this will run four times
    LDX #$00
load_sprite_loop:
    ; load data from address (title_screen_jewel + X) into A
    LDA title_screen_jewel, x
    ; store into RAM address ($0200 + X)
    STA $0200, x
    ; increment X
    INX
    ; Compare X to hex $04, decimal 4
    CPX #$04
    ; Branch back to load_sprite_loop if compare was Not Equal to zero
    BNE load_sprite_loop

	; set starting location of jewel
	LDA #$61					; X value for the jewel
	PHA
	LDA #$AB					; Y value for the jewel
	PHA
	JSR set_jewel_location
	PLA
	PLA

	RTS
.endproc

.proc WaitASec
    ; reset counter
    LDY #$00

    SEI

OneSecondLoop:
    LDA timer
@pause_loop:
    ; loop until timer changes
    ; this should happen 60 times a second
    CMP timer
    BEQ @pause_loop

    ; increment the counter and break if it's 60
    INY
    CPY #$3C
    BEQ Break

    ; if not, keep looping
    JMP OneSecondLoop
Break:
    RTS
.endproc

.segment "RODATA"
background_palette:
.byte $0F,$29,$15,$05, $0F,$29,$1A,$30, $0F,$29,$1A,$30, $0F,$00,$10,$30
sprite_palette:
.byte $0F,$19,$2A,$3B, $0F,$15,$25,$30, $0F,$02,$12,$31, $0F,$04,$15,$24