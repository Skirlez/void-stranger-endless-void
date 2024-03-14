event_inherited()

if time != 0
	exit
if (global.online_mode)
	time = 20
global.mouse_layer++;
new_window(0, 0, asset_get_index("obj_ev_refresh_window"))