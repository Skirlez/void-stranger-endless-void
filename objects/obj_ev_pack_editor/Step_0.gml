if ev_mouse_pressed() && global.instance_touching_mouse == noone && global.mouse_layer == 0 {

	dragging_camera = true;
}
else if ev_mouse_released()
	dragging_camera = false;

if dragging_camera {
	var cam_x = camera_get_view_x(view_camera[0])
	var cam_y = camera_get_view_y(view_camera[0])
	
	var cam_width = camera_get_view_width(view_camera[0])
	var cam_height = camera_get_view_height(view_camera[0])
	
	
	var target_x = clamp(cam_x + previous_mouse_x - mouse_x, 0, room_width - cam_width)
	var target_y = clamp(cam_y + previous_mouse_y - mouse_y, 0, room_height - cam_height)
	
	camera_set_view_pos(view_camera[0], target_x, target_y)
}

previous_mouse_x = mouse_x;
previous_mouse_y = mouse_y;


var prev_zoom = zoom
if mouse_wheel_down() {
	zoom += 1;
}
if mouse_wheel_up() {
	zoom -= 1;
}

if (prev_zoom != zoom) {
	calculate_zoom()
}

if keyboard_check_pressed(ord("S")) {
	var room_nodes = convert_room_nodes_to_structs()
	global.pack.starting_node_states = room_nodes;
	var str = export_pack_arr(global.pack)
	show_debug_message(str)
}