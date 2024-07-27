.include "../includes/constants.inc"
.import main

.segment "BSS"
.import SOFT_PPUMASK

.segment "CODE"
.export reset_handler
.proc reset_handler
	SEI			; disable IRQs
	CLD			; disable decimal mode
	LDX #$40
	STX $4017	; disable APU frame IRQ
	LDX #$FF
	TXS			; initialize stack pointer to the top
	INX			; reset X to 0
	STX PPUCTRL	; disable NMI
	STX PPUMASK	; disable rendering
	STX $4010	; disable DMC IRQs

	JSR @vblankwait

@ram_reset_loop:
	LDA #$00
	STA $0000, x
	STA $0100, x
	STA $0300, x
	STA $0400, x
	STA $0500, x
	STA $0600, x
	STA $0700, x
	LDA #$FE
	STA $0200, x	; moves all sprites offscreen
	INX
	BNE @ram_reset_loop

	JSR @vblankwait

	; set PPU control flags: NMI enabled, sprites from Pattern Table 0, background from Pattern Table 1
	LDA #%10010000
	STA PPUCTRL

	LDA #PPUMASK_STANDARD
	STA SOFT_PPUMASK

	JMP main

@vblankwait:
	; wait for VBLANK to make sure the PPU is ready

	; BIT (bit test) checks $2002, the PPU status register
	; and sets the negative flag to the value of bit 7, which is 1 if screen is in VBLANK
	BIT PPUSTATUS
	; BPL (branch if positive) loops if the negative flag is clear, continues if it's set
	; normally used to check positive/negative, but thanks to BIT opcode, this checks the value of bit 7 of PPUSTATUS
	BPL @vblankwait
	; return from subroutine
	RTS
.endproc