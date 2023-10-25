// TODO: as it is there is a lot of code copied twice for tiles and object tiles,
// reusing more code would be ideal.


#macro BASE64_END_CHAR "!"
#macro MULTIPLIER_CHAR "X"
function num_to_string(num, length) {
	return string_replace(string_format(num, length, 0), " ", 0)	
}

// returns the level in string format
function export_level() {
	var tile_string = ""
	var object_string = ""
	
	var tile_previous = "";
	var object_previous = ""
	
	var tile_multiplier = 0;
	var object_multiplier = 0;
	
	for (var i = 0; i < 9; i++)	{
		for (var j = 0; j < 14; j++) {
			if (i != 8) {
				var addition = ""
				tile_state = global.level_tiles[i][j]
				var tile_id = tile_state.tile.tile_id
				addition += tile_id
				switch (tile_id) {
					case wall_id:
					case edge_id:
						addition += num_to_string(tile_state.properties.ind, 2)
						break;
					default:
						break;
				}
				
				if (addition == tile_previous)
					tile_multiplier++;
				else {
					if tile_multiplier != 0 { 
						tile_string += MULTIPLIER_CHAR + string(tile_multiplier)
						tile_multiplier = 0	
					}
					tile_string += addition;
				}
				tile_previous = addition
			}
			
			var addition = ""
			object_state = global.level_objects[i][j]
			var object_id = object_state == noone ? "em" : object_state.tile.tile_id
			
			addition += object_id
			switch (object_id) {
				case leech_id:
				case maggot_id:
					addition += string(object_state.properties.dir)
					break;
				case mimic_id:
					addition += string(object_state.properties.typ)
					break;
				case egg_id:
					addition += base64_encode(object_state.properties.txt) + BASE64_END_CHAR
					break;
				case cif_id:
					addition += string(object_state.properties.lmp)
					break;
				default:
					break;
			}
			
			
			if (addition == object_previous)
				object_multiplier++;
			else {
				if object_multiplier != 0 { 
					object_string += MULTIPLIER_CHAR + string(object_multiplier)
					object_multiplier = 0	
				}
				object_string += addition;
			}
			object_previous = addition
		}
	}
	
	if tile_multiplier != 0 
		tile_string += MULTIPLIER_CHAR + string(tile_multiplier)
	
	if object_multiplier != 0 
		object_string += MULTIPLIER_CHAR + string(object_multiplier)
	
	return tile_string + "|" + object_string

}


// imports a level from a level string
function import_level(tile_string, object_string) {
	var tile_pointer = 1
	var object_pointer = 1
	var i = 0;
	var j = 0;
	
	var previous_tile_string = ""
	var previous_object_string = ""
	while (i < 9) {
		if i != 8 {
			tile_string = consider_multiplier(tile_string, tile_pointer, previous_tile_string)
			var pointer_start = tile_pointer
			
			var tile_id = string_copy(tile_string, tile_pointer, 2)
			tile_pointer += 2
			var tile = ds_map_find_value(global.placeable_name_map, tile_id)
			if is_undefined(tile)
				tile = global.editor_object.tile_pit
		

			switch (tile_id) {
				case edge_id:
				case wall_id:
					var read_ind = string_copy(tile_string, tile_pointer, 2)
					tile_pointer += 2;
					global.level_tiles[@ i][j] = new tile_with_state(tile, { ind: int64(read_ind) });
					break;
				default:
					global.level_tiles[@ i][j] = new tile_with_state(tile);
					break;
			}
			previous_tile_string = string_copy(tile_string, pointer_start, tile_pointer - pointer_start)
		}
		else
			global.level_tiles[@ i][j] = new tile_with_state(global.editor_object.tile_unremovable);
		
		object_string = consider_multiplier(object_string, object_pointer, previous_object_string)
		var pointer_start = object_pointer
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
				global.level_objects[@ i][j] = new tile_with_state(object, { dir: bool(int64(read_dir)) });
				break;
			case mimic_id:
				var read_type = string_copy(object_string, object_pointer, 1)
				object_pointer++	
				global.level_objects[@ i][j] = new tile_with_state(object, { typ: int64(read_type) });
				break;
			case egg_id:
				var count = 0
				do {
					var read_end = string_copy(object_string, object_pointer + count, 1)	
					count++;
				} until read_end == BASE64_END_CHAR
				
				var read_string = string_copy(object_string, object_pointer, count)
				object_pointer += count;
				global.level_objects[@ i][j] = new tile_with_state(object, { txt: base64_decode(read_string) });
				show_debug_message(base64_decode(read_string))
				break;
			case cif_id:
				var read_lamp = string_copy(object_string, object_pointer, 1)
				object_pointer++
				global.level_objects[@ i][j] = new tile_with_state(object, { lmp: bool(int64(read_lamp)) });
				break;
			default:
				global.level_objects[@ i][j] = new tile_with_state(object)
				break;
		}
		previous_object_string = string_copy(object_string, pointer_start, object_pointer - pointer_start)
		
		j++;
		if j >= 14 {
			j = 0
			i++;
		}
		
	}
	
}

function is_digit(str) {
	return str != "" && str == string_digits(str)	
}

function consider_multiplier(str, pointer, previous_string) {
	if string_copy(str, pointer, 1) != MULTIPLIER_CHAR
		return str;
	var num_string = "";
	var count = 0;
	while (true) {
		var read_char = string_copy(str, pointer + count + 1, 1)
		if is_digit(read_char) {
			num_string += read_char
			count++;
			continue;
		}
		break;
	}

	var num = int64(num_string)
	str = string_delete(str, pointer, count + 1)
	
	repeat (num)
		str = string_insert(previous_string, str, pointer)
	
	return str;
}