.segment "RODATA"
; this takes the 255 locations of the symbol array (0-254) and translates them into positions in
; the ngrams table below. This is necessary for two reasons. First, some single characters in
; the ngrams table can end up unused, because they're only used within ngrams. Therefore we might as
; well remove them from the ngrams table to save a couple bytes, which throws off indexing in the
; ngrams table. Second, once we get into digrams (or whatever ngrams) there's no longer a one-to-on
; correlation between the index number of the ngram and its actual position in the ngrams table--
; they're offset by the lengths of the ngrams that came before them.
symbol_position_lookup:
; 44 one-character ngrams, of which only 1 is used (the .)
.byte $ff, $ff, $ff, $ff, ngrams, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

; 205 two-character ngrams
.byte ngrams+1, ngrams+4, ngrams+7, ngrams+10, ngrams+13, ngrams+16, ngrams+19, ngrams+22, ngrams+25, ngrams+28, ngrams+31, ngrams+34, ngrams+37, ngrams+40, ngrams+43, ngrams+46
.byte ngrams+49, ngrams+52, ngrams+55, ngrams+58, ngrams+61, ngrams+64, ngrams+67, ngrams+70, ngrams+73, ngrams+76, ngrams+79, ngrams+82, ngrams+85, ngrams+88, ngrams+91, ngrams+94
.byte ngrams+97, ngrams+100, ngrams+103, ngrams+106, ngrams+109, ngrams+112, ngrams+115, ngrams+118, ngrams+121, ngrams+124, ngrams+127, ngrams+130, ngrams+133, ngrams+136, ngrams+139, ngrams+142
.byte ngrams+145, ngrams+148, ngrams+151, ngrams+154, ngrams+157, ngrams+160, ngrams+163, ngrams+166, ngrams+169, ngrams+172, ngrams+175, ngrams+178, ngrams+181, ngrams+184, ngrams+187, ngrams+190
.byte ngrams+193, ngrams+196, ngrams+199, ngrams+202, ngrams+205, ngrams+208, ngrams+211, ngrams+214, ngrams+217, ngrams+220, ngrams+223, ngrams+226, ngrams+229, ngrams+232, ngrams+235, ngrams+238
.byte ngrams+241, ngrams+244, ngrams+247, ngrams+250, ngrams+253, ngrams+256, ngrams+259, ngrams+262, ngrams+265, ngrams+268, ngrams+271, ngrams+274, ngrams+277, ngrams+280, ngrams+283, ngrams+286
.byte ngrams+289, ngrams+292, ngrams+295, ngrams+298, ngrams+301, ngrams+304, ngrams+307, ngrams+310, ngrams+313, ngrams+316, ngrams+319, ngrams+322, ngrams+325, ngrams+328, ngrams+331, ngrams+334
.byte ngrams+337, ngrams+340, ngrams+343, ngrams+346, ngrams+349, ngrams+352, ngrams+355, ngrams+358, ngrams+361, ngrams+364, ngrams+367, ngrams+370, ngrams+373, ngrams+376, ngrams+379, ngrams+382
.byte ngrams+385, ngrams+388, ngrams+391, ngrams+394, ngrams+397, ngrams+400, ngrams+403, ngrams+406, ngrams+409, ngrams+412, ngrams+415, ngrams+418, ngrams+421, ngrams+424, ngrams+427, ngrams+430
.byte ngrams+433, ngrams+436, ngrams+439, ngrams+442, ngrams+445, ngrams+448, ngrams+451, ngrams+454, ngrams+457, ngrams+460, ngrams+463, ngrams+466, ngrams+469, ngrams+472, ngrams+475, ngrams+478
.byte ngrams+481, ngrams+484, ngrams+487, ngrams+490, ngrams+493, ngrams+496, ngrams+499, ngrams+502, ngrams+505, ngrams+508, ngrams+511, ngrams+514, ngrams+517, ngrams+520, ngrams+523, ngrams+526
.byte ngrams+529, ngrams+532, ngrams+535, ngrams+538, ngrams+541, ngrams+544, ngrams+547, ngrams+550, ngrams+553, ngrams+556, ngrams+559, ngrams+562, ngrams+565, ngrams+568, ngrams+571, ngrams+574
.byte ngrams+577, ngrams+580, ngrams+583, ngrams+586, ngrams+589, ngrams+592, ngrams+595, ngrams+598, ngrams+601, ngrams+604, ngrams+607, ngrams+610, ngrams+613

