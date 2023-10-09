game_surface = -1;
global.tile_mode = true

drag_box_i = -1
drag_box_j = -1
dragging = false

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

	arr[@tile_i][tile_j] = new tile_with_state(new_tile, properties)
}

function handle_click(tile_i, tile_j) {
	switch (global.selected_thing) {
		case thing_eraser:
			place_placeable(tile_i, tile_j, global.editor_object.current_empty_tile)
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
			break;
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

move_curve = animcurve_get_channel(ac_play_transition, "move")
grow_curve = animcurve_get_channel(ac_play_transition, "grow")
scale_x_start = image_xscale
scale_y_start = image_yscale

base_ui = asset_get_index("spr_ev_base_ui")

invisible_tiles_layer = layer_get_id("InvisibleTiles")
graphics_tilemap = layer_tilemap_create(invisible_tiles_layer, 0, 0, global.tileset_1, 14, 8)

//wall_state_img = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
//wall_state_img = [ 0,48,48,5,48,9,12,9,48,3,14,4,10,6,11,1 ]

ind = 0
