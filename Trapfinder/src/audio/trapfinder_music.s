; This file is for the FamiStudio Sound Engine and was generated by FamiStudio

; .if FAMISTUDIO_CFG_C_BINDINGS
; .export _music_data_trapfinder=music_data_trapfinder
; .endif

music_data_trapfinder:
	.byte 4
	.word @instruments
	.word @samples-4
; 00 : Title Screen
	.word @song0ch0
	.word @song0ch1
	.word @song0ch2
	.word @song0ch3
	.word @song0ch4
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
; 01 : Dark Arps
	.word @song1ch0
	.word @song1ch1
	.word @song1ch2
	.word @song1ch3
	.word @song1ch4
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
; 02 : Blitzkrieg
	.word @song2ch0
	.word @song2ch1
	.word @song2ch2
	.word @song2ch3
	.word @song2ch4
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0
; 03 : End Titles
	.word @song3ch0
	.word @song3ch1
	.word @song3ch2
	.word @song3ch3
	.word @song3ch4
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0

.export music_data_trapfinder
.global FAMISTUDIO_DPCM_PTR

@instruments:
	.word @env7,@env25,@env20,@env0 ; 00 : Shaker Lo
	.word @env31,@env13,@env20,@env0 ; 01 : Snare
	.word @env24,@env13,@env20,@env0 ; 02 : Kick
	.word @env26,@env13,@env20,@env0 ; 03 : WilyNoiseDrumLo
	.word @env22,@env13,@env20,@env0 ; 04 : Closed Hat
	.word @env14,@env13,@env20,@env0 ; 05 : WilyNoiseDrumHi
	.word @env11,@env25,@env20,@env0 ; 06 : Shaker Hi
	.word @env1,@env13,@env20,@env0 ; 07 : Bass
	.word @env34,@env33,@env20,@env8 ; 08 : Tri Drums
	.word @env28,@env13,@env5,@env19 ; 09 : Lead 2
	.word @env28,@env13,@env5,@env17 ; 0a : Lead 2 Tremolo
	.word @env4,@env13,@env3,@env12 ; 0b : Oboe
	.word @env2,@env13,@env29,@env0 ; 0c : Sitar
	.word @env18,@env13,@env23,@env21 ; 0d : Medium Arps
	.word @env30,@env13,@env3,@env6 ; 0e : IntroArp 2
	.word @env35,@env13,@env3,@env32 ; 0f : IntroArp1
	.word @env10,@env13,@env23,@env21 ; 10 : Lead
	.word @env27,@env13,@env23,@env21 ; 11 : Quiet Arps
	.word @env9,@env13,@env15,@env0 ; 12 : Harpsichord
	.word @env10,@env13,@env16,@env21 ; 13 : Trumpet

@env0:
	.byte $00,$c0,$7f,$00,$02
@env1:
	.byte $00,$cf,$ca,$c7,$c6,$c4,$00,$05
@env2:
	.byte $00,$cc,$ca,$c8,$02,$c6,$c4,$00,$06
@env3:
	.byte $c1,$c0,$00,$01
@env4:
	.byte $00,$c8,$c6,$00,$02
@env5:
	.byte $c2,$c1,$00,$01
@env6:
	.byte $00,$c0,$04,$bf,$03,$c0,$c0,$bf,$bf,$be,$be,$bf,$bf,$00,$05
@env7:
	.byte $00,$c7,$c7,$c5,$c4,$c4,$c3,$04,$c1,$c1,$c0,$00,$0a
@env8:
	.byte $00,$bf,$7f,$00,$02
@env9:
	.byte $00,$c9,$c6,$c4,$c4,$c3,$c3,$c1,$00,$07
@env10:
	.byte $0a,$c6,$c6,$c7,$02,$c6,$03,$c5,$00,$07,$c4,$00,$0a
@env11:
	.byte $00,$c9,$c8,$c7,$c6,$c6,$c5,$04,$c4,$c3,$c2,$c1,$02,$c0,$00,$0d
@env12:
	.byte $00,$c0,$0b,$bf,$be,$bd,$be,$c1,$c2,$c3,$03,$c2,$c1,$bf,$be,$bd,$03,$be,$bf,$c1,$c2,$c3,$03,$c2,$c1,$bf,$be,$bd,$03,$be,$bf,$c1,$c2,$c3,$03,$c2,$c1,$c0,$00,$25
@env13:
	.byte $c0,$7f,$00,$01
@env14:
	.byte $00,$cf,$c5,$c5,$c0,$00,$04
@env15:
	.byte $c0,$c2,$c0,$00,$02
@env16:
	.byte $c2,$c2,$c0,$c0,$c2,$00,$04
@env17:
	.byte $00,$bd,$ba,$bd,$c3,$c6,$c3,$00,$01
@env18:
	.byte $00,$c6,$c5,$c4,$00,$03
@env19:
	.byte $00,$bf,$be,$bf,$c1,$c2,$c1,$00,$01
@env20:
	.byte $7f,$00,$00
@env21:
	.byte $00,$c0,$11,$c0,$c1,$c2,$c2,$c1,$c0,$bf,$be,$bd,$be,$bf,$00,$03
