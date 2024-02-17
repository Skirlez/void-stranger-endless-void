event_inherited()
global.level_start += (other.image_angle == 0) ? 1 : -1
with (asset_get_index("obj_ev_level_select")) {
	create_displays()	
}