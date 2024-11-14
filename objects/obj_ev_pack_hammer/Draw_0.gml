if (selected) {
	gpu_set_fog(true, c_white, 0, 1)
	var increase = (1.1 + (dsin(global.editor_time) + 1) / 16);

	draw_sprite_ext(sprite_index, image_index, x, y, scale_x * increase, scale_y * increase, 0, c_white, 1)
	gpu_set_fog(false, c_white, 0, 1)
}
draw_sprite_ext(sprite_index, image_index, x, y, scale_x, scale_y, 0, c_white, 1)