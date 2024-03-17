function ev_place_level_instances(level) {
	wall_tilemap = layer_tilemap_create("Tiles_1", 0, 0, global.tileset_1, 224, 144)
	edge_tilemap = layer_tilemap_create("Tiles_2", 0, 0, global.tileset_edge, 224, 144)

	for (var i = 0; i < 9; i++) {
		for (var j = 0; j < 14; j++) {
			var tile_state = level.tiles[i][j];
			var tile = tile_state.tile
			if i != 8 {
				tile.iostruct.place(tile_state, i, j, wall_tilemap, edge_tilemap)
			}
			var object_state = level.objects[i][j];
			var object = object_state.tile
			object.iostruct.place(object_state, i, j, wall_tilemap, edge_tilemap)
		}
	}
}

