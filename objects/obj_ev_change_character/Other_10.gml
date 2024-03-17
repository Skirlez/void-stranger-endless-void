event_inherited()

if global.stranger == 0
	global.stranger = 1;
else if global.stranger == 1
	global.stranger = 5;
else if global.stranger == 5
	global.stranger = 6;
else
	global.stranger = 0;
if (compiled_for_merge)
	asset_get_index("scr_menueyecatch")(0)
sprite_index = ev_get_stranger_down_sprite(global.stranger)