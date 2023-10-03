if (selected) {
	gpu_set_fog(true, c_white, 0, 1)
	var increase = dsin(global.editor_time) / 8 + 0.25;
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale + increase, image_yscale + increase, 0, c_white, 1)
	gpu_set_fog(false, c_white, 0, 1)
}

draw_self()