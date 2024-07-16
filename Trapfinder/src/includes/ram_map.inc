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

; stores which floor group of the dungeon (cavern, dungeon, marble, etc.) the player is on
DUNGEON_FLOOR: .res 1

; the offset for this dungeon floor (0, 16, 32, 48, or 64)
DUNGEON_FLOOR_OFFSET: .res 1

; attribute map, based on screen map. 64 bytes plus $FF to end
SCREEN_MAP_ATTRIBUTES: .res 64
SCREEN_MAP_ATTRIBUTES_END: .res 1
ATTRIBUTE_MASK: .res 1

; dungeon map currently on the screen, 13 metatiles high and 16 metatiles wide
SCREEN_MAP: .res 240 ; holds the terrain type/state data
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

.export COUNTER, DUNGEON_FLOOR, DUNGEON_FLOOR_OFFSET, SCREEN_MAP_ATTRIBUTES, SCREEN_MAP_ATTRIBUTES_END, ATTRIBUTE_MASK, SCRATCH_B, SCREEN_MAP,SCREEN_MAP_END,SCREEN_MAP_SECOND_PASS,SCREEN_MAP_LOCATION, COLLISION_TABLE, CURRENT_DECODE_VALUE, CURRENT_DECODE_LENGTH, METATILES_DECODED, CURRENT_DECODE_BYTE, SCRATCH_C, SCRATCH_D, ANIMATION_FRAME, ANIMATION_LOCATION, DRAWBUFFER_OFFSET, DRAWBUFFER, STACK_POINTER, SCRATCH_E