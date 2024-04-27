
function ev_draw_rectangle(x1, y1, x2, y2, outline) {
	if (outline)
		draw_sprite_ext(asset_get_index("spr_ev_the_rectangle"), 0, x1, y1, (x2 - x1 + 1) / 3, (y2 - y1 + 1) / 3, 0, draw_get_color(), draw_get_alpha())
	else
		draw_sprite_ext(asset_get_index("spr_ev_the_pixel"), 0, x1, y1, x2 - x1, y2 - y1, 0, draw_get_color(), draw_get_alpha())
}