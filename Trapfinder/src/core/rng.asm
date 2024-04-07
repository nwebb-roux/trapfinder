.segment "ZEROPAGE"
.importzp timer, seed0, seed1

.segment "CODE"
.export initialize_rng
.proc initialize_rng
LDA timer
STA seed0
LDA timer+1
STA seed0+1
JSR scrambleSeed
SBC timer+1
STA seed1
JSR scrambleSeed
SBC timer
STA seed1+1
RTS
.endproc

.export scrambleSeed
.proc scrambleSeed
LDY #$8
LDA seed0
@loop:
ASL
ROL seed0+1
BCC @noeor
EOR #$39
@noeor:
DEY
BNE @loop
STA seed0
CMP #$0
RTS
.endproc

.export lfsr
.proc lfsr
JSR rand64k
JSR rand32k
LDA seed0+1
EOR seed1+1
TAY
LDA seed0
EOR seed1
RTS
.endproc

.proc rand64k
LDA seed0+1
ASL
ASL
EOR seed0+1
ASL
EOR seed0+1
ASL
ASL
EOR seed0+1
ASL
ROL seed0
ROL seed0+1
RTS
.endproc

.proc rand32k
LDA seed1+1
ASL
EOR seed1+1
ASL
ASL
ROR seed1
ROL seed1+1
RTS
.endproc

.export rng_128
.proc rng_128
JSR lfsr
AND #%01111111
.endproc

.export rng_64
.proc rng_64
JSR lfsr
AND #%00111111
.endproc

.export rng_32
.proc rng_32
JSR lfsr
AND #%00011111
.endproc

.export rng_16
.proc rng_16
JSR lfsr
AND #%00001111
.endproc

.export rng_8
.proc rng_8
JSR lfsr
AND #%00000111
.endproc

.export rng_4
.proc rng_4
JSR lfsr
AND #%00000011
.endproc

.export rng_2
.proc rng_2
LDA timer
AND #%00000001
.endproc