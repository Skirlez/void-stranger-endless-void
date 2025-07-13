
function ev_draw_pixel(_x, _y, color = draw_get_color()) {
	var keep_color = draw_get_color()
	draw_set_color(color)
	draw_sprite(agi("spr_ev_the_pixel"), 0, _x, _y)
	draw_set_color(keep_color)
}