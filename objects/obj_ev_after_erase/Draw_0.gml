if !surface_exists(erasing_surface)
	erasing_surface = surface_create(224, 144)
surface_set_target(erasing_surface)
draw_clear(c_black)

var t = 280 - time
draw_set_color(c_white)

draw_circle(112, 72, t * 5, true)
draw_circle(112, 72, t * 5 - 1, true)
draw_circle(112, 72, t * 5 + 1, true)
	
if t < 60 {
	draw_circle(112 + irandom_range(-2, 2), 72 + irandom_range(-2, 2), max(dsin(t * 3) * 8, 1), false)
}
else {
	draw_set_alpha((time - 60) / 60)
	draw_circle(112, 72, 0.8, false)
	draw_set_alpha(1)
}

surface_reset_target()
draw_surface(erasing_surface, 0, 0)