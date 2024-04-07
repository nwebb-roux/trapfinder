.include "background.inc"
.include "../includes/constants.inc"

.segment "CODE"
.export load_title_screen_background
.proc load_title_screen_background
	; set nametable address in PPU
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$00
	STA PPUADDR

	LDX #$00
LoadBackgroundLoop0:
	LDA background_0, X
	STA PPUDATA
	INX
	CPX #$0
	BNE LoadBackgroundLoop0

	LDX #$00
LoadBackgroundLoop1:
	LDA background_1, X
	STA PPUDATA
	INX
	CPX #$0
	BNE LoadBackgroundLoop1

	LDX #$00
LoadBackgroundLoop2:
	LDA background_2, X
	STA PPUDATA
	INX
	CPX #$0
	BNE LoadBackgroundLoop2

	LDX #$00
LoadBackgroundLoop3:
	LDA background_3, X
	STA PPUDATA
	INX
	CPX #$0
	BNE LoadBackgroundLoop3

    RTS
.endproc