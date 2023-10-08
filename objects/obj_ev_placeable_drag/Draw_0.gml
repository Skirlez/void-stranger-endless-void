if (global.tile_mode) {
	var tile = global.editor_object.tiles_list[tile_ind]
	sprite_index = tile.spr_ind
}
else {
	var object = global.editor_object.objects_list[object_ind]
	sprite_index = object.spr_ind
}



	
	
if selected {
	draw_set_color(c_black)
	draw_line_width(x, y, mouse_x, mouse_y, 1)	
	var inst = instance_position(mouse_x, mouse_y, asset_get_index("obj_ev_placeable_selection"))
	if !instance_exists(inst) {
		draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)
		exit
	}
	if (global.tile_mode)
		var tile = global.editor_object.tiles_list[inst.tile_ind]	
	else 
		var tile = global.editor_object.objects_list[inst.object_ind]
	
	var alpha = (dsin(global.editor_time * 4) / 5) + 0.75
	
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, alpha)
	draw_sprite_ext(tile.spr_ind, 0, x, y, image_xscale, image_yscale, 0, c_white, 1 - alpha)
}
else
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)