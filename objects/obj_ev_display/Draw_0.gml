if !surface_exists(game_surface)
	game_surface = surface_create(224, 144);

surface_set_target(game_surface)
draw_clear_alpha(c_black, 1)

function pre_draw_tile_state(i, j, tile_state) {
	if (tile_state != noone) {
		var tile = tile_state.tile
		if (tile.pre_draw_function != noone)
			tile.pre_draw_function(tile_state, i, j)
	}
}

function draw_tile_state(i, j, tile_state) {
	if (tile_state != noone) {
		var tile = tile_state.tile
		tile.draw_function(tile_state, i, j)
	}
}


for (var i = 0; i < 8; i++)	{
	for (var j = 0; j < 14; j++) {
		var tile_state = global.editor_object.level_tiles[i][j]
		pre_draw_tile_state(i, j, tile_state)
		
	
		if (global.tile_mode)
			draw_set_alpha(0.5)
		var object_state = global.editor_object.level_objects[i][j]
		pre_draw_tile_state(i, j, object_state)
		if (global.tile_mode)
			draw_set_alpha(1)
	}
}



for (var i = 0; i < 8; i++)	{
	for (var j = 0; j < 14; j++) {
		var tile_state = global.editor_object.level_tiles[i][j]
		draw_tile_state(i, j, tile_state)
		
	
		if (global.tile_mode)
			draw_set_alpha(0.5)
		var object_state = global.editor_object.level_objects[i][j]
		draw_tile_state(i, j, object_state)
		if (global.tile_mode)
			draw_set_alpha(1)
	}
}

if (mouse_on_me) {
	var tile_j = floor((mouse_x - x) / (16 * image_xscale))
	var tile_i = floor((mouse_y - y) / (16 * image_yscale))
	
	if dragging {
		var small_tile_i = drag_box_i
		var small_tile_j = drag_box_j
		
		if (tile_i < drag_box_i) {
			small_tile_i = tile_i
			tile_i = drag_box_i
		}
		if (tile_j < drag_box_j) {
			small_tile_j = tile_j
			tile_j = drag_box_j
		}
		
		draw_sprite_ext(global.selection_sprite, 0, 
			small_tile_j * 16, small_tile_i * 16, 
			tile_j - small_tile_j + 1, tile_i - small_tile_i + 1,
			0, c_white, 1)
	}
	
	else if global.selected_thing == 2 {
		draw_set_alpha((dsin(global.editor_time * 3) / 4) + 0.75)
		draw_tile_state(tile_i, tile_j, held_tile_state)
		draw_set_alpha(1)
	}
}
		

surface_reset_target()

draw_surface_ext(game_surface, x, y, image_xscale, image_yscale, 0, c_white, 1)
