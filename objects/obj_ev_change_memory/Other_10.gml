event_inherited()


if global.memory_style == 0
	global.memory_style = 1
else if global.memory_style == 1
	global.memory_style = 2
else if global.memory_style == 2
	global.memory_style = 3
else if global.memory_style == 3
	global.memory_style = 4
else
	global.memory_style = 0

sprite_index = ev_get_burden_sprite(global.memory_style)