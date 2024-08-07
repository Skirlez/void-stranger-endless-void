// TARGET: LINENUMBER
// 32
if (global.swapper_backup != 0)
{
    ds_grid_set(obj_inventory.ds_equipment, 0, 4, global.swapper_backup)
    global.swapper_backup = 0
}
// TARGET: LINENUMBER
// 40
global.swapper_used = 0

// TARGET: TAIL
if (string_pos("rm_ev_", room_get_name(room)) != 0 && room != rm_ev_level) {
    if surface_get_width(application_surface) == 224 {
    	var ratio = display_get_height() / 144	
    	surface_resize(application_surface, 224 * ratio, 144 * ratio)
		if surface_exists(surface_final)
			surface_resize(surface_final, 224 * ratio, 144 * ratio)
    }
	global.clear_black = 2
}
else {
    if surface_get_width(application_surface) != 224 {
        surface_resize(application_surface, 224, 144)
		if surface_exists(surface_final)
			surface_resize(surface_final, 224, 144)
	}
	global.clear_black = 2
}