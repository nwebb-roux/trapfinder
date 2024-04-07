.include "maps.inc"
.include "../includes/ram_constants.inc"

.segment "ZEROPAGE"
.importzp treasure_flags, treasure_x_coords, treasure_y_coords

.segment "CODE"
.export draw_treasure
.proc draw_treasure
	; set treasure count to 0
	LDY #$00

DrawTreasureLoop:
	; get flags byte
	LDA treasure_flags, Y

	; if flags byte is 0, there's no treasure in this spot
	CMP #$00
	BNE ContinueLoop
	JMP NextLoop

ContinueLoop:
	; set sprite table offset in X to Y * 16
	TYA
	ASL
	ASL
	ASL
	ASL
	TAX

    ; **** top left tile (x, y) ****
	; write Y
    LDA treasure_y_coords, Y
    STA $0210, X

	; write X
    LDA treasure_x_coords, Y
    STA $0213, X

	; write tile location
	; TODO can this ever be different during initial load? it will change when player opens the chest but that's later
	LDA #$40
	STA $0211, X
	STA COUNTER

	; write sprite attributes
	; TODO figure these out--palette is probably different
	LDA #%00000001
	STA $0212, X
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA treasure_y_coords, Y
    STA $0214, X

	; write X
    LDA treasure_x_coords, Y

	; add 8 to X and write
    CLC
    ADC #$08
    STA $0217, X

	; increment tile location and write
	LDA COUNTER
	CLC
	ADC #$01
	STA $0215, X
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $0216, X

    ; **** bottom left tile (x, y + 8) ****
	; add 8 to Y and write
    LDA treasure_y_coords, Y
    CLC
    ADC #$08
    STA $0218, X

	; write X (the original, not the +8 version)
    LDA treasure_x_coords, Y
    STA $021B, X

	; increment tile location and write
	LDA COUNTER
	CLC
	ADC #$01
	STA $0219, X
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $021A, X

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA treasure_y_coords, Y
    CLC
    ADC #$08
    STA $021C, X

	; add 8 to X and write
    LDA treasure_x_coords, Y
    CLC
    ADC #$08
    STA $021F, X

	; increment tile location and write
	LDA COUNTER
	CLC
	ADC #$01
	STA $021D, X
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $021E, X

NextLoop:
	; increment treasure count and loop if it's not 5 yet (runs 5 times)
	INY
	CPY #$05
	BEQ Done
	JMP DrawTreasureLoop

Done:
    RTS
.endproc

.export draw_open_treasure
.proc draw_open_treasure
	; this assumes the treasure index (0-4) is already in X!

	; set sprite table offset in Y to X * 16
	TXA
	ASL
	ASL
	ASL
	ASL
	TAY

    ; **** top left tile (x, y) ****
	; write Y
    LDA treasure_y_coords, X
    STA $0210, Y

	; write X
    LDA treasure_x_coords, X
    STA $0213, Y

	; write tile location
	LDA #$44
	STA $0211, Y
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $0212, Y
	
    ; **** top right tile (x + 8, y) ****
	; write Y
    LDA treasure_y_coords, X
    STA $0214, Y

	; write X
    LDA treasure_x_coords, X

	; add 8 to X and write
    CLC
    ADC #$08
    STA $0217, Y

	; increment tile location and write
	LDA COUNTER
	CLC
	ADC #$01
	STA $0215, Y
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $0216, Y

    ; **** bottom left tile (x, y + 8) ****
	; add 8 to Y and write
    LDA treasure_y_coords, X
    CLC
    ADC #$08
    STA $0218, Y

	; write X (the original, not the +8 version)
    LDA treasure_x_coords, X
    STA $021B, Y

	; increment tile location and write
	LDA COUNTER
	CLC
	ADC #$01
	STA $0219, Y
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $021A, Y

    ; **** bottom right tile (x + 8, y + 8) ****
	; add 8 to Y and write
    LDA treasure_y_coords, X
    CLC
    ADC #$08
    STA $021C, Y

	; add 8 to X and write
    LDA treasure_x_coords, X
    CLC
    ADC #$08
    STA $021F, Y

	; increment tile location and write
	LDA COUNTER
	CLC
	ADC #$01
	STA $021D, Y
	STA COUNTER

	; write sprite attributes
	LDA #%00000001
	STA $021E, Y

    RTS
.endproc