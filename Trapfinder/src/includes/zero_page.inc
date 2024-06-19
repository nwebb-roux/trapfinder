.segment "ZEROPAGE"
.export zero_page
.proc zero_page

; RNG seeds
timer: .res 2
seed0: .res 2
seed1: .res 2

; controller button states. From high to low (left to right): A, B, SELECT, START, UP, DOWN, LEFT, RIGHT
buttons: .res 1
new_buttons: .res 1

; *** PLAYER SPRITE DATA *** ;
avatar_x: .res 1
avatar_y: .res 1
; stores the CHR table location of the top left tile of the current 4-tile player metasprite
; assumes the tiles will go top left, top right, bottom left, bottom right in order 0, +1, +2, +3
avatar_tile_location: .res 1		
; stores sprite attribute byte for OAM table to be applied to ALL FOUR TILES OF PLAYER SPRITE
; if we ever need different attributes for different tiles this will have to change
; byte 7: vert. flip, byte 6: horiz. flip, byte 5: priority, bytes 1 & 0: palette
avatar_sprite_attributes: .res 1

; *** BACKGROUND METATILE DATA *** ;
collision_metatile_offset_1: .res 1
collision_metatile_offset_2: .res 1
; stores which background metatiles we should check for collision detection


; TODO: update this to store more than facing, which only needs 2 bits (4 settings)
player_sprite_facing: .res 1
player_sprite_frame: .res 1
; TODO: update this to store more than direction, which only needs 1 bits (2 settings)
player_sprite_movement: .res 1

; game state info, bit 1
; 	low three bits store current screen state, see includes/constants.inc
;		000 - title screen
;		001 - dialogue
;		010 - dungeon
;		011 - dungeon/town (can these be combined?)
;		100 - battle
;		101 - PC stats
;		110 - inventory/equipment
;		111 - ?
;	bit 3:
;	bit 4:
;	bit 5:
;	bit 6:
;	bit 7: ready to render screen
screen_state: .res 1

; place to store addresses we want to indirect index to
; store low byte, high byte
indirect_address: .res 2
indirect_address_2: .res 2

; object pool for treasure on screen--up to five treasures
; treasure flags byte, from left to right (bits 0 to 7): closed (1 bit), has trap (1 bit), trap type (2 bits), treasure type (4 bits)
treasure_flags: .res 5
treasure_x_coords: .res 5
treasure_y_coords: .res 5

; bytes for famistudio
famistudio_bytes: .res 8

.exportzp timer, seed0, seed1, buttons, new_buttons, avatar_x, avatar_y, avatar_tile_location, avatar_sprite_attributes, player_sprite_frame, player_sprite_facing, player_sprite_movement, screen_state, collision_metatile_offset_1, collision_metatile_offset_2, indirect_address, indirect_address_2, treasure_flags, treasure_x_coords, treasure_y_coords, famistudio_bytes
.endproc