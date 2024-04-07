.include "../includes/constants.inc"

.segment "ZEROPAGE"
.importzp buttons, new_buttons

.segment "CODE"
.export read_controller
.proc read_controller
	LDY buttons			; save the current state of the controller into Y
	; we have to "strobe" $4016 (essentially flash true on and off) to "latch," or capture, the controller state
	; otherwise it would keep changing as we tried to read it
	; strobing $4016 latches both controllers even though it's the address for controller 1
	LDA #$01
	STA CONTROLLER_1
	LDA #$00
	STA CONTROLLER_1
; now we can loop 8 reads of each controller's memory address
; each time we read it, we get a new byte, whose bit 0 is 1 if that button is pressed
; this code loads the byte into A, right-shifts bit 0 into the carry bit, then left-rotates the controller variable,
; which pulls the carry bit (which holds the most recent button state) into bit 0. Pretty cool, Nerdy Nights!
	LDX #$08			; initialize the loop counter
ReadControllersLoop:
	LDA CONTROLLER_1	; load controller 1's button into A
	LSR A				; right-shift A's bit 0 into the carry bit
	ROL buttons			; left-rotate buttons to get the new button state
	DEX					; decrement the loop counter
	BNE ReadControllersLoop
; finally, we'll figure out which buttons were just pressed on this run-through
	TYA					; move the previous controller state from Y to A
	EOR buttons
	AND buttons
	STA new_buttons

	RTS
.endproc