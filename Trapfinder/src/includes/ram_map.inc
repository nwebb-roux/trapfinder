.segment "BSS"
; **** CUSTOM MEMORY MAP FOR THE FREE RAM ($0300-$07FF) ****

; helper for when we need more than X and Y to loop
COUNTER: .res 1

; stores which floor group of the dungeon (cavern, dungeon, marble, etc.) the player is on
DUNGEON_FLOOR: .res 1

; the offset for this dungeon floor (0, 16, 32, 48, or 64)
DUNGEON_FLOOR_OFFSET: .res 1

; attribute map, based on screen map. 64 bytes plus $FF to end
SCREEN_MAP_ATTRIBUTES: .res 64
SCREEN_MAP_ATTRIBUTES_END: .res 1
ATTRIBUTE_MASK: .res 1

; another counter helper
COUNTER_X: .res 1

; background palette 1, used for animations
BG_PAL_1: .res 4
BG_PAL_FLAG: .res 1

; dungeon map currently on the screen, 13 metatiles high and 16 metatiles wide
SCREEN_MAP: .res 240 ; holds the terrain type/state data
SCREEN_MAP_END: .res 1
SCREEN_MAP_SECOND_PASS: .res 1 ; flag for whether we're looping over a metatile row for the 2nd time
SCREEN_MAP_LOCATION: .res 1

; holds the collision lookup table, 0-15
COLLISION_TABLE: .res 16

.export COUNTER, DUNGEON_FLOOR, DUNGEON_FLOOR_OFFSET, SCREEN_MAP_ATTRIBUTES, SCREEN_MAP_ATTRIBUTES_END, ATTRIBUTE_MASK, COUNTER_X, BG_PAL_1, BG_PAL_FLAG, SCREEN_MAP,SCREEN_MAP_END,SCREEN_MAP_SECOND_PASS,SCREEN_MAP_LOCATION, COLLISION_TABLE
; .endproc