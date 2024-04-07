; iNES header
.segment "HEADER"
.byte $4e, $45, $53, $1a
.byte $02
.byte $04
.byte %00110010	; CNROM mapper (3 = 0000 0011), save RAM, horizontal mirroring
.byte %00000000	; CNROM mapper (3 = 0000 0011), no special-case flags

; the bytes we care about are summarized below
; for details and explanations of the rest, see https://www.nesdev.org/wiki/INES
; bytes 0-3: 4-byte "magic word" defining the file type
; byte 4: number of 16KB PRG banks - normal number is 2 (32KB of PRG ROM)
; byte 5: number of 8KB CHR banks - normal number is 1, any more requires bank switching - CNROM switching supports up to 4
; byte 6: Flags 6 - mapper, mirroring, battery save, trainer (what is this?)
; 7654 3210
; |||| ||||
; |||| |||+- Mirroring: 0: horizontal (vertical arrangement) (CIRAM A10 = PPU A11)
; |||| |||              1: vertical (horizontal arrangement) (CIRAM A10 = PPU A10)
; |||| ||+-- 1: Cartridge contains battery-backed PRG RAM ($6000-7FFF) or other persistent memory
; |||| |+--- 1: 512-byte trainer at $7000-$71FF (stored before PRG data)
; |||| +---- 1: Ignore mirroring control or above mirroring bit; instead provide four-screen VRAM
; ++++ ----- Lower nybble of mapper number
; byte 7: Flags 7 - mapper, NES 2.0 format, PlayChoice, VS
; 7654 3210
; |||| ||||
; |||| |||+- VS Unisystem
; |||| ||+-- PlayChoice-10 (8 KB of Hint Screen data stored after CHR data)
; |||| ++--- If equal to 2, flags 8-15 are in NES 2.0 format
; ++++ ----- Upper nybble of mapper number