event_inherited()
function calculate_offset_direction() {
	
	var angle = point_direction(x, y, mouse_x, mouse_y);
	// 45 degree intervals
	angle = round(angle / 45) * 45
	return { offset_x : round(dcos(angle)), offset_y : -round(dsin(angle)) };
}
empty_offset_struct = { offset_x : 0, offset_y : 0 };

sprites_array = [sprite_index, sprite_index, sprite_index, sprite_index, sprite_index, sprite_index];
indices_array = [0, 1, 1, 1, 1, 1];