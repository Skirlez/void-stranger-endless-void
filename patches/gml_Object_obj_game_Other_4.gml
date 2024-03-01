// TARGET: TAIL
if (string_pos("rm_ev_", room_get_name(room)) != 0 && room != rm_ev_level) {
    if surface_get_width(application_surface) == 224 {
    	var ratio = display_get_height() / 144	
    	surface_resize(application_surface, 224 * ratio, 144 * ratio)
		if surface_exists(surface_final)
			surface_resize(surface_final, 224 * ratio, 144 * ratio)
    }
	global.clear_black = 2
	if (room == rm_ev_editor)
		global.is_in_editor = true;
}
else {
    if surface_get_width(application_surface) != 224 {
        surface_resize(application_surface, 224, 144)
		if surface_exists(surface_final)
			surface_resize(surface_final, 224, 144)
	}
	global.clear_black = 2
	if (room != rm_ev_editor)
		global.is_in_editor = false;
}