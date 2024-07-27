.segment "RODATA"
dungeon_palettes:
	; cavern - grass, stone, unused, status bar
	.byte $00,$2D,$1A,$29, $00,$2D,$10,$0F, $00,$2D,$10,$0F, $00,$15,$20,$0F
	; dungeon - mossy bricks, stone and pillars, unused, status bar
	.byte $00,$2D,$1A,$0F, $00,$2D,$10,$0F, $00,$2D,$10,$0F, $00,$15,$20,$0F
	; marble - floor, statues/columns, jugs/water, status bar
	.byte $20,$10,$00,$0F, $20,$10,$32,$00, $20,$10,$1C,$00, $20,$15,$20,$0F
	; palace - red rug, wood/jugs, blue rug, status bar
	.byte $37,$15,$27,$39, $37,$27,$17,$06, $37,$12,$21,$33, $37,$15,$20,$0F
	; hell - hot brick, statue, coals/burning angled floor, status bar
	.byte $0F,$06,$16,$07, $0F,$06,$16,$27, $0F,$15,$27,$39, $0F,$15,$20,$0F

sprite_palettes:
	; character, chest, unused, stairs
	; cavern
	.byte $00,$36,$15,$0F, $00,$17,$27,$37, $00,$1C,$15,$14, $00,$2D,$10,$0F
	; dungeon
	.byte $00,$36,$15,$0F, $00,$17,$27,$37, $00,$1C,$15,$14, $00,$2D,$10,$0F
	; marble
	.byte $20,$36,$15,$0F, $20,$14,$30,$35, $20,$30,$32,$00, $20,$30,$10,$00
	; palace
	.byte $37,$36,$15,$0F, $37,$11,$30,$32, $37,$1C,$15,$14, $37,$27,$17,$06
	; hell
	.byte $0F,$36,$15,$0E, $0F,$15,$27,$39, $0F,$1C,$15,$14, $0F,$16,$27,$06