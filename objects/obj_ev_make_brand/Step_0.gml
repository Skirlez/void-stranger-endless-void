if global.allow_moving_elements && mouse_check_button(mb_middle) && ev_is_mouse_on_me() {
	x = mouse_x
	y = mouse_y
	mouse_on_me = false;
	log_info($"{mouse_x}, {mouse_y}")
	x -= scale * 3
	y -= scale * 3
}


if ev_mouse_pressed() && ev_is_mouse_on_me() {
	drawing = true
}
if (drawing && ev_is_mouse_on_me()) {
	var relative_x = (mouse_x - x) div scale
	var relative_y = (mouse_y - y) div scale
	
	if (relative_x < 6 && relative_y < 6
			&& (relative_x != last_relative_x || relative_y != last_relative_y)) {
		var bit_index = relative_x + relative_y * 6
		brand ^= ((1 << (bit_index)))
		audio_play_sound(agi("snd_ev_paint_brand"), 10, false)
		last_relative_x = relative_x;
		last_relative_y = relative_y;
	}
}
if ev_mouse_released() {
	last_relative_x = -1
	last_relative_y = -1
	drawing = false;
}