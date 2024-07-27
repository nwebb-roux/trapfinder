.segment "DRAWBUFFER"
; **** CUSTOM MEMORY MAP FOR THE NAMETABLE DRAWING BUFFER ($0100-$019F) ****
; NOTE: uses a big portion of the stack page
DRAWBUFFER: .res 160

.segment "BSS"
; **** CUSTOM MEMORY MAP FOR THE FREE RAM ($0300-$07FF) ****

; helpers for when we need more than X and Y to loop
COUNTER: .res 1
SCRATCH_B: .res 1
SCRATCH_C: .res 1
SCRATCH_D: .res 1

; which zone of the dungeon (cavern, dungeon, marble, etc.) the player is on
DUNGEON_ZONE: .res 1

; exact level number (00-24)
DUNGEON_LEVEL_ONES: .res 1
DUNGEON_LEVEL_TENS: .res 1

; the offset for this dungeon zone (0, 16, 32, 48, or 64)
DUNGEON_ZONE_OFFSET: .res 1

; attribute map, based on screen map. 56 bytes plus $FF to end
SCREEN_MAP_ATTRIBUTES: .res 56
SCREEN_MAP_ATTRIBUTES_END: .res 1
ATTRIBUTE_MASK: .res 1

; dungeon map currently on the screen, 13 metatiles high and 16 metatiles wide
SCREEN_MAP: .res 208 ; holds the terrain type/state data
SCREEN_MAP_END: .res 1
SCREEN_MAP_SECOND_PASS: .res 1 ; flag for whether we're looping over a metatile row for the 2nd time
SCREEN_MAP_LOCATION: .res 1

; holds the collision lookup table, 0-15
COLLISION_TABLE: .res 16

; bg decompression variables
CURRENT_DECODE_VALUE: .res 1
CURRENT_DECODE_LENGTH: .res 1
METATILES_DECODED: .res 1
CURRENT_DECODE_BYTE: .res 1

; animation helpers - not all used
ANIMATION_FRAME: .res 1
ANIMATION_LOCATION: .res 1
DRAWBUFFER_OFFSET: .res 1

; more helpers
STACK_POINTER: .res 1
SCRATCH_E: .res 1

; PPU buffers
SOFT_PPUMASK: .res 1

; GP (aka score)
GOLD_PIECES: .res 1
HEX_VALUE: .res 1
ASCII_RESULT: .res 1

.export COUNTER, SOFT_PPUMASK, DUNGEON_ZONE, DUNGEON_LEVEL_ONES, DUNGEON_LEVEL_TENS, DUNGEON_ZONE_OFFSET, SCREEN_MAP_ATTRIBUTES, SCREEN_MAP_ATTRIBUTES_END, ATTRIBUTE_MASK, SCRATCH_B, SCREEN_MAP,SCREEN_MAP_END, SCREEN_MAP_SECOND_PASS,SCREEN_MAP_LOCATION, COLLISION_TABLE, CURRENT_DECODE_VALUE, CURRENT_DECODE_LENGTH, METATILES_DECODED, CURRENT_DECODE_BYTE, SCRATCH_C, SCRATCH_D, ANIMATION_FRAME, ANIMATION_LOCATION, DRAWBUFFER_OFFSET, DRAWBUFFER, STACK_POINTER, SCRATCH_E, GOLD_PIECES, HEX_VALUE, ASCII_RESULT