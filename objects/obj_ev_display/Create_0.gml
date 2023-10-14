game_surface = -1;

last_clicked_i = -1;
last_clicked_j = -1;
drag_box_i = -1
drag_box_j = -1
dragging = false

painting = false;

held_tile_state = noone

function switch_held_tile(tile_state) {
	held_tile_state = tile_state
}

function place_placeable(tile_i, tile_j, new_tile, properties = noone) {
	var arr = global.editor_object.current_placeables
	var tile_state = arr[tile_i][tile_j]
			
	if (tile_state != noone && tile_state.tile != new_tile) {
		if (tile_state.tile.flags & flag_unremovable)
			return;
		//audio_play_sound(snd_reveal, 10, false)
	}

	arr[@ tile_i][tile_j] = new tile_with_state(new_tile, properties)
}

function handle_click(tile_i, tile_j) {
	switch (global.selected_thing) {
		case thing_eraser:
			place_placeable(tile_i, tile_j, global.editor_object.current_empty_tile)
			runtile_autotile_blob(tile_j, tile_i)
			break;
		case thing_placeable:
			if (held_tile_state == noone)
				break;
			if (held_tile_state.tile.flags & flag_only_one) {
				var arr = global.editor_object.current_placeables
				for (var i = 0; i < 9; i++) {
					for (var j = 0; j < 14; j++) {
						if arr[i][j].tile == held_tile_state.tile
							arr[@ i][j] = new tile_with_state(global.editor_object.current_empty_tile)
						
					}
				}
			}
			place_placeable(tile_i, tile_j, held_tile_state.tile, struct_copy(held_tile_state.properties))
			runtile_autotile_blob(tile_j, tile_i)
			break;
		default:
			break;
			
	}
}

function handle_click_before(tile_i, tile_j) {
	switch (global.selected_thing) {
		case thing_placeable:
		case thing_eraser:
		default:
			
			break;
	}
}

move_curve = animcurve_get_channel(ac_play_transition, "move")
grow_curve = animcurve_get_channel(ac_play_transition, "grow")
scale_x_start = image_xscale
scale_y_start = image_yscale

base_ui = asset_get_index("spr_ev_base_ui")


ind = 0