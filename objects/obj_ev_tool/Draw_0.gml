if (selected) {
	gpu_set_fog(true, c_white, 0, 1)
	var increase = dsin(global.editor_time) / 8 + 0.25;

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale + increase, image_yscale + increase, 0, c_white, 1)
	gpu_set_fog(false, c_white, 0, 1)
}

if image_index == 5 && global.erasing != -1 {
	var offset_x = dcos(global.editor_time * 4) * (350-global.erasing) / 50
	var offset_y = dsin(global.editor_time * 4) * (350-global.erasing) / 50
}
else {
	offset_x = 0
	offset_y = 0
}

draw_sprite_ext(sprite_index, image_index, x + offset_x, y + offset_y, image_xscale, image_yscale, 0, c_white, 1)