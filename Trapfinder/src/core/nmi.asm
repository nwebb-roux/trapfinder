.include "../includes/constants.inc"
.include "../macros/state.asm"

.segment "ZEROPAGE"
.importzp screen_state, timer

.segment "CODE"
.export nmi_handler
.proc nmi_handler
	; increment the timer
	INC timer
	BNE NoSecondByteIncrement
	INC timer+1
	NoSecondByteIncrement:

	; if render flag is false, skip rendering and return
	BIT screen_state
	BPL @return

	; **** NMI INTERRUPT ****
	; during each NMI interrupt, we update the sprite data in the PPU's OAM tables
	; we do this using OAMDMA, a special automatic write of all 256 bytes of OAM
	; OAMDMA starts at the current OAMADDR, so best practice is to initialize OAMADDR to 0
	LDA #$00		; load 0 into A
	STA OAMADDR		; write A to the OAMADDR port
	; OAMDMA reads one 256-byte page, $XX00-$XXFF, from internal RAM and writes it to OAM
	; by convention we use page 2, $0200-$02FF, for this purpose (see the DRAW A SPRITE section, where we're putting sprite data in that memory area)
	LDA #$02		; we load the high byte of the page, $02, into A
	STA OAMDMA		; then all we need to do is write A to the OAMDMA port and it kicks off the whole thing: the whole 256-byte page is transferred to OAM

	; PPU cleanup section, don't understand this yet
	LDA #%10010000	; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA PPUCTRL
	LDA #%00011110	; enable sprites, enable background, no clipping on left side
	STA PPUMASK
	LDA #$00		; tell the PPU there's no background scrolling
	STA PPUSCROLL
	STA PPUSCROLL	; why twice? horizontal and vertical I think

	; clear render flag so game logic will run again
	ClearRenderFlag

@return:
	RTI				; return from the NMI interrupt
.endproc