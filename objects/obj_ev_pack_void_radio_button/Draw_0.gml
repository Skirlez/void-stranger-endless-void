if (global.void_radio_on) {
	gpu_set_fog(true, c_white, 0, 1)
	var increase = (1.1 + (dsin(global.editor_time) + 1) / 16);

	ev_draw_cube(sprite_index, 0, x, y, image_xscale * cube_scale_multiplier * increase, spin_h, spin_v)
	gpu_set_fog(false, c_white, 0, 1)
}
ev_draw_cube(sprite_index, 0, x, y, image_xscale * cube_scale_multiplier, spin_h, spin_v)