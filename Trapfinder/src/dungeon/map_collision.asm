.include "../includes/constants.inc"
.include "../includes/ram_constants.inc"

.segment "ZEROPAGE"
.importzp buttons, avatar_x, avatar_y, collision_metatile_offset_1, collision_metatile_offset_2

.segment "CODE"
.export dungeon_handle_background_collision
.proc dungeon_handle_background_collision
CheckUp:
	LDA buttons
	AND #BTN_UP
	BEQ CheckDown

	; calculate the left X coordinate
	LDA avatar_x
	CLC
	ADC #$02

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_1

	; calculate the top Y coordinate
	LDA avatar_y
	CLC
	ADC #$02

	; if it's 8, eject down
	CMP #$08
	BNE ContinueCheckUp
	JMP eject_down
ContinueCheckUp:
	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_2

	; test the top left point
	JSR test_collision
	BCC NoCollideUp
	JMP eject_down ; jump if carry flag was set to indicate collision
NoCollideUp:
	; calculate the right X coordinate
	LDA avatar_x
	CLC
	ADC #$0C

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_1

	; test the top right point
	JSR test_collision
	BCC CheckDown
	JMP eject_down ; branch if carry flag was set to indicate collision
CheckDown:
	LDA buttons
	AND #BTN_DOWN
	BEQ CheckLeft

	; calculate the left X coordinate
	LDA avatar_x
	CLC
	ADC #$02

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_1

	; calculate the bottom Y coordinate
	LDA avatar_y
	CLC
	ADC #$10

	; if it's 248, eject up
	CMP #$E8
	BNE ContinueCheckDown
	JMP eject_up
ContinueCheckDown:
	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_2

	; test the bottom left point
	JSR test_collision
	BCC NoCollideDown
	JMP eject_up ; jump if carry flag was set to indicate collision
NoCollideDown:
	; calculate the right X coordinate
	LDA avatar_x
	CLC
	ADC #$0C

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_1

	; test the bottom right point
	JSR test_collision
	BCC CheckLeft
	JMP eject_up ; jump if carry flag was set to indicate collision
CheckLeft:
	LDA buttons
	AND #BTN_LEFT
	BEQ CheckRight

	; calculate the X coordinate
	LDA avatar_x
	CLC
	ADC #$02

	; if it's 1, eject right
	CMP #$01
	BNE ContinueCheckLeft
	JMP eject_right
ContinueCheckLeft:
	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_1

	; calculate the top Y coordinate
	LDA avatar_y
	CLC
	ADC #$02

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_2

	; test the top left point
	JSR test_collision
	BCC NoCollideLeft
	JMP eject_right ; jump if carry flag was set to indicate collision
NoCollideLeft:
	; calculate the bottom Y coordinate
	LDA avatar_y
	CLC
	ADC #$0F

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_2

	; test the bottom left point
	JSR test_collision
	BCC CheckRight
	JMP eject_right ; jump if carry flag was set to indicate collision
CheckRight:
	LDA buttons
	AND #BTN_RIGHT
	BEQ HandleCollisionDone

	; calculate the X coordinate of the right edge
	LDA avatar_x
	CLC
	ADC #$0C

	; if it's 255, eject left
	CMP #$FF
	BNE ContinueCheckRight
	JMP eject_left
ContinueCheckRight:
	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_1

	; calculate the top Y coordinate
	LDA avatar_y
	CLC
	ADC #$02

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_2

	; test the top right point
	JSR test_collision
	BCC NoCollideRight
	JMP eject_left ; jump if carry flag was set to indicate collision
NoCollideRight:
	; calculate the bottom Y coordinate
	LDA avatar_y
	CLC
	ADC #$0F

	LSR
	LSR
	LSR
	LSR
	STA collision_metatile_offset_2

	; test the bottom right point
	JSR test_collision
	BCC HandleCollisionDone
	JMP eject_left ; jump if carry flag was set to indicate collision
HandleCollisionDone:
	RTS
.endproc

.proc test_collision
	LDA collision_metatile_offset_1	; load the X coordinate of the tile into A
	LDY collision_metatile_offset_2	; load the Y coordinate of the tile into Y

@XRowLoop:
	CPY #$00			; compare Y to 0
	BEQ	RowLoopFinished	; if Y is 0, loop is done
	CLC
	ADC #$10			; add 16 to A to move our tile coordinate down a row
	DEY					; decrement Y
	JMP @XRowLoop		; run the loop again

RowLoopFinished:
	TAX					; transfer metatile offset into X

	LDA SCREEN_MAP, X				; load the metatile
	AND #%00001111					; mask out the high nybble so we're just using the metatile number
	TAX
	LDY COLLISION_TABLE, X			; load metatile collision data into Y

	; if collision type isn't 01 (block), we're done
	CPY #$01
	BNE Finished

	; if we're here, we have a block collision
	; set carry bit to indicate collision
	SEC
	RTS

Finished:
	; clear carry bit, used to tell calling routine there's no collision
	CLC
    RTS
.endproc

.proc eject_up
	LDA avatar_y
	SEC				; make sure the carry flag is set
	SBC #$01		; A = A - 1
	STA avatar_y
	RTS
.endproc

.proc eject_down
	LDA avatar_y	; load sprite Y position
	CLC				; make sure carry flag is clear
	ADC #$01		; A = A + 1
	STA avatar_y	; save sprite Y position
	RTS
.endproc

.proc eject_right
	LDA avatar_x
	CLC
	ADC #$01
	STA avatar_x
	RTS
.endproc

.proc eject_left
	LDA avatar_x
	SEC
	SBC #$01
	STA avatar_x
	RTS
.endproc