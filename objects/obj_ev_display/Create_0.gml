// Object purpose: Display a level struct, and if edit == true, allow editing it.

game_surface = -1;

last_clicked_i = -1;
last_clicked_j = -1;
last_i = -1;
last_j = -1;
drag_box_i = -1
drag_box_j = -1
dragging = false

painting = false;

held_tile_state = new tile_with_state(global.editor_instance.object_empty)
place_sound = asset_get_index("snd_ev_place")
drag_sound = asset_get_index("snd_ev_drag")
erase_sound = asset_get_index("snd_ev_erase")
zed_sound = asset_get_index("snd_ev_zed")
pluck_sound = asset_get_index("snd_ev_pluck")

function switch_held_tile(tile_state) {
	held_tile_state = tile_state
}

held_tile_array = []
held_tile_offset = [0, 0]


function place_placeable(tile_i, tile_j, new_tile, properties = global.empty_struct, run_place_func = true) {
	var arr = global.editor_instance.current_placeables
	var tile_state = arr[tile_i][tile_j]
			
	if (tile_state.tile != new_tile) {
		if (tile_state.tile.flags & flag_unremovable)
			return;

		//audio_play_sound(snd_reveal, 10, false)
	}
	
	if (new_tile.flags & flag_only_one) {
		for (var i = 0; i < 9; i++) {
			for (var j = 0; j < 14; j++) {
				if arr[i][j].tile == new_tile
					arr[@ i][j] = new tile_with_state(global.editor_instance.current_empty_tile)
						
			}
		}
	}
	
	tile_state = new tile_with_state(new_tile, properties)
	if (run_place_func)
		tile_state = new_tile.place_function(tile_state, tile_i, tile_j, lvl);
	arr[@ tile_i][tile_j] = tile_state;
}


function handle_click_before(tile_i, tile_j) {
	var tile_state = global.editor_instance.current_placeables[tile_i][tile_j];
	switch (global.selected_thing) {
		case thing_plucker:
			if dragging {
				var height = tile_i - small_tile_i + 1;
				var width = tile_j - small_tile_j + 1;
				held_tile_offset = [small_tile_i, small_tile_j]
				held_tile_array = array_create(height)
				for (var i = 0; i < array_length(held_tile_array); i++)
					held_tile_array[i] = array_create(width, new tile_with_state(global.editor_instance.current_empty_tile))	
			}
			return;
		case thing_eraser:
			if tile_state.tile != global.editor_instance.current_empty_tile || dragging
				audio_play_sound(erase_sound, 10, false, 1, 0, random_range(0.7, 1))
			return;

		case thing_placeable:
			if tile_state.tile != held_tile_state.tile || dragging {
				audio_stop_sound(place_sound)
				audio_play_sound(place_sound, 10, false, 1, 0, random_range(0.8, 1.2))	
			}
			else
				audio_play_sound(drag_sound, 10, false, 1.2, 0, 3.5)	
			
			return;
		case thing_multiplaceable:
			audio_stop_sound(place_sound)
			audio_play_sound(place_sound, 10, false, 1, 0, 0.7)
			return;
		default:
			return;
	}
}


function handle_click(tile_i, tile_j) {
	switch (global.selected_thing) {
		case thing_plucker:
			if dragging {
				var tile_state = global.editor_instance.current_placeables[tile_i][tile_j];
				if !(tile_state.tile.flags & flag_unplaceable) {
					var local_tile_i = tile_i - held_tile_offset[0]
					var local_tile_j = tile_j - held_tile_offset[1]
					held_tile_array[local_tile_i][local_tile_j] = tile_state
					place_placeable(tile_i, tile_j, global.editor_instance.current_empty_tile)
				}
				
			}
			else {
				var object_state = lvl.objects[tile_i][tile_j];
				var tile_state = lvl.tiles[tile_i][tile_j];

				if !(object_state.tile.flags & flag_unplaceable) {
					final_state = object_state
					if global.tile_mode == true
						global.editor_instance.switch_tile_mode(false)		
				}
				else if !(tile_state.tile.flags & flag_unplaceable){
					final_state = tile_state
					if global.tile_mode == false
						global.editor_instance.switch_tile_mode(true)	
				}
				else 
					return;
				
			
				audio_play_sound(pluck_sound, 10, false, 1.2)	
				global.selected_thing = thing_placeable
				switch_held_tile(final_state)
				global.mouse_held = false;
				place_placeable(tile_i, tile_j, global.editor_instance.current_empty_tile)
			}
			return;
		case thing_eraser:
			place_placeable(tile_i, tile_j, global.editor_instance.current_empty_tile)
			//runtile_autotile_blob(tile_j, tile_i)
			return;
		case thing_placeable:
			if (held_tile_state == global.editor_instance.object_empty)
				return;

			
			place_placeable(tile_i, tile_j, held_tile_state.tile, struct_copy(held_tile_state.properties))
			//runtile_autotile_blob(tile_j, tile_i)
			return;
		case thing_multiplaceable:
		
			for (var i = 0; i < array_length(held_tile_array); i++) {
				for (var j = 0; j < array_length(held_tile_array[i]); j++) {
					var tile_state = held_tile_array[i][j]
					if (tile_state.tile == global.editor_instance.current_empty_tile)
						continue;
					var new_tile_i = tile_i + i;
					if new_tile_i >= 9
						continue;
					var new_tile_j = tile_j + j
					if new_tile_j >= 14
						continue;
						
					place_placeable(new_tile_i, new_tile_j, tile_state.tile, struct_copy(tile_state.properties), false)
				}
			}
		default:
			return;
			
	}
}



function handle_click_after(tile_i, tile_j) {
	switch (global.selected_thing) {
		case thing_plucker:
			if !dragging 
				return;
				
			var initial_empty_in_row = 14
			var empty_row = true
			for (var i = 0; i < array_length(held_tile_array); i++) {
				
				for (var j = 0; j < array_length(held_tile_array[i]); j++) {
					var tile_state = held_tile_array[i][j]
					var is_empty = (tile_state.tile == global.editor_instance.current_empty_tile)
					if !is_empty {
						empty_row = false;
						initial_empty_in_row = min(initial_empty_in_row, j)
					}
				}
				
				if empty_row {
					array_delete(held_tile_array, i, 1)
					i--;	
				}
			}
				
			if (array_length(held_tile_array) == 0)
				return;
				
			if initial_empty_in_row != 0 {
				for (var i = 0; i < array_length(held_tile_array); i++) {
					array_delete(held_tile_array[i], 0, initial_empty_in_row)
				}	
			}
				
			global.selected_thing = thing_multiplaceable
			audio_play_sound(pluck_sound, 10, false, 1.2, 0, random_range(0.75, 0.85))		
			
				
			return;
		default:
			return;
	}
}

scale_x_start = image_xscale
scale_y_start = image_yscale

base_ui = asset_get_index("spr_ev_base_ui")


ind = 0


voidrod_sprite = asset_get_index("spr_voidrod_icon")
stackrod_sprite = asset_get_index("spr_voidrod_icon2")
burdens_sprite = asset_get_index("spr_items")
border_sprite = asset_get_index("spr_ev_display_border")

draw_name = !edit;