@env22:
	.byte $00,$ca,$c4,$00,$02
@env23:
	.byte $c0,$c1,$00,$01
@env24:
	.byte $00,$ca,$02,$c0,$00,$03
@env25:
	.byte $c0,$c1,$03,$c2,$c1,$c2,$c1,$c2,$c1,$c2,$00,$09
@env26:
	.byte $00,$cf,$cf,$cb,$02,$c7,$02,$c3,$c0,$00,$08
@env27:
	.byte $00,$c4,$c3,$c2,$00,$03
@env28:
	.byte $00,$c0,$cd,$00,$02
@env29:
	.byte $c2,$c2,$c1,$c1,$c0,$03,$c1,$03,$c0,$03,$c1,$03,$c0,$03,$c1,$03,$c0,$03,$c1,$03,$c0,$03,$c1,$03,$c0,$03,$c1,$03,$c0,$00,$1c
@env30:
	.byte $07,$c6,$c5,$c4,$c3,$00,$04,$c3,$c1,$00,$08
@env31:
	.byte $00,$ca,$02,$c6,$03,$c2,$00,$05
@env32:
	.byte $00,$c1,$04,$c0,$03,$c1,$c1,$c0,$c0,$bf,$bf,$c0,$c0,$00,$05
@env33:
	.byte $c0,$bc,$00,$01
@env34:
	.byte $00,$cf,$cf,$c0,$00,$03
@env35:
	.byte $07,$c8,$c7,$c6,$c5,$00,$04,$c5,$c3,$00,$08

@samples:

@tempo_env_1_mid:
	.byte $03,$05,$80

@song0ch0:
@song0ch0loop:
	.byte $47, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $98
@song0ref6:
	.byte $20, $bd, $22, $9d, $23, $9d, $27, $fd, $20, $bd, $22, $9d, $23, $9d, $27, $9d, $25, $9d, $22, $bd, $48, $1e, $bd, $20
	.byte $9d, $22, $9d, $25, $fd, $20, $bd, $22, $9d, $23, $9d, $27, $9d, $25, $9d, $22, $9d, $1f, $9d, $48
	.byte $41, $2a
	.word @song0ref6
	.byte $48
	.byte $41, $2a
	.word @song0ref6
	.byte $48
	.byte $41, $2a
	.word @song0ref6
	.byte $48
	.byte $41, $2a
	.word @song0ref6
	.byte $48, $20, $bd, $27, $bd, $28, $bd, $23, $bd, $25, $bd, $20, $bd, $27, $bd, $22, $bd, $48, $20, $bd, $2a, $bd, $28, $bd
	.byte $27, $bd, $25, $bd, $28, $bd, $27, $bd, $22, $bd, $48, $96
@song0ref101:
	.byte $14, $9d, $1b, $9d, $1c, $9d, $19, $9d, $1b, $9d, $17, $9d, $19, $9d, $16, $9d, $17, $9d, $14, $9d, $16, $9d, $13, $9d
	.byte $16, $9d, $17, $9d, $19, $9d, $1b, $9d, $48
	.byte $41, $20
	.word @song0ref101
	.byte $48, $98, $1c, $9d, $20, $9d, $1b, $9d, $20, $9d, $19, $9d, $20, $9d, $17, $9d, $20, $9d, $14, $ff, $fd, $42
	.word @song0ch0loop
@song0ch1:
@song0ch1loop:
	.byte $ff, $ff, $ff, $ff, $98
@song0ref167:
	.byte $12, $bd, $14, $9d, $16, $9d, $19, $fd, $14, $bd, $16, $9d, $17, $9d, $1b, $9d, $19, $9d, $16, $9d, $13, $9d, $14, $bd
	.byte $00, $ff, $ff, $ff, $bd
	.byte $41, $1d
	.word @song0ref167
	.byte $41, $12
	.word @song0ref167
	.byte $96, $20, $9d, $1f, $9d
@song0ref207:
	.byte $20, $ff, $9d, $14
@song0ref211:
	.byte $9d, $20, $9d, $1f, $9d, $20, $ff, $9d, $14, $9d, $20, $9d, $1f, $9d, $1e, $ff, $9d, $1f
	.byte $41, $0e
	.word @song0ref211
	.byte $41, $16
	.word @song0ref207
	.byte $41, $0e
	.word @song0ref211
	.byte $20, $fd, $20, $fd, $20, $fd, $1f, $fd, $20, $bd, $23, $bd, $20, $bd, $1e, $9d, $1c, $9d, $1b, $bd, $1f, $9d, $22, $9d
	.byte $1f, $fd, $20, $bd, $27, $bd, $23, $bd, $20, $9d, $1e, $9d, $1c, $bd, $1f, $9d, $22, $9d, $1f, $9d, $20, $9d, $22, $9d
	.byte $23, $9d, $20, $9d, $22, $9d, $23, $9d, $20, $9d, $22, $9d, $1e, $9d, $20, $9d, $1c, $9d, $1e, $9d, $1b, $9d, $1c, $9d
	.byte $19, $9d, $1f, $9d, $20, $9d, $22, $9d, $23, $9d, $20, $ff, $ff, $ff, $fd, $42
	.word @song0ch1loop
