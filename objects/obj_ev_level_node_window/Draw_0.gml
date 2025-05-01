draw_self();
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_set_font(global.ev_font)
if is_brand_room
	draw_text_shadow(x - 69, y + 30, "Level is a\nvalid brand room")	
else
	draw_text_shadow(x - 69, y + 30, "Level is not a\nvalid brand room")	