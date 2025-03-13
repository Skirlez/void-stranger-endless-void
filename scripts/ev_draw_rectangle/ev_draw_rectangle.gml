
function ev_draw_rectangle(x1, y1, x2, y2, outline) {
	static rectangle_sprite = agi("spr_ev_the_rectangle")
	static pixel_sprite = agi("spr_ev_the_pixel")
	if (outline)
		draw_sprite_ext(rectangle_sprite, 0, x1, y1, (x2 - x1 + 1) / 3, (y2 - y1 + 1) / 3, 0, draw_get_color(), draw_get_alpha())
	else
		draw_sprite_ext(pixel_sprite, 0, x1, y1, x2 - x1, y2 - y1, 0, draw_get_color(), draw_get_alpha())
}