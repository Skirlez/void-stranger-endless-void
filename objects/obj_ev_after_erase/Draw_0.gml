if !surface_exists(erasing_surface)
	erasing_surface = surface_create(224, 144)
surface_set_target(erasing_surface)
draw_clear(c_black)

var t = start_time - time
draw_set_color(c_white)

draw_set_alpha(outer_circle_alpha)
draw_circle(112, 72, outer_circle_size, true)
draw_circle(112, 72, outer_circle_size - 1, true)
draw_circle(112, 72, outer_circle_size + 1, true)
draw_set_alpha(1)
	
if t < 60 {
	draw_circle(112 + irandom_range(-2, 2), 72 + irandom_range(-2, 2), max(dsin(t * 3) * 8, 1), false)
}
else {

	draw_set_alpha((t - 60) / 60)
	draw_set_font(global.ev_font)
	draw_set_halign(fa_middle)
	draw_set_valign(fa_center)
	
	var text_x = 112
	if time < 8
		text_x += irandom_range(-100, 100)
	draw_text(text_x, 72 - 35, "Only a simple memory\nwill remain")
	
	draw_set_alpha((time - 60) / 60)
	
	var mag = (clamp((time - 60) / 60, -1, 1) + 1) / 2
	ev_draw_pixel(112 + random_range(-1, 1) * mag, 72 + random_range(-1, 1) * mag)
	draw_set_alpha(1)
}

surface_reset_target()
draw_surface(erasing_surface, 0, 0)