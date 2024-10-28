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
	var node_inst = get_node_at_position(mouse_x, mouse_y)
	
	if (instance_exists(node_inst) && node_inst.can_connect_to_me && array_length(exit_instances) < max_exits) {
		array_push(exit_instances, node_inst)	
	}
}
if (mouse_moving) {
	x = mouse_x
	y = mouse_y
	center_x = x;
	center_y = y;
}