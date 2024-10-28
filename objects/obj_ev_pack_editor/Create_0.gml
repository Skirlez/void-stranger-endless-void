display_instances = []
destinations = ds_map_create()

previous_mouse_x = mouse_x;
previous_mouse_y = mouse_y;

dragging_camera = false;

zoom = 0;


menu_remember_x = 0;
menu_remember_y = 0;

function on_menu_create() {
	menu_remember_x = camera_get_view_x(view_camera[0])
	menu_remember_y = camera_get_view_y(view_camera[0])
	camera_set_view_pos(view_camera[0], 0, 0)	
	camera_set_view_size(view_camera[0], 224, 144)	
}
function on_menu_destroy() {
	calculate_zoom()
	camera_set_view_pos(view_camera[0], menu_remember_x, menu_remember_y)	
}

function calculate_zoom() {
	var zoom_factor = 1.2;
	var mult = power(zoom_factor, zoom);
	
	var cam_width = 224 * mult;
	var cam_height = 144 * mult
	
	if (cam_width > room_width || cam_height > room_height) {
		// go to last possible zoom level
		// 224 * 1.2^zoom = room_width
		// zoom = log1.2(room_width / 224) 
		
		zoom = floor(logn(1.2, room_width / 224))
		calculate_zoom()
		return;
	}
	
	var previous_width = camera_get_view_width(view_camera[0])
	var previous_height = camera_get_view_height(view_camera[0])
	
	camera_set_view_size(view_camera[0], cam_width, cam_height)
	
	var change_x = 224 * mult - previous_width;
	var change_y = 144 * mult - previous_height;
	
	var cam_x = camera_get_view_x(view_camera[0])
	var cam_y = camera_get_view_y(view_camera[0])
	
	
	var mouse_uniform_x = display_mouse_get_x() / display_get_width()
	var mouse_uniform_y = display_mouse_get_y() / display_get_height()
	
	var target_x = clamp(cam_x - change_x * mouse_uniform_x, 0, room_width - cam_width)
	var target_y = clamp(cam_y - change_y * mouse_uniform_y, 0, room_height - cam_height)
	camera_set_view_pos(view_camera[0], target_x, target_y)	
}