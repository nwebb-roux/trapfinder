:: Includes
ca65 src/macros/state.asm

:: Core
ca65 src/main.asm
ca65 src/core/reset.asm
ca65 src/core/nmi.asm
ca65 src/core/irq.asm
ca65 src/core/controller.asm

:: Title Screen
ca65 src/title_screen/main.asm
ca65 src/title_screen/load_palettes.asm
ca65 src/title_screen/load_background.asm
ca65 src/title_screen/jewel_sprite.asm
ca65 src/title_screen/controller.asm

:: Dungeon
ca65 src/dungeon/main.asm
ca65 src/dungeon/load_palettes.asm
ca65 src/dungeon/load_background.asm
ca65 src/dungeon/controller.asm
ca65 src/dungeon/player_sprite.asm
ca65 src/dungeon/map_collision.asm

ld65 src/title_screen/*.o src/dungeon/*.o src/core/*.o src/*.o -C nes.cfg -o Trapfinder.nes

del /S src/*.o src/title_screen/*.o src/dungeon/*.o src/core/*.o src/macros/*.o