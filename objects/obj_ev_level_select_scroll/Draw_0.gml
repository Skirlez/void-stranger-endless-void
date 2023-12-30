draw_self()
if (image_angle == 0) {
	with (asset_get_index("obj_ev_level_select")) {
		var page_max = (array_length(files) - 1) div 6;
		var page = level_start;
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_color(c_white)
		draw_set_font(global.ev_font)
		draw_text_shadow(other.x, other.y - 16, string(page + 1) + "/" + string(page_max + 1), c_black)
	}
		
}