if global.mouse_layer != 0
	exit
var level_string = get_string("", "");
var out = import_level(level_string);
if is_string(out)
	show_debug_message("ERROR IMPORTING LEVEL: " + out)
else
	global.level = out;
	
ev_play_music(asset_get_index(global.music_names[0]))

switch_tile_mode(true);