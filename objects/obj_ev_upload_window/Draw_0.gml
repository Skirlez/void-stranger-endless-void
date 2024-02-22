draw_self()
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_color(c_white)

// sorry
if state == 0
	draw_text_shadow(room_width / 2, room_height / 2 - 10, are_you_sure_text, c_black)
else if (state == 1) 
	draw_text_shadow(room_width / 2, room_height / 2 - 10, uploading_text, c_black)
else if (state == 2)
	draw_text_shadow(room_width / 2, room_height / 2 - 10, done_text, c_black)
else if (state == 3)
	draw_text_shadow(room_width / 2, room_height / 2 - 10, fail_text, c_black)
else if (state == 4)
	draw_text_shadow(room_width / 2, room_height / 2 - 10, manage_text, c_black)