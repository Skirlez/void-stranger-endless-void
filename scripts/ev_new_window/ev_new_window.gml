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