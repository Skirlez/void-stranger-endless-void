function draw_text_shadow(_x, _y, txt, shadow_color = c_black) {
	var save = draw_get_color()
	draw_set_color(shadow_color)
	draw_text(_x + 1, _y, txt)
	draw_text(_x - 1, _y, txt)
	draw_text(_x, _y + 1, txt)
	draw_text(_x, _y - 1, txt)
	draw_set_color(save)
	draw_text(_x, _y, txt)
}