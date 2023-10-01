

if (global.tile_mode) {
	if (tile == noone)
		exit
	sprite_index = tile.spr_ind
}
else {
	if (object == noone)
		exit
	sprite_index = object.spr_ind
}

if global.selected_thing == 2 && num == global.selected_placeable_num {
	ev_draw_selected_circle(x, y)	
}

draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)
	
	
