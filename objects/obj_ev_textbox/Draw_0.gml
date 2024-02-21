draw_self()

draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_font(global.ev_font)

var w = image_xscale * 16
var h = image_yscale * 16
if !surface_exists(text_surface)
	text_surface = surface_create(w - 1, h - 1)	
else if surface_get_width(text_surface) != w or surface_get_height(text_surface) != h
	surface_resize(text_surface, w - 1, h - 1)	
surface_set_target(text_surface)
draw_clear_alpha(c_black, 0)
var filtered_text
var draw_color
if txt == "" && (window == -1 || window.selected_element != id) {
	filtered_text = empty_text
	draw_color = c_gray
}
else {
	filtered_text = filter_text(txt, true)
	draw_color = c_white
}
draw_set_color(draw_color)
draw_text_ext(3, 0, filtered_text, 15, -1)
surface_reset_target()

draw_surface_ext(text_surface, x, y, 1, 1, 0, c_white, image_alpha)