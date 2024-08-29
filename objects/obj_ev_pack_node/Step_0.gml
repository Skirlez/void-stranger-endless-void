if (ev_is_mouse_on_me()) {
	if ev_mouse_pressed()
		mouse_moving = true;
	if ev_mouse_right_pressed()
		connecting_exit = true;
}
if ev_mouse_released()
	mouse_moving = false;
if ev_mouse_right_released() && connecting_exit {
	connecting_exit = false
	display_inst = instance_position(mouse_x, mouse_y, display_object)
}
if (mouse_moving) {
	x = mouse_x
	y = mouse_y
}