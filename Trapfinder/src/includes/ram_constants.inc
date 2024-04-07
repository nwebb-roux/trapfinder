; **** CUSTOM MEMORY MAP FOR THE FREE RAM ($0300-$07FF) ****

; helper for when we need more than X and Y to loop
COUNTER = $0300
; stores which floor group of the dungeon (cavern, dungeon, marble, etc.) the player is on
; 0-4
DUNGEON_FLOOR = $0301
; the offset for this dungeon floor (0, 16, 32, 48, or 64)
DUNGEON_FLOOR_OFFSET = $0302

; attribute map, based on screen map. 64 bytes plus $FF to end
SCREEN_MAP_ATTRIBUTES = $0303
SCREEN_MAP_ATTRIBUTES_END = $0343
ATTRIBUTE_MASK = $0344

; another counter helper
COUNTER_X = $0345

; dungeon map currently on the screen, 13 metatiles high and 16 metatiles wide
; 240 bytes + $FF to end ($F1 in hex, so from $0400 to $04F0 inclusive)
SCREEN_MAP = $0400			; holds the terrain type/state data
SCREEN_MAP_END = $04F0
SCREEN_MAP_SECOND_PASS = $04F1 ; flag for whether we're looping over a metatile row for the 2nd time
SCREEN_MAP_LOCATION = $04F2

COLLISION_TABLE = $0500		; holds the collision lookup table, 0-15