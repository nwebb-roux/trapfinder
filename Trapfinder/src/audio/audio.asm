.segment "BSS"
.import DUNGEON_FLOOR

.segment "CODE"
.export audio_init
.proc audio_init
	; load music data address from "trapfinder_music.s"
	LDX #.lobyte(music_data_trapfinder)
	LDY #.hibyte(music_data_trapfinder)

	; non-zero for NTSC
	LDA #1
    JSR famistudio_init

	RTS
.endproc

.export audio_title_screen
.proc audio_title_screen
	JSR famistudio_music_stop
	LDA #0
    JSR famistudio_music_play
	RTS
.endproc

.export audio_dungeon
.proc audio_dungeon
	JSR famistudio_music_stop
	LDX DUNGEON_FLOOR
	LDA dungeon_tracks, X
    JSR famistudio_music_play
	RTS
.endproc

; dungeon music lookup table - translates floor to music track
dungeon_tracks:
	.byte $01, $02, $03, $01, $01

.import famistudio_init
.import famistudio_music_play
.import famistudio_music_stop
.import famistudio_music_pause
.include "trapfinder_music.s"