@song0ch2:
@song0ch2loop:
@song0ref329:
	.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $9f, $96
@song0ref346:
	.byte $14, $9d, $16, $9d, $17, $9d, $1b, $ff, $9d, $14, $9d, $16, $9d, $17, $9d, $1b, $ff, $bd, $1b, $9d, $19, $9d, $16, $ff
	.byte $bd, $1b, $9d, $19, $9d, $14, $ff, $9d
	.byte $41, $20
	.word @song0ref346
	.byte $41, $20
	.word @song0ref346
	.byte $14, $9d, $16, $9d, $17, $9d
@song0ref390:
	.byte $14, $fd, $1c, $fd, $19, $fd, $1b, $fd, $14, $fd, $1c, $fd, $19, $fd, $1b, $fd
	.byte $41, $10
	.word @song0ref390
	.byte $00, $ff, $ff, $bd, $14, $ff, $bd, $42
	.word @song0ch2loop
@song0ch3:
@song0ch3loop:
	.byte $41, $0f
	.word @song0ref329
	.byte $41, $0f
	.word @song0ref329
	.byte $41, $0f
	.word @song0ref329
	.byte $41, $0f
	.word @song0ref329
	.byte $42
	.word @song0ch3loop
@song0ch4:
@song0ch4loop:
	.byte $41, $0f
	.word @song0ref329
	.byte $41, $0f
	.word @song0ref329
	.byte $41, $0f
	.word @song0ref329
	.byte $41, $0f
	.word @song0ref329
	.byte $42
	.word @song0ch4loop
@song1ch0:
	.byte $ff, $ff, $ff, $ff, $cf, $48, $ff, $ff, $ff, $ff, $cf, $48, $9e
@song1ref14:
	.byte $1d, $87, $00, $87, $20, $87, $00, $85, $24, $85, $00, $87, $29, $87, $00, $85, $2c, $87, $00, $87, $30, $87, $00, $85
	.byte $33, $85, $00, $87, $35, $87, $00, $85, $31, $87, $00, $87, $2e, $87, $00, $85, $29, $85, $00, $87, $25, $87, $00, $85
	.byte $22, $c7, $24, $87, $00, $87, $28, $87, $00, $85, $2b, $85, $00, $87, $30, $87, $00, $85, $34, $87, $00, $87, $37, $87
	.byte $00, $85, $35, $85, $00, $87, $34, $87, $00, $85, $35, $87, $00, $87, $30, $87, $00, $85, $2c, $85, $00, $87, $2b, $87
	.byte $00, $85, $29, $c7, $48
	.byte $41, $64
	.word @song1ref14
@song1ch0loop:
	.byte $47, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $7f
@song1ref123:
	.byte $1d, $91, $20, $8f, $24, $8f, $29, $8f, $2c, $91, $30, $8f, $33, $8f, $35, $8f, $31, $91, $2e, $8f, $29, $8f, $25, $8f
	.byte $22, $c7, $24, $91, $28, $8f, $2b, $8f, $30, $8f, $34, $91, $37, $8f, $35, $8f, $34, $8f, $35, $91, $30, $8f, $2c, $8f
	.byte $2b, $8f, $29, $c7, $48
	.byte $41, $34
	.word @song1ref123
@song1ref179:
	.byte $48, $20, $8f, $00, $24, $8f, $27, $8d, $00, $2c, $8f, $30, $8f, $00, $33, $8f, $30, $8d, $00, $2c, $8f, $33, $8f, $00
	.byte $37, $8f, $3a, $8d, $00, $37, $8f, $33, $c7, $31, $8f, $00, $35, $8f, $38, $8d, $00, $35, $8f, $31, $8f, $00, $2c, $8f
	.byte $29, $8d, $00, $25, $8f, $20, $8f, $00, $24, $8f, $27, $8d, $00, $2c, $8f, $30, $a3, $2e, $a1
	.byte $41, $42
	.word @song1ref179
	.byte $48, $28, $87, $00, $87, $2b, $87, $00, $85, $2e, $85, $00, $87, $31, $87, $00, $85, $34, $a3, $31, $a1, $2b, $87, $00
	.byte $87, $2e, $85, $00, $87, $31, $85, $00, $87, $34, $87, $00, $85, $37, $a3, $34, $a1, $2e, $91, $31, $8f, $34, $8f, $37
	.byte $8f, $31, $91, $34, $8f, $37, $8f, $3a, $8f, $34, $91, $37, $8f, $3a, $8f, $3d, $8f, $3d, $91, $34, $8f, $2b, $8f, $22
	.byte $8f, $42
	.word @song1ch0loop
@song1ch1:
	.byte $a2
