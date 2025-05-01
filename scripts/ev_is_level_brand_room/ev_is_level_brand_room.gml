function is_solid(tile) {
	static solids = [global.editor_instance.tile_wall, global.editor_instance.tile_mon_wall,
					global.editor_instance.tile_dis_wall, global.editor_instance.tile_ex_wall,
					global.editor_instance.tile_chest];
	for (var i = 0; i < array_length(solids); i++) {
		if tile == solids[i]
			return true;
	}
	return false;
}
function is_level_brand_room(lvl) {
	for (var i = 0; i <= 7; i += 7) {
		for (var j = 3; j <= 10; j++) {
			if !is_solid(lvl.tiles[i][j].tile)
				return false;
		}
	}
	for (var j = 3; j <= 10; j += 7) {
		for (var i = 0; i <= 7; i++) {
			if !is_solid(lvl.tiles[i][j].tile)
				return false;
		}
	}
	return true;
}

/*
// live version
for (var i = 0; i <= 7; i += 7) {
	for (var j = 3; j <= 10; j++) {
		var instance = instance_position(j * 16 + 8, i * 16 + 8, agi("obj_collision"))
		if !instance_exists(instance) {
			return false;
		}
	}
}
for (var j = 3; j <= 10; j += 7) {
	for (var i = 0; i <= 7; i++) {
		var instance = instance_position(j * 16 + 8, i * 16 + 8, agi("obj_collision"))
		if !instance_exists(instance) {
			return false;
		}
	}
}
return true;
*/