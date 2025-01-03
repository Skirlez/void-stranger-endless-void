function new_window(scale_x, scale_y, window_object, additional_vars = global.empty_struct) {
	
	var variable_struct = {
		image_xscale : scale_x,
		image_yscale : scale_y
	}
	
	// copy additional variables from the additional vars struct, if supplied
	if additional_vars != global.empty_struct {
		var names = variable_struct_get_names(additional_vars)
		for (var i = 0; i < array_length(names); i++) {
			variable_struct_set(variable_struct, names[i], variable_struct_get(additional_vars, names[i]))	
		}
	}
	return instance_create_layer(112, 72, "Windows", window_object, variable_struct)
}
function new_window_with_pos(pos_x, pos_y, scale_x, scale_y, window_object, additional_vars = global.empty_struct) {
	var cam_left_x = camera_get_view_x(view_camera[0])
	var cam_top_y = camera_get_view_y(view_camera[0])
	var cam_width = camera_get_view_width(view_camera[0])
	var cam_height = camera_get_view_height(view_camera[0])
	var cam_right_x = cam_left_x + cam_width;
	var cam_bottom_y = cam_top_y + cam_height;
	
	if (pos_x - scale_x * 8 < cam_left_x)
		pos_x = cam_left_x + scale_x * 8;
	if (pos_y - scale_x * 8 < cam_top_y)
		pos_y = cam_top_y + scale_y * 8;

	if (pos_x + scale_x * 8 > cam_right_x)
		pos_x = cam_right_x - scale_x * 8;
	if (pos_y + scale_x * 8 > cam_bottom_y)
		pos_y = cam_bottom_y - scale_y * 8;



	
	var variable_struct = {
		image_xscale : scale_x,
		image_yscale : scale_y
	}
	
	// copy additional variables from the additional vars struct, if supplied
	if additional_vars != global.empty_struct {
		var names = variable_struct_get_names(additional_vars)
		for (var i = 0; i < array_length(names); i++) {
			variable_struct_set(variable_struct, names[i], variable_struct_get(additional_vars, names[i]))	
		}
	}
	return instance_create_layer(pos_x, pos_y, "Windows", window_object, variable_struct)
}