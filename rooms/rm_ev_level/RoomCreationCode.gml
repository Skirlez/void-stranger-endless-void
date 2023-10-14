ev_prepare_level()
placeable_object_map = ds_map_create()

placeable_object_map[? pit_id] = "obj_pit"
placeable_object_map[? glass_id] = "obj_glassfloor"
placeable_object_map[? mine_id] = "obj_bombfloor"
placeable_object_map[? default_tile_id] = "obj_floor"
placeable_object_map[? floorswitch_id] = "obj_floorswitch"
placeable_object_map[? copyfloor_id] = "obj_copyfloor"
placeable_object_map[? exit_id] = "obj_exit"
placeable_object_map[? deathfloor_id] = "obj_deathfloor"
placeable_object_map[? white_id] = "obj_floor_blank"
placeable_object_map[? wall_id] = noone
placeable_object_map[? edge_id] = noone

placeable_object_map[? player_id] = "obj_spawnpoint"
placeable_object_map[? leech_id] = "obj_enemy_cl"
placeable_object_map[? maggot_id] = "obj_enemy_cc"
placeable_object_map[? gobbler_id] = "obj_enemy_cs"
placeable_object_map[? bull_id] = "obj_enemy_cg"
placeable_object_map[? hand_id] = "obj_enemy_ch"
placeable_object_map[? mimic_id] = "obj_enemy_cm"
placeable_object_map[? diamond_id] = "obj_enemy_co"



function create(i, j, layerr, name) {
	var game_object = asset_get_index(name)
	return instance_create_layer(j * 16 + 8, i * 16 + 8, layerr, game_object)
}


wall_tilemap = layer_tilemap_create("Tiles_1", 0, 0, global.tileset_1, 224, 144)
edge_tilemap = layer_tilemap_create("Tiles_2", 0, 0, global.tileset_edge, 224, 144)

for (var i = 0; i < 9; i++) {
	for (var j = 0; j < 14; j++) {
		if i != 8 {
			var tile_state = global.level_tiles[i][j];
			var tile = tile_state.tile
			var game_object = placeable_object_map[? tile.tile_id]
			if is_undefined(game_object)
				show_message(tile.tile_id)
			var layerr = ""
			var abort = false;
			switch (tile.tile_id) {
				default:
					layerr = "Floor"
					break;
				case glass_id:
					layerr = "Floor_INS"
					break;
				case pit_id:
					layerr = "Pit"
					break;
				case wall_id:
					abort = true;
					tilemap_set(wall_tilemap, tile_state.properties.ind, j, i)
					break;
				case edge_id:
					abort = true
					runtile_update_blob(edge_tilemap, j, i, false)
					break;
				
			}
			if !abort
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
					inst.editor_dir = object_state.properties.dir;
					break;
				default:
					break;
			}
		}
	}
}

// second pass for graphic tiles
for (var i = 1; i < 8; i++) {
	for (var j = 1; j < 13; j++) {
		
	}
}



ds_map_destroy(placeable_object_map)