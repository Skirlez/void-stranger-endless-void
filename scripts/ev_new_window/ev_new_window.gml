function new_window(scale_x, scale_y, window_object) {
	return instance_create_layer(112, 72, "Windows", window_object, {
		image_xscale : scale_x,
		image_yscale : scale_y
	})
}