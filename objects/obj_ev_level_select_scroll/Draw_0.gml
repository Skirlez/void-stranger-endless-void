event_inherited()
if (image_index == 0) {
	with (asset_get_index("obj_ev_level_select")) {
		var draw;
		if (search_box.txt == "") {
			var page_max = (array_length(levels) - 1) div 6;
			var page = global.level_start;
			draw = string(page + 1) + "/" + string(page_max + 1);
		}
		else {
			draw = "?"
		}	
		
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_color(c_white)
		draw_set_font(global.ev_font)
		
		draw_text_shadow(other.xstart, other.ystart - 16, draw, c_black)
	}
		
}