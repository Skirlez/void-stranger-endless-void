if (selected) {
	gpu_set_fog(true, c_white, 0, 1)
	var increase = dsin(global.editor_time) / 8 + 0.25;

	draw_sprite_ext(sprite_index, image_index, x, y, scale_x + increase, scale_y + increase, 0, c_white, 1)
	gpu_set_fog(false, c_white, 0, 1)
}

if image_index == 5 && global.erasing != -1 {
	var offset_x = dcos(global.editor_time * 4) * (350-global.erasing) / 40
	var offset_y = dsin(global.editor_time * 4) * (350-global.erasing) / 40
}
else {
	offset_x = 0
	offset_y = 0
}

draw_sprite_ext(sprite_index, image_index, x + offset_x, y + offset_y, scale_x, scale_y, 0, c_white, 1)