if ev_mouse_pressed() && global.instance_touching_mouse == noone {

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

if mouse_wheel_down()
	camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) * 1.2, camera_get_view_height(view_camera[0]) * 1.2)
if mouse_wheel_up()
	camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) / 1.2, camera_get_view_height(view_camera[0]) / 1.2)