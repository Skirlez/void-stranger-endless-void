
var ind = global.tile_mode ? tile_ind : object_ind
var tile = global.editor_object.current_list[ind]
sprite_index = tile.spr_ind

if (selected) {
	if (global.tile_mode) {
		var color = c_black
		var sprite = global.white_floor_sprite
	}
	else {
		color = c_white
		sprite = sprite_index
	}
	
	gpu_set_fog(true, color, 0, 1)
	var increase = dsin(global.editor_time) / 8 + 0.25;
	draw_sprite_ext(sprite, 0, x, y, image_xscale + increase, image_yscale + increase, 0, c_white, 1)
	gpu_set_fog(false, color, 0, 1)
}


draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)
	
	
