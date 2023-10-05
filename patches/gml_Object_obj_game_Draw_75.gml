// TARGET: REPLACE


surface_reset_target()
if global.is_in_editor == true {
    if surface_get_width(application_surface) == 224 {
    	var ratio = display_get_height() / 144	
    	surface_resize(application_surface, 224 * ratio, 144 * ratio)
	    draw_clear(c_black)
		exit
    }
}
else {
    if surface_get_width(application_surface) != 224 {
        surface_resize(application_surface, 224, 144)
        draw_clear(c_black)  
		exit
    }
}
shader_set(shader_palette)
var sx = surface_get_width(application_surface)
var sy = surface_get_height(application_surface)
var mx = (224 / sx)
var my = (144 / sy)
draw_surface_ext(application_surface, 0, 0, mx, my, 0, c_white, 1)
shader_reset()