@song1ref326:
	.byte $40, $4d, $87, $3c, $87, $38, $87, $35, $85, $3c, $87, $38, $85, $35, $87, $30, $85, $38, $89, $35, $85, $30, $87, $2c
	.byte $85, $35, $87, $30, $85, $2c, $87, $29, $85, $3d, $87, $38, $87, $35, $87, $31, $85, $38, $87, $35, $85, $31, $87, $2c
	.byte $85, $35, $89, $30, $85, $2c, $87, $29, $85, $30, $87, $2c, $85, $29, $87, $24, $85, $3a, $87, $35, $87, $31, $87, $2e
	.byte $85, $35, $87, $31, $87, $2e, $85, $29, $85, $31, $89, $2e, $85, $29, $87, $25, $85, $2e, $87, $29, $85, $25, $87, $22
	.byte $85, $35, $87, $31, $87, $2e, $87, $29, $85, $31, $87, $2e, $85, $29, $87, $25, $85, $2e, $89, $29, $85, $25, $87, $22
	.byte $85, $2b, $87, $28, $87, $25, $85, $22, $85, $40, $4c, $87, $3c, $87, $37, $87, $34, $85, $3c, $87, $37, $85, $34, $87
	.byte $30, $85, $37, $89, $34, $85, $30, $87, $2b, $85, $34, $87, $30, $85, $2b, $87, $28, $85, $30, $87, $2b, $87, $28, $87
	.byte $24, $85, $2b, $85, $28, $87, $24, $87, $1f, $85, $28, $87, $24, $87, $1f, $87, $1c, $85, $24, $85, $1f, $87, $1c, $87
	.byte $18, $85
	.byte $41, $20
	.word @song1ref326
	.byte $30, $87, $2c, $87, $29, $87, $24, $85, $2c, $85, $29, $87, $24, $87, $20, $85, $29, $87, $24, $87, $20, $87, $1d, $85
	.byte $24, $85, $20, $87, $1d, $87, $18, $85, $9c
	.byte $41, $64
	.word @song1ref14
	.byte $41, $64
	.word @song1ref14
@song1ch1loop:
	.byte $7f, $9c
@song1ref565:
	.byte $20, $91, $24, $8f, $29, $8f, $2c, $8f, $30, $91, $33, $8f, $35, $8f, $38, $8f, $33, $91, $31, $8f, $2e, $8f, $29, $8f
	.byte $25, $c7, $28, $91, $2b, $8f, $30, $8f, $34, $8f, $37, $91, $3a, $8f, $38, $8f, $37, $8f, $38, $91, $33, $8f, $30, $8f
	.byte $2e, $8f, $2c, $c7
	.byte $41, $34
	.word @song1ref565
	.byte $a0, $2c, $ff, $91, $33, $ff, $91
@song1ref627:
	.byte $31, $ff, $91, $9a, $3f, $87, $3c, $87, $38, $87, $37, $85, $3c, $85, $38, $87, $37, $87, $33, $85, $38, $87, $37, $87
	.byte $33, $87, $30, $85, $37, $85, $33, $87, $30, $87, $2c, $85, $a0, $2c, $ed, $27, $8f, $2c, $8f, $33, $c7, $33, $87, $37
	.byte $87, $33, $87, $2e, $85, $33, $85, $37, $87, $33, $87, $2e, $85
	.byte $41, $23
	.word @song1ref627
	.byte $40, $4c, $87, $3d, $87, $3a, $87, $37, $85, $3d, $87, $3a, $87, $37, $85, $34, $85, $3a, $89, $37, $87, $34, $85, $31
	.byte $85, $37, $87, $34, $87, $31, $85, $2e, $85, $3d, $87, $3a, $87, $37, $87, $34, $85, $3a, $87, $37, $87, $34, $85, $31
	.byte $85, $37, $89, $34, $87, $31, $85, $2e, $85, $34, $87, $31, $87, $2e, $85, $2b, $85, $3a, $87, $37, $87, $34, $87, $31
	.byte $85, $37, $87, $34, $87, $31, $85, $2e, $85, $34, $89, $31, $87, $2e, $85, $2b, $85, $31, $87, $2e, $87, $2b, $85, $28
	.byte $85, $37, $87, $34, $87, $31, $87, $2e, $85, $34, $87, $31, $87, $2e, $85, $2b, $85, $31, $89, $2e, $87, $2b, $85, $28
	.byte $85, $2e, $87, $2b, $87, $28, $85, $25, $85, $42
	.word @song1ch1loop
@song1ch2:
	.byte $8e, $1d, $ff, $91, $19, $c7, $18, $c7, $16, $ff, $db, $17, $c7, $18, $ff, $91, $1c, $ff, $91, $1d, $c7, $18, $c7, $14
	.byte $c7, $13, $c7, $1d, $c7, $19, $a3, $18, $a1, $16, $c7, $16, $a3, $17, $a1, $18, $c7, $1c, $c7, $1d, $a3, $18, $a1, $14
	.byte $a3, $13, $a1, $11, $c7, $14, $c7, $16, $c7, $1d, $a3, $19, $a1, $18, $c7, $1c, $c7, $1d, $ff, $91
@song1ch2loop:
	.byte $8e, $1d, $89, $00, $85, $1d, $87, $00, $85, $1d, $85, $00, $87, $1d, $87, $00, $85, $19, $87, $00, $87, $19, $87, $00
	.byte $85, $18
@song1ref918:
	.byte $a1, $16, $87, $00, $87, $16, $87, $00, $85, $16, $85, $00, $87, $16, $87, $00, $85, $16, $87, $00, $87, $16, $87, $00
	.byte $85, $17
