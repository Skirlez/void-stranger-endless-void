if (selected) {
	gpu_set_fog(true, c_white, 0, 1)
	var increase = (1.1 + (dsin(global.editor_time) + 1) / 16);

	draw_sprite_ext(sprite_index, image_index, x, y, scale_x * increase, scale_y * increase, 0, c_white, 1)
	gpu_set_fog(false, c_white, 0, 1)
	
	window_size = lerp(window_size, 1, 0.3)
	var center_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2
	var center_y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2
	draw_sprite_ext(window_sprite, 0, center_x, center_y, window_xscale * window_size, window_yscale * window_size, 0, c_white, 1)
}
else
	window_size = 0
	

draw_sprite_ext(sprite_index, image_index, x, y, scale_x, scale_y, 0, c_white, 1)