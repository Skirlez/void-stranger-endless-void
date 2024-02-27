if (ev_mouse_held() && ev_is_mouse_on_me()) {
	var relative_x = (mouse_x - x) div 6
	var relative_y = (mouse_y - y) div 6
	
	var bit_index = relative_x + relative_y * 6
	show_debug_message(bit_index)
	if (relative_x != last_relative_x || relative_y != last_relative_y) {
		brand ^= ((1 << (bit_index)) )
		last_relative_x = relative_x
		last_relative_y = relative_y
	}
}
if ev_mouse_released() {
	last_relative_x = -1
	last_relative_y = -1
}