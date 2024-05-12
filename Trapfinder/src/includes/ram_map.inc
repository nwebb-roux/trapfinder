.segment "BSS"
; .export ram_res
; .proc ram_res
; **** CUSTOM MEMORY MAP FOR THE FREE RAM ($0300-$07FF) ****

; helper for when we need more than X and Y to loop
COUNTER: .res 1 ; $0300
; stores which floor group of the dungeon (cavern, dungeon, marble, etc.) the player is on
; 0-4
DUNGEON_FLOOR: .res 1 ; $0301
; the offset for this dungeon floor (0, 16, 32, 48, or 64)
DUNGEON_FLOOR_OFFSET: .res 1 ; $0302

; attribute map, based on screen map. 64 bytes plus $FF to end
SCREEN_MAP_ATTRIBUTES: .res 64 ; $0303
SCREEN_MAP_ATTRIBUTES_END: .res 1 ; $0343
ATTRIBUTE_MASK: .res 1 ; $0344

; another counter helper
COUNTER_X: .res 1 ; $0345

; background palette 1, used for animations
; 4 bytes: $0346, 7, 8, 9
BG_PAL_1: .res 4 ; $0346
BG_PAL_FLAG: .res 1 ; $034A

; dungeon map currently on the screen, 13 metatiles high and 16 metatiles wide
; 240 bytes + $FF to end ($F1 in hex, so from $0400 to $04F0 inclusive)
SCREEN_MAP: .res 240 ; $0400			; holds the terrain type/state data
SCREEN_MAP_END: .res 1 ; $04F0
SCREEN_MAP_SECOND_PASS: .res 1 ; $04F1 ; flag for whether we're looping over a metatile row for the 2nd time
SCREEN_MAP_LOCATION: .res 1 ; $04F2

COLLISION_TABLE: .res 16 ; $0500		; holds the collision lookup table, 0-15
.export COUNTER, DUNGEON_FLOOR, DUNGEON_FLOOR_OFFSET, SCREEN_MAP_ATTRIBUTES, SCREEN_MAP_ATTRIBUTES_END, ATTRIBUTE_MASK, COUNTER_X, BG_PAL_1, BG_PAL_FLAG, SCREEN_MAP,SCREEN_MAP_END,SCREEN_MAP_SECOND_PASS,SCREEN_MAP_LOCATION, COLLISION_TABLE
; .endproc