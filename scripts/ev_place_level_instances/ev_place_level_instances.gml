function ev_place_level_instances(level, should_create_memory = true) {
	global.wall_tilemaps = array_create(wall_types.size)
	global.edge_tilemaps = array_create(edge_types.size)
	
	global.wall_tilemaps[wall_types.normal] = layer_tilemap_create("Tiles_Wall", 0, 0, global.tileset_1, 224, 144)
	global.edge_tilemaps[edge_types.normal] = layer_tilemap_create("Tiles_Edge", 0, 0, global.tileset_edge, 224, 144)
	global.edge_tilemaps[edge_types.dis] = layer_tilemap_create("Tiles_DIS_Edge", 0, 0, global.tileset_edge_dis, 224, 144)

	global.wall_tilemaps[wall_types.mon] = layer_tilemap_create("Tiles_Mon_Wall", 0, 0, global.tileset_mon, 224, 144)
	global.wall_tilemaps[wall_types.dis] = layer_tilemap_create("Tiles_DIS_Wall", 0, 0, global.tileset_dis, 224, 144)
	global.wall_tilemaps[wall_types.ex] = layer_tilemap_create("Tiles_EX_Wall", 0, 0, global.tileset_ex, 224, 144)
	
	if level.theme == level_themes.white_void {
		var bg_layer = layer_get_id("Background")
		var bg = layer_background_get_id(bg_layer)
		layer_background_blend(bg, c_white)
	}
	
	var extra_data = {
		lvl : level,
		wall_tilemaps : global.wall_tilemaps,
		edge_tilemaps : global.edge_tilemaps,
		should_create_memory : should_create_memory,
		current_exit_number : 0,
	}
	for (var i = 0; i < 9; i++) {
		for (var j = 0; j < 14; j++) {
			var tile_state = level.tiles[i][j];
			var tile = tile_state.tile
			if i != 8 {
				tile.iostruct.place(tile_state, i, j, extra_data)
			}
			var object_state = level.objects[i][j];
			var object = object_state.tile
			object.iostruct.place(object_state, i, j, extra_data)
		}
	}
	
	var bount_string;
	if level.bount == -1
		bount_string = "V???"
	else {
		bount_string = "V"
		ds_grid_set(agi("obj_inventory").ds_player_info, 1, 2, level.bount)
	}	
	ds_grid_set(agi("obj_inventory").ds_player_info, 0, 2, bount_string)
	
	// this creates collision where there's wall tiles (where there's the absence of the pit object)
	with (agi("obj_game")) {
		event_perform(ev_alarm, 5)	
	}
}

