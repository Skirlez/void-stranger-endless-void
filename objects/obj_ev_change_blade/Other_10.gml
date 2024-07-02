event_inherited()

if global.blade_style == 0
	global.blade_style = 1
else if global.blade_style == 1
	global.blade_style = 2
else if global.blade_style == 2
	global.blade_style = 3
else if global.blade_style == 3
	global.blade_style = 4
else
	global.blade_style = 0

sprite_index = ev_get_burden_sprite(global.blade_style)
if global.blade_style == 2 sprite_index = asset_get_index("spr_ev_items_lev")		