ngrams:
.byte ".", $ff
.byte "e", " ", $ff
.byte "t", " ", $ff
.byte " ", "y", $ff
.byte "y", "o", $ff
.byte "o", "u", $ff
.byte " ", "t", $ff
.byte "s", " ", $ff
.byte "i", "n", $ff
.byte "e", "r", $ff
.byte ".", " ", $ff
.byte " ", "w", $ff
.byte "n", "d", $ff
.byte "h", "e", $ff
.byte "u", " ", $ff
.byte "t", "h", $ff
.byte "l", "l", $ff
.byte "f", "i", $ff
.byte "v", "e", $ff
.byte "u", "r", $ff
.byte ".", ".", $ff
.byte " ", "T", $ff
.byte "r", "a", $ff
.byte "a", "p", $ff
.byte "d", "e", $ff
.byte " ", "f", $ff
.byte "e", "s", $ff
.byte "r", " ", $ff
.byte "r", "e", $ff
.byte "e", "t", $ff
.byte "n", "g", $ff
.byte ",", " ", $ff
.byte "T", "r", $ff
.byte "p", "f", $ff
.byte " ", "i", $ff
.byte " ", "a", $ff
.byte " ", "s", $ff
.byte "h", "a", $ff
.byte "a", "k", $ff
.byte "k", "e", $ff
.byte "a", "l", $ff
.byte "w", "o", $ff
.byte "o", "n", $ff
.byte " ", "m", $ff
.byte "m", "a", $ff
.byte " ", "n", $ff
.byte "c", "e", $ff
.byte "r", ".", $ff
.byte "a", "n", $ff
.byte "r", "s", $ff
.byte "a", "c", $ff
.byte "n", " ", $ff
.byte "r", "n", $ff
.byte "n", "s", $ff
.byte "l", " ", $ff
.byte "l", "e", $ff
.byte ".", " ", $ff
.byte "i", "v", $ff
.byte "w", "h", $ff
.byte "a", "t", $ff
.byte "n", "'", $ff
.byte "'", "t", $ff
.byte "o", "r", $ff
.byte "s", "e", $ff
.byte " ", "o", $ff
.byte "f", " ", $ff
.byte "e", "e", $ff
.byte "t", "i", $ff
.byte "g", "s", $ff
.byte "n", "o", $ff
.byte "v", "i", $ff
.byte " ", "d", $ff
.byte "g", "e", $ff
.byte "f", "a", $ff
.byte "a", "v", $ff
.byte "i", "l", $ff
.byte "t", "e", $ff
.byte " ", "r", $ff
.byte "s", ".", $ff
.byte "d", " ", $ff
.byte "n", "e", $ff
.byte "r", "v", $ff
.byte " ", "S", $ff
.byte "o", " ", $ff
.byte "!", " ", $ff
.byte " ", "M", $ff
.byte "M", "a", $ff
.byte "i", "t", $ff
.byte "l", ".", $ff
.byte " ", "D", $ff
.byte " ", "e", $ff
.byte "'", "s", $ff
.byte "o", "f", $ff
.byte "a", "r", $ff
.byte "b", "l", $ff
.byte "y", " ", $ff
.byte "e", "l", $ff
.byte "l", "a", $ff
.byte " ", "b", $ff
.byte "t", "u", $ff
.byte "G", "r", $ff
.byte "s", ",", $ff
.byte "o", "v", $ff
.byte "i", "c", $ff
.byte "T", "h", $ff
.byte "d", "a", $ff
.byte " ", "C", $ff
.byte "C", "a", $ff
.byte "w", "i", $ff
.byte "s", "t", $ff
.byte "e", "f", $ff
.byte "f", "l", $ff
.byte "e", "x", $ff
.byte "x", "e", $ff
.byte "e", ".", $ff
.byte "S", "o", $ff
.byte "s", "u", $ff
.byte "e", "d", $ff
.byte "d", "!", $ff
.byte "a", "y", $ff
.byte "y", "b", $ff
.byte "b", "e", $ff
.byte " ", "h", $ff
.byte "t", "a", $ff
.byte "a", "f", $ff
.byte "f", "t", $ff
.byte " ", "B", $ff
.byte "B", "u", $ff
.byte "u", "t", $ff
.byte "D", "u", $ff
.byte "u", "n", $ff
.byte "e", "o", $ff
.byte "s", "o", $ff
.byte "e", "a", $ff
.byte "a", "s", $ff
.byte "s", "y", $ff
.byte "y", ".", $ff
.byte " ", "I", $ff
.byte "I", "m", $ff
.byte "m", "p", $ff
.byte "p", "r", $ff
.byte "s", "s", $ff
.byte "s", "i", $ff
.byte "r", "k", $ff
.byte "k", ",", $ff
.byte " ", "L", $ff
.byte "L", "e", $ff
.byte "t", "'", $ff
.byte "r", "b", $ff
.byte " ", "H", $ff
.byte "H", "a", $ff
.byte "l", "s", $ff
.byte "e", "y", $ff
.byte "u", ".", $ff
.byte " ", "W", $ff
.byte "W", "e", $ff
.byte "l", ",", $ff
.byte "w", "e", $ff
.byte " ", "N", $ff
.byte "N", "o", $ff
.byte "o", "t", $ff
.byte "n", "y", $ff
.byte "h", "i", $ff
.byte "i", "s", $ff
.byte "D", "o", $ff
.byte " ", "l", $ff
.byte " ", "P", $ff
.byte "P", "a", $ff
.byte "e", "'", $ff
.byte "t", "r", $ff
.byte "p", "p", $ff
.byte "p", "i", $ff
.byte "d", "u", $ff
.byte "u", "l", $ff
.byte "e", "n", $ff
.byte "s", "!", $ff
.byte "!", " ", $ff
.byte "S", "t", $ff
.byte "l", "i", $ff
.byte "e", ",", $ff
.byte "e", "h", $ff
.byte "h", "!", $ff
.byte " ", "I", $ff
.byte "I", " ", $ff
.byte "a", "m", $ff
.byte "m", "e", $ff
.byte "i", "f", $ff
.byte "b", "a", $ff
.byte "c", "k", $ff
.byte "k", " ", $ff
.byte "o", "w", $ff
.byte "w", ".", $ff
.byte " ", "F", $ff
.byte "F", "e", $ff
.byte "e", "w", $ff
.byte "w", " ", $ff
.byte "f", "r", $ff
.byte "r", "o", $ff
.byte "o", "m", $ff
.byte "m", " ", $ff
.byte " ", "U", $ff
.byte "U", "n", $ff
.byte "r", "w", $ff
.byte "r", "l", $ff
.byte "l", "d", $ff
.byte "d", ".", $ff