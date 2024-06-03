event_inherited()
global.level_start += (other.image_index == 0) ? 1 : -1
y = ystart + ((other.image_index == 0) ? 7 : -7)
with (asset_get_index("obj_ev_level_select")) {
	create_displays()	
}