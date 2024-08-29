function ev_draw_pack_line(x1, y1, x2, y2) {
	draw_set_color(c_black)
	draw_line_width(x1, y1,	x2, y2, 2)
	
	draw_sprite_ext(spr_pack_arrow, 0, (x1 + x2) / 2, (y1 + y2) / 2, 1, 1, point_direction(x1, y1, x2, y2), c_white, 1)
}