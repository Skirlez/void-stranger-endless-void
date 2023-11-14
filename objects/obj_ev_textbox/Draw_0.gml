draw_self()
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_halign(fa_top)
draw_set_font(global.ev_font)

var w = image_xscale * 16
var h = image_yscale * 16
if !surface_exists(text_surface)
	text_surface = surface_create(w, h)	
else if surface_get_width(text_surface) != w or surface_get_height(text_surface) != h
	surface_resize(text_surface, w, h)	
surface_set_target(text_surface)
draw_clear_alpha(c_black, 0)
var add = (global.editor_time % 60 < 30 && window.selected_element == id) ? "|" : ""
draw_text_ext(3, 0, filter_text(txt) + add, 15, -1)
surface_reset_target()

draw_surface(text_surface, x, y)