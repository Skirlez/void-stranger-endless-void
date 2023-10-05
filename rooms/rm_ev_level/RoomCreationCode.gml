placeable_object_map = ds_map_create()

placeable_object_map[? pit_id] = "obj_pit"
placeable_object_map[? glass_id] = "obj_glassfloor"
placeable_object_map[? mine_id] = "obj_bombfloor"
placeable_object_map[? default_tile_id] = "obj_floor"
placeable_object_map[? exit_id] = "obj_exit"

placeable_object_map[? player_id] = "obj_spawnpoint"
placeable_object_map[? leech_id] = "obj_enemy_cl"
placeable_object_map[? maggot_id] = "obj_enemy_cc"
placeable_object_map[? bull_id] = "obj_enemy_cg"
placeable_object_map[? gobbler_id] = "obj_enemy_cs"


if (!instance_exists(asset_get_index("obj_ev_editor"))) {
	room_goto(asset_get_index("rm_ev_editor"))
	exit
}
	


function create(i, j, layerr, name) {
	var game_object = asset_get_index(name)
	return instance_create_layer(j * 16 + 8, i * 16 + 8, layerr, game_object)
}

for (var i = 0; i < 9; i++) {
	for (var j = 0; j < 14; j++) {
		if i != 8 {
			var tile_state = global.level_tiles[i][j];
			var tile = tile_state.tile
			var game_object = placeable_object_map[? tile.tile_id]
			if is_undefined(game_object)
				show_message(tile.tile_id)
			var layerr = ""
			switch (tile.tile_id) {
				default:
					layerr = "Floor_INS"
					break;
				case default_tile_id:
					layerr = "Floor"
					break;
				case pit_id:
					layerr = "Pit"
					break;
				
			}
			create(i, j, layerr, game_object)
		}
		
		var object_state = global.level_objects[i][j];
		var object = object_state.tile
		if (object.tile_id != empty_id) {
			var game_object = placeable_object_map[? object.tile_id]
			if is_undefined(game_object)
				show_message(object.tile_id)
			var layerr = ""
			switch (object.tile_id) {
				default:
					layerr = "Instances"
					break;
				
			}
			var inst = create(i, j, layerr, game_object)
			switch (object.tile_id) {
				case leech_id:
				case maggot_id:
					inst.set_e_direction = object_state.properties.dir;
			}
		}
	}
}


ds_map_destroy(placeable_object_map)