event_inherited();

draw_set_color(c_white);
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
if in_menu
	exit
var index = 0;
for (var i = 0; i < array_length(global.music_names); i++) {
	if properties.music == global.music_names[i]
		index = i
}

draw_text_shadow(x, y - 16, index)