@song1ref944:
	.byte $a1, $18, $87, $00, $87, $18, $87, $00, $85, $18, $85, $00, $87, $18, $87, $00, $85, $1c, $87, $00, $87, $1c, $87, $00
	.byte $85, $1c, $85, $00, $87, $1c, $87, $00, $85, $1d, $8d, $00, $81, $1d, $81, $00, $83, $1d, $81, $00, $81, $18, $8b, $00
	.byte $81, $18, $81, $00, $83, $18, $81, $00, $81, $14, $8d, $00, $81, $14, $81, $00, $83, $14, $81, $00, $81, $13, $8b, $00
	.byte $81, $13, $81, $00, $83, $13, $81, $00, $81, $11, $87, $00, $87, $11, $87, $00, $85, $11, $85, $00, $87, $11, $87, $00
	.byte $85, $14, $87, $00, $87, $14, $87, $00, $85, $14
	.byte $41, $11
	.word @song1ref918
	.byte $1d, $87, $00, $87, $1d, $87, $00, $85, $19
	.byte $41, $51
	.word @song1ref944
@song1ref1065:
	.byte $14, $87, $00, $87, $14, $81, $00, $83, $14, $81, $00, $81, $14, $85, $00, $87, $14, $81, $00, $83, $14, $81, $00, $81
	.byte $41, $18
	.word @song1ref1065
@song1ref1092:
	.byte $1b, $87, $00, $87, $1b, $81, $00, $83, $1b
@song1ref1101:
	.byte $81, $00, $81, $1b, $85, $00, $87, $1b, $81, $00, $83, $1b, $81, $00, $81
	.byte $41, $0c
	.word @song1ref1092
@song1ref1119:
	.byte $16, $85, $00, $87, $18, $81, $00, $83, $18, $81, $00, $81, $19, $87, $00, $87, $19, $81, $00, $83, $19, $81, $00, $81
	.byte $19, $85, $00, $87, $19, $81, $00, $83, $19, $81, $00, $81, $19, $91, $18, $8f, $19, $8f, $1b, $8f, $20, $87, $00, $87
	.byte $20, $81, $00, $83, $20
	.byte $41, $0f
	.word @song1ref1101
@song1ref1175:
	.byte $18, $87, $00, $87, $18, $81, $00, $83, $18, $81, $00, $81, $16, $85, $00, $87, $16, $81, $00, $83, $16, $81, $00, $81
	.byte $41, $18
	.word @song1ref1065
	.byte $41, $18
	.word @song1ref1065
	.byte $41, $18
	.word @song1ref1092
	.byte $41, $0c
	.word @song1ref1092
	.byte $41, $35
	.word @song1ref1119
	.byte $41, $0f
	.word @song1ref1101
	.byte $41, $18
	.word @song1ref1175
	.byte $9e, $10, $87, $00, $87, $13, $81, $00, $83, $13, $81, $00, $81, $16, $85, $00, $87, $19, $87, $00, $85, $1c, $a3, $19
	.byte $a1, $13, $87, $00, $87, $16, $81, $00, $83, $16, $81, $00, $81, $19, $85, $00, $87, $1c, $87, $00, $85, $1f, $a3, $1c
	.byte $a1, $16, $91, $19, $8f, $1c, $8f, $1f, $8f, $19, $91, $1c, $8f, $1f, $8f, $22, $8f, $1c, $91, $1f, $8f, $22, $8f, $25
	.byte $8f, $28, $c7, $42
	.word @song1ch2loop
@song1ch3:
@song1ref1298:
	.byte $8c, $21, $91, $80, $21, $8f, $8c, $21, $8f, $80, $21, $8f, $8c, $21, $91, $80, $21, $8f, $8c, $21, $8f, $80, $21, $8f
	.byte $41, $10
	.word @song1ref1298
	.byte $41, $10
	.word @song1ref1298
	.byte $41, $10
	.word @song1ref1298
	.byte $41, $10
	.word @song1ref1298
	.byte $41, $10
	.word @song1ref1298
@song1ref1337:
	.byte $82, $27
@song1ref1339:
	.byte $91, $80, $21, $8f, $8c, $21, $8f, $80, $21, $8f, $82, $27, $91, $80, $21, $8f, $8c, $21, $8f, $80, $21, $8f
	.byte $41, $10
	.word @song1ref1337
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $84, $14
	.byte $41, $0f
	.word @song1ref1339
	.byte $82, $27, $91, $00, $8f
@song1ref1404:
	.byte $27, $8f, $84, $14, $8f, $82, $27, $91, $84, $14, $8f, $82, $27, $8f, $84, $14, $8f
@song1ch3loop:
@song1ref1422:
	.byte $14, $91, $14, $8f, $82, $27, $8f, $88, $30, $87, $00, $85
@song1ref1434:
	.byte $84, $14, $91, $14, $8f, $82, $27, $8f, $88, $30, $87
