setlocal EnableDelayedExpansion

:: Includes
ca65 src\macros\state.asm

:: Core
ca65 src\main.asm
ca65 src\core\reset.asm
ca65 src\core\nmi.asm
ca65 src\core\irq.asm
ca65 src\core\controller.asm
ca65 src\core\rng.asm
ca65 src\core\decimal.asm

:: Audio
ca65 src/audio/famistudio_ca65.s
ca65 src/audio/audio.asm

:: Title Screen
ca65 src\title_screen\main.asm
ca65 src\title_screen\load_palettes.asm
ca65 src\title_screen\load_background.asm
ca65 src\title_screen\jewel_sprite.asm
ca65 src\title_screen\controller.asm

:: Dungeon
ca65 src\dungeon\main.asm
ca65 src\dungeon\load_palettes.asm
ca65 src\dungeon\load_background.asm
ca65 src\dungeon\draw_background.asm
ca65 src\dungeon\controller.asm
ca65 src\dungeon\player_sprite.asm
ca65 src\dungeon\map_collision.asm
ca65 src\dungeon\load_treasure.asm
ca65 src\dungeon\draw_treasure.asm
ca65 src\dungeon\treasure_logic.asm

:: Dialogue
ca65 src\dialogue\main.asm
ca65 src\dialogue\load_palettes.asm
ca65 src\dialogue\render_dialogue.asm
ca65 src\dialogue\controller.asm

set "FILES="

for /R %%f in (*.o) do (
    set "FILES=!FILES! %%f"
)
ld65 %FILES% -C nes.cfg -o Trapfinder.nes

del src\*.o src\title_screen\*.o src\dungeon\*.o src\dialogue\*.o src\core\*.o src\macros\*.o