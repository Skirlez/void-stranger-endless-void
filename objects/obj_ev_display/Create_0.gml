game_surface = -1;
global.tile_mode = true

drag_box_i = -1
drag_box_j = -1
dragging = false

held_tile_state = noone

function switch_held_tile(tile_state) {
	held_tile_state = tile_state
}





place_placeable = function(tile_i, tile_j, new_tile, properties) {
	var arr = (global.tile_mode) ? global.editor_object.level_tiles : global.editor_object.level_objects
	var tile_state = arr[tile_i][tile_j]
			
	if (tile_state != noone && tile_state.tile != new_tile) {
		if (tile_state.tile.flags & flag_unremovable)
			return;
		//audio_play_sound(snd_reveal, 10, false)
	}

	arr[@tile_i][tile_j] = new tile_with_state(new_tile, properties)
}

function handle_click(tile_i, tile_j) {
	switch (global.selected_thing) {
		case thing_eraser:
			var arr = (global.tile_mode) ? global.editor_object.level_tiles : global.editor_object.level_objects
			var tile_state = arr[tile_i][tile_j]
			if (tile_state != noone) {
				if !(tile_state.tile.flags & flag_unremovable)
					arr[@tile_i][tile_j] = noone
			}
			break;
		
		case thing_placeable:
			/*
			var list = (global.tile_mode) ? global.editor_object.tiles_list : global.editor_object.objects_list
			var tile = list[global.selected_placeable_num]
			*/
			
			place_placeable(tile_i, tile_j, held_tile_state.tile, struct_copy(held_tile_state.properties))
		default:
			break;
			
	}
}

function handle_click_after(tile_i, tile_j) {
	switch (global.selected_thing) {
		default:
			break;
	}
}

mouse_on_me = false