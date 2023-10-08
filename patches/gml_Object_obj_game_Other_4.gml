// TARGET: TAIL
if (room == rm_ev_editor) {
    if surface_get_width(application_surface) == 224 {
    	var ratio = display_get_height() / 144	
    	surface_resize(application_surface, 224 * ratio, 144 * ratio)
    }
	global.clear_black = 2
    global.is_in_editor = true;
}
else {
    if surface_get_width(application_surface) != 224
        surface_resize(application_surface, 224, 144)
	global.clear_black = 2
    global.is_in_editor = false;
}