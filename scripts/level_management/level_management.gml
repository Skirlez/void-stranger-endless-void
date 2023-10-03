

function string_copy_boundless(str, index, count) {
	newstr = ""
	for (var i = 0; i < count; i++) {
		if (i > 0 && i <= string_length(str))
			newstr += string_char_at(str, index + i)
		else
			newstr += " "
	}
	return newstr;
}

// returns the level in string format
function export_level() {
	tile_string = ""
	object_string = ""
	
	for (var i = 0; i < 9; i++)	{
		for (var j = 0; j < 14; j++) {
			if (i != 8) {
				tile_state = global.editor_object.level_tiles[i][j]
				var tile_id = tile_state.tile.tile_id
				tile_string += tile_id
				switch (tile_id) {
					default:
						break;
				}
			}
			
			object_state = global.editor_object.level_objects[i][j]
			var object_id = object_state == noone ? "em" : object_state.tile.tile_id
			
			object_string += object_id
			switch (object_id) {
				case leech_id:
				case maggot_id:
					object_string += string(object_state.properties.dir)
					break;
				default:
					break;
			}
			
		}
	}
	
	return tile_string + "|" + object_string

}


// imports a level from a level string
function import_level(tile_string, object_string) {
	var tile_pointer = 1
	var object_pointer = 1
	var i = 0;
	var j = 0;
	while (i < 9) {
		if i != 8 {
			var tile_id = string_copy(tile_string, tile_pointer, 2)
			tile_pointer += 2
			var tile = ds_map_find_value(global.placeable_name_map, tile_id)
			if is_undefined(tile)
				tile = global.editor_object.tile_pit
		
			switch (tile_id) {
				default:
					global.editor_object.level_tiles[@ i][j] = new tile_with_state(tile);
					break;
			}
		}
		else
			global.editor_object.level_tiles[@ i][j] = new tile_with_state(global.editor_object.tile_unremovable_white);
		
		
		var object_id = string_copy(object_string, object_pointer, 2)
		object_pointer += 2
		var object = ds_map_find_value(global.placeable_name_map, object_id)
		if is_undefined(object)
			object = global.editor_object.object_empty
	
		switch (object_id) {
			case leech_id:
			case maggot_id:
				var read_dir = string_copy(object_string, object_pointer, 1)
				object_pointer++
				global.editor_object.level_objects[@ i][j] = new tile_with_state(object, { dir: bool(int64(read_dir)) });
				break;
			default:
				if (object == global.editor_object.object_player)
					show_debug_message("here")
				global.editor_object.level_objects[@ i][j] = new tile_with_state(object)
				break;
		}
		
		j++;
		if j >= 14 {
			j = 0
			i++;
		}
	}
	
}