@song1ref1445:
	.byte $00, $85, $84, $14, $91, $14, $8f, $82, $27, $8f, $88, $30, $87, $84, $14, $85
	.byte $41, $1c
	.word @song1ref1422
	.byte $00, $85, $82, $27, $91, $84, $14, $8f, $82
	.byte $41, $0c
	.word @song1ref1404
	.byte $41, $1e
	.word @song1ref1422
	.byte $41, $1c
	.word @song1ref1422
	.byte $00, $85, $82, $27, $91, $84, $14, $8f, $82
	.byte $41, $0c
	.word @song1ref1404
@song1ref1494:
	.byte $14, $91, $88, $30, $81, $00, $83, $30, $81, $00, $81, $82, $27, $8f, $88, $30, $81, $00, $83, $30, $81, $00, $81, $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $84
	.byte $41, $14
	.word @song1ref1494
	.byte $41, $12
	.word @song1ref1434
	.byte $41, $0c
	.word @song1ref1445
	.byte $41, $1c
	.word @song1ref1422
	.byte $00, $85, $82, $27, $91, $84, $14, $8f, $82
	.byte $41, $0c
	.word @song1ref1404
	.byte $42
	.word @song1ch3loop
@song1ch4:
@song1ref1601:
	.byte $ff, $ff, $ff, $ff, $cf, $ff, $ff, $ff, $ff, $cf, $ff, $ff, $ff, $ff, $cf, $ff, $ff, $ff, $ff, $cf
@song1ch4loop:
	.byte $41, $14
	.word @song1ref1601
	.byte $ff, $ff, $ff, $ff, $cf, $42
	.word @song1ch4loop
@song2ch0:
@song2ch0loop:
	.byte $47, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $a4
@song2ref6:
	.byte $22
@song2ref7:
	.byte $85, $00, $87, $24, $85, $00, $87, $25, $85, $00, $99, $25, $85, $00, $99, $22, $85, $00, $99, $25
	.byte $41, $13
	.word @song2ref7
@song2ref30:
	.byte $48, $25, $85, $00, $87, $24, $85, $00, $87, $25
@song2ref40:
	.byte $85, $00, $99, $27, $85, $00, $87, $25, $85, $00, $87, $27
	.byte $41, $0c
	.word @song2ref40
	.byte $85, $00, $99, $25, $85, $00, $99, $22, $85, $00, $99, $48
	.byte $41, $15
	.word @song2ref6
	.byte $41, $13
	.word @song2ref7
	.byte $41, $15
	.word @song2ref30
	.byte $41, $0c
	.word @song2ref40
	.byte $85, $00, $99, $25, $85, $00, $99, $22, $85, $00, $99
@song2ref90:
	.byte $48, $22
@song2ref92:
	.byte $85, $00, $87, $24, $85, $00, $87, $25, $85, $00, $87, $16, $85, $00, $87
@song2ref107:
	.byte $25, $85, $00, $87, $16, $85, $00, $87, $22, $85, $00, $87, $16, $85, $00, $87, $25
	.byte $41, $1f
	.word @song2ref92
	.byte $48, $25
	.byte $41, $0f
	.word @song2ref92
@song2ref132:
	.byte $27, $85, $00, $87, $25, $85, $00, $87, $27, $85, $00, $87, $16, $85, $00, $87
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref107
	.byte $41, $21
	.word @song2ref90
	.byte $41, $1f
	.word @song2ref92
	.byte $48, $25
	.byte $41, $0f
	.word @song2ref92
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref107
	.byte $41, $21
	.word @song2ref90
	.byte $41, $1f
	.word @song2ref92
	.byte $48, $25
	.byte $41, $0f
	.word @song2ref92
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref107
	.byte $41, $21
	.word @song2ref90
	.byte $41, $1f
	.word @song2ref92
	.byte $48, $25
	.byte $41, $0f
	.word @song2ref92
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref107
	.byte $48, $25
@song2ref216:
	.byte $85, $00, $87, $27, $85, $00, $87, $29, $85, $00, $87, $19, $85, $00, $87
@song2ref231:
	.byte $29, $85, $00, $87, $19, $85, $00, $87, $25, $85, $00, $87, $19, $85, $00, $87, $29
	.byte $41, $1f
	.word @song2ref216
	.byte $48, $29
	.byte $41, $0f
	.word @song2ref216
@song2ref256:
	.byte $2a, $85, $00, $87, $29, $85, $00, $87, $2a, $85, $00, $87, $19, $85, $00, $87
	.byte $41, $10
	.word @song2ref256
	.byte $41, $0c
	.word @song2ref231
	.byte $15, $85, $00, $87
	.byte $41, $21
	.word @song2ref90
	.byte $41, $1f
	.word @song2ref92
	.byte $48, $25
	.byte $41, $0f
	.word @song2ref92
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref132
	.byte $41, $10
	.word @song2ref107
	.byte $42
	.word @song2ch0loop
@song2ch1:
@song2ch1loop:
	.byte $ff, $ff, $9f, $ff, $ff, $9f, $ff, $ff, $9f, $ff, $fb, $a6
@song2ref318:
	.byte $22, $8f, $00, $8f, $29, $ff, $f1, $00, $a9, $ff, $fb, $22, $8f, $00, $8f, $29, $ff, $f1, $00, $a9, $ff, $fb
	.byte $41, $16
	.word @song2ref318
	.byte $22, $8f, $00, $8f, $29, $ff, $f1, $00, $a9, $ff, $fb, $21, $8f, $00, $8f, $29, $ff, $f1, $00, $a9, $ff, $ff, $9f, $42
	.word @song2ch1loop
