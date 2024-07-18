.include "../includes/constants.inc"
.include "../macros/state.asm"

.segment "ZEROPAGE"
.importzp screen_state, timer

.segment "DRAWBUFFER"
.import DRAWBUFFER

.segment "BSS"
.import DRAWBUFFER_OFFSET, STACK_POINTER

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
	BPL Return

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

	; draw any changes to the nametables based on stack buffer
	JSR draw_nametable

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

	JSR famistudio_update
Return:
	RTI				; return from the NMI interrupt
.endproc

.proc draw_nametable
	; check if buffer draw flag is set, if not we're done
	; BIT sets V flag to bit 6 of whatever is referenced
	; in this case bit 6 of screen_state is the buffer draw flag
	BIT screen_state

	; branch if V is clear (i.e. buffer draw not set)
	BVC really_done

	; save original stack pointer in memory
	TSX
	STX STACK_POINTER

	; set stack pointer to $01FF - will get first byte at $0100, I hope
	LDX #$FF
	TXS

read_buffer_loop:
	; get string length from stack and auto-increment SP
	PLA

	; if length is 0, we're done
	CMP #$00
	BEQ done_with_buffer

	; store length in Y
	TAY

	; read PPU status to clear write latch
	LDA PPUSTATUS

	; get and write high byte of PPU address
	PLA
	STA PPUADDR

	; get and write low byte of PPU address
	PLA
	STA PPUADDR

draw_bytes_loop:
	; get data byte
	PLA

	; write to PPU
	STA PPUDATA

	; decrement remaining string length
	DEY

	; if remaining string length is 0, this string is done
	CPY #$00
	BEQ read_buffer_loop

	; if not, keep drawing
	JMP draw_bytes_loop

done_with_buffer:
	; reset original stack pointer
	LDX STACK_POINTER
	TXS

	; reset DRAWBUFFER_OFFSET
	LDX #$00
	STX DRAWBUFFER_OFFSET
really_done:
	RTS
.endproc

.import famistudio_update