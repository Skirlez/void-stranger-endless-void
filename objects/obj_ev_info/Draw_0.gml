draw_set_color(c_white)
draw_set_font(global.ev_font)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
var long_text = 
@"Controls:
Use your mouse.
F5 - Exit out of a level.
CTRL + Z - Undo hotkey.

The action key, bound to Z by default, 
can modify properties of tiles and objects, like the rotation of Leeches,
or the contents of chests. Try it on all of them!

NOTE: You will be banned from the official server
for not using common sense.";

draw_text_transformed(4, 5, long_text, 0.5, 0.5, 0)