@song2ch2:
@song2ch2loop:
	.byte $90
@song2ref371:
	.byte $16, $a1, $00, $a1, $11, $a1, $00, $a1, $16, $a1, $00, $a1, $11, $a1, $00, $a1
	.byte $41, $10
	.word @song2ref371
@song2ref390:
	.byte $8e, $16, $99, $00, $a9, $90, $11, $a1, $00, $a1, $8e, $16, $99, $00, $a9, $90, $11, $a1, $00, $a1
	.byte $41, $10
	.word @song2ref390
	.byte $41, $10
	.word @song2ref390
	.byte $41, $10
	.word @song2ref390
	.byte $41, $10
	.word @song2ref390
	.byte $41, $10
	.word @song2ref390
	.byte $9c
@song2ref426:
	.byte $22, $8f, $00, $8f, $24, $8f, $00, $8f
@song2ref434:
	.byte $25, $a1, $22, $99, $00, $85, $27, $a1, $25, $85, $00, $87, $24, $87, $00, $85
	.byte $41, $10
	.word @song2ref434
@song2ref453:
	.byte $25, $a1, $22, $a1, $25, $8f, $00, $8f, $22, $8f, $00, $8f, $1d, $c5
	.byte $41, $18
	.word @song2ref426
	.byte $41, $10
	.word @song2ref434
	.byte $41, $0e
	.word @song2ref453
	.byte $25, $8f, $00, $8f, $27, $8f, $00
@song2ref483:
	.byte $8f, $29, $a1, $25, $99, $00, $85, $2a, $a1, $29, $8f, $27
	.byte $41, $0c
	.word @song2ref483
	.byte $8f, $29, $a1, $25, $a1, $29, $8f, $00, $8f, $25, $8f, $00, $8f, $20, $c5
	.byte $41, $18
	.word @song2ref426
	.byte $41, $10
	.word @song2ref434
	.byte $41, $0e
	.word @song2ref453
	.byte $42
	.word @song2ch2loop
@song2ch3:
@song2ch3loop:
	.byte $84
@song2ref527:
	.byte $25, $a1, $00, $a1, $24, $a1, $00, $a1, $25, $a1, $00, $a1, $24, $a1, $00, $a1
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $41, $10
	.word @song2ref527
	.byte $42
	.word @song2ch3loop
@song2ch4:
@song2ch4loop:
@song2ref592:
	.byte $ff, $ff, $9f, $ff, $ff, $9f, $ff, $ff, $9f, $ff, $ff, $9f
	.byte $41, $0c
	.word @song2ref592
	.byte $41, $0c
	.word @song2ref592
	.byte $41, $0c
	.word @song2ref592
	.byte $42
	.word @song2ch4loop
@song3ch0:
@song3ch0loop:
	.byte $47, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $79, $92, $19, $fd, $1b, $ad, $20, $ad, $94, $1d, $9d, $48
	.byte $43, $1d, $fd, $92, $1d, $ad, $1b, $ad, $19, $9d, $48, $19, $dd, $1d, $8d, $20, $8d, $25, $ad, $24, $ad, $20, $9d, $48
	.byte $94, $20, $fd, $92, $19, $8d, $1b, $8d, $1d, $8d, $1b, $8d, $00, $8d, $19, $ad, $48, $19, $fd, $1b, $ad, $20, $ad, $94
	.byte $20, $9d, $48, $43, $20, $fd, $92, $1d, $ad, $1b, $ad, $19, $9d, $48, $19, $ad, $14, $ad, $1d, $9d, $1b, $ad, $18, $ad
	.byte $1d, $9d, $48, $1e, $ad, $1d, $cd, $19, $8d, $1b, $8d, $1d, $8d, $1b, $8d, $00, $8d, $19, $ad, $48, $2a, $8d, $29, $8d
	.byte $25, $8d, $2a, $8d, $29, $8d, $25, $8d, $2a, $8d, $29, $8d, $25, $8d, $2a, $8d, $29, $8d, $25, $8d, $2a, $8d, $29, $8d
	.byte $25, $8d, $29, $8d, $48, $2c, $8d, $27, $8d, $25, $8d, $2c, $8d, $27, $8d, $25, $8d, $2c, $8d, $27, $8d, $25, $8d, $2c
	.byte $8d, $27, $8d, $25, $8d, $2c, $8d, $27, $8d, $25, $8d, $27, $8d, $48, $29, $ad, $2c, $ad, $2a, $9d, $00, $fd, $48, $ff
	.byte $ff, $42
	.word @song3ch0loop
