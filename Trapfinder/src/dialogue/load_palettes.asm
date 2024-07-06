.include "../includes/constants.inc"

.segment "CODE"
.export load_dialogue_palettes
.proc load_dialogue_palettes
    ; write the initial palette memory address, $3F00, to PPU address port, $2006
    LDA PPUSTATUS   ; read PPU status to reset the high/low latch
    LDA #$3F        ; load $3F, the high byte of $3F00, into A
    STA PPUADDR     ; write it to the PPU address port
    LDA #$00        ; load $00 into A
    STA PPUADDR     ; write it to the PPU address port

    LDX #$00        ; initalize loop variable
LoadBGPaletteLoop:
    LDA background_palette, X  ; load one byte from the background palette (stored using the .byte directive), offset by the value in the X register, into A
    STA PPUDATA     ; write the value in A to the PPU data port, which starts by writing to the address we set via the data port, then auto-increments after each write (or read!)
    INX             ; increment X register by 1
    CPX #$10        ; compare X to 16 ($10 in hexadecimal)
    BNE LoadBGPaletteLoop  ; if X isn't 16, run the loop again (Branch if Not Equal)

    LDX #$00
LoadSpritePaletteLoop:
    LDA sprite_palette, X
    STA PPUDATA
    INX
    CPX #$10
    BNE LoadSpritePaletteLoop

    RTS
.endproc

.segment "RODATA"
background_palette:
.byte $0F,$00,$10,$30, $0F,$37,$16,$27, $0F,$29,$1A,$30, $0F,$10,$30,$00
sprite_palette:
.byte $0F,$19,$2A,$3B, $0F,$15,$25,$30, $0F,$02,$12,$31, $0F,$04,$15,$24