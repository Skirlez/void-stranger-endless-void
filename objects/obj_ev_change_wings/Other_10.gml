event_inherited()


if global.wings_style == 0
	global.wings_style = 1
else if global.wings_style == 1
	global.wings_style = 2
else if global.wings_style == 2
	global.wings_style = 3
else if global.wings_style == 3
	global.wings_style = 4
else
	global.wings_style = 0

sprite_index = ev_get_burden_sprite(global.wings_style)