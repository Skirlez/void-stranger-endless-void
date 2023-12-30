event_inherited()
with (asset_get_index("obj_ev_level_select")) {
	level_start += (other.image_angle == 0) ? 1 : -1
	create_displays()	
}