@song3ch1:
@song3ch1loop:
	.byte $ff, $ff, $ff, $ff, $ff, $ff, $94, $22, $fd, $92, $1d, $8d, $1e, $8d, $20, $8d, $1e, $8d, $00, $8d, $1d, $ad, $1d, $ff
	.byte $dd, $94, $1d, $9d, $43, $1d, $fd, $92, $25, $8d, $24, $8d, $20, $8d, $25, $8d, $24, $8d, $20, $8d, $25, $8d, $24, $8d
	.byte $20, $dd, $19, $8d, $20, $8d, $25, $ad, $24, $ad, $20, $9d, $20, $fd, $1d, $8d, $1e, $8d, $20, $8d, $1e, $8d, $00, $8d
	.byte $1d, $ad, $25, $89, $00, $81, $24, $89, $00, $81, $1e, $89, $00, $81, $25, $89, $00, $81, $24, $89, $00, $81, $1e, $89
	.byte $00, $81, $25, $89, $00, $81, $24, $89, $00, $81, $1e, $89, $00, $81, $25, $89, $00, $81, $24, $89, $00, $81, $1e, $89
	.byte $00, $81, $25, $89, $00, $81, $24, $89, $00, $81, $20, $8d, $24, $8d, $25, $8d, $24, $8d, $20, $8d, $25, $8d, $24, $8d
	.byte $20, $8d, $25, $8d, $24, $8d, $20, $8d, $25, $8d, $24, $8d, $20, $8d, $25, $8d, $24, $8d, $20, $8d, $24, $8d, $00, $ff
	.byte $fd, $ff, $ff, $42
	.word @song3ch1loop
@song3ch2:
@song3ch2loop:
	.byte $8e
@song3ref366:
	.byte $19, $85, $00, $85, $19, $85, $00, $85, $19, $85, $00, $85, $19, $85, $00, $85, $19, $85, $00, $85, $19, $85, $00, $85
	.byte $19, $85, $00, $85, $19
@song3ref395:
	.byte $85, $00, $85
@song3ref398:
	.byte $14, $85, $00, $85, $14, $85, $00, $85, $14, $85, $00, $85, $14, $85, $00, $85, $14, $85, $00, $85, $14, $85, $00, $85
	.byte $14, $85, $00, $85, $14
@song3ref427:
	.byte $85, $00, $85, $16, $85, $00, $85, $16, $85, $00, $85, $16, $85, $00, $85, $16, $85, $00, $85, $16, $85, $00, $85, $16
	.byte $85, $00, $85, $16, $85, $00, $85, $16
	.byte $41, $20
	.word @song3ref427
@song3ref462:
	.byte $85, $00, $85, $12, $85, $00, $85, $12, $85, $00, $85, $12, $85, $00, $85, $12, $85, $00, $85, $12, $85, $00, $85, $12
	.byte $85, $00, $85, $12, $85, $00, $85, $12
	.byte $41, $40
	.word @song3ref395
	.byte $41, $23
	.word @song3ref395
	.byte $41, $5d
	.word @song3ref366
	.byte $41, $20
	.word @song3ref427
	.byte $41, $20
	.word @song3ref462
	.byte $41, $40
	.word @song3ref395
	.byte $41, $23
	.word @song3ref395
	.byte $12
	.byte $41, $20
	.word @song3ref462
	.byte $41, $1f
	.word @song3ref462
	.byte $41, $20
	.word @song3ref398
	.byte $41, $2c
	.word @song3ref398
	.byte $14, $85, $00, $85, $14, $85, $00, $85, $14, $85, $00, $85, $12, $85, $00, $85, $12, $85, $00, $85, $19, $85, $00, $85
	.byte $19, $85, $00, $85, $19, $85, $00, $85, $16, $85, $00, $85, $16, $85, $00, $85, $16, $85, $00, $85, $14, $85, $00, $85
	.byte $14, $85, $00, $85, $ff, $ff, $42
	.word @song3ch2loop
@song3ch3:
@song3ch3loop:
	.byte $7c, $86
@song3ref588:
	.byte $19, $81, $00, $89, $8a, $22, $8d, $1e, $81, $00, $89, $22, $8d, $86, $19, $81, $00, $89, $19, $81, $00, $89, $8a, $1e
	.byte $81, $00, $89, $22, $8d, $86, $19, $81, $00, $89, $8a, $22, $8d, $1e, $81, $00, $89, $86, $19, $81, $00, $89, $8a, $22
	.byte $8d, $86, $19, $81, $00, $89, $8a, $1e, $81, $00, $89, $22, $8d, $86, $19, $81, $00, $89, $8a, $22, $8d, $1e, $81, $00
	.byte $89, $22, $8d, $86, $19, $81, $00, $89, $19, $81, $00, $89, $8a, $1e, $81, $00, $89, $22, $8d, $86, $19, $81, $00, $89
	.byte $19, $81, $00, $89, $8a, $1e, $81, $00, $89, $86, $19, $81, $00, $89, $8a, $1e, $81, $00, $89, $86, $19, $81, $00, $89
	.byte $8a, $1e, $81, $00, $89, $86, $19, $81, $00, $89
	.byte $41, $6e
	.word @song3ref588
	.byte $41, $6e
	.word @song3ref588
	.byte $41, $6e
	.word @song3ref588
	.byte $41, $6e
	.word @song3ref588
	.byte $ff, $ff, $ff, $ff, $42
	.word @song3ch3loop
@song3ch4:
@song3ch4loop:
	.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	.byte $42
	.word @song3ch4loop