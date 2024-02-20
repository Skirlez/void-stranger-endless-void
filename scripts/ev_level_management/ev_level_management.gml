// TODO: as it is there is a lot of code copied twice for tiles and object tiles,
// reusing more code would be ideal.


#macro BASE64_END_CHAR "!"
#macro MULTIPLIER_CHAR "X"
function num_to_string(num, length) {
	return string_replace(string_format(num, length, 0), " ", 0)	
}
function string_is_uint(str) {
	return str != "" && string_length(str) == string_length(string_digits(str));
}

function level_struct() constructor {
	version = 1;
	name = ""
	description = ""
	music = global.music_names[1]
	burdens = [false, false, false, false]
	author = "Anonymous"
	author_brand = "10101010101010101010101010101010101010"
	tiles = array_create(9);
	objects = array_create(9);
	for (var i = 0; i < array_length(tiles) - 1; i++)
		tiles[i] = array_create(14, new tile_with_state(global.editor_instance.tile_pit))	
	tiles[8] = array_create(14, new tile_with_state(global.editor_instance.tile_unremovable))	
	
	for (var i = 0; i < array_length(objects); i++)
		objects[i] = array_create(14, new tile_with_state(global.editor_instance.object_empty))	
		
	// This name will be used for when the file is saved.
	save_name = base64_encode(date_datetime_string(date_current_datetime()))
}



function combine_strings(separator) {
	var str = ""
	for (var i = 1; i < argument_count - 1; i++)
		str += argument[i] + separator;
	return str + argument[argument_count - 1];
}

function string_split(str, delimiter) {
	var arr = []
	var build = ""
	for (var i = 1; i <= string_length(str); i++) {
		var c = string_char_at(str, i)
		if (c == delimiter) {
			array_push(arr, build);	
			build = ""
		}
		else
			build += c;	
	}
	if (build != "")
		array_push(arr, build);	
	return arr;
}


// returns the level in string format
function export_level(level) {
	var version_string = string(level.version);
	var name_string = base64_encode(level.name)	
	var description_string = base64_encode(level.description)	
	var music_string = base64_encode(level.music)	
	var author_string = base64_encode(level.author)
	var author_brand_string = level.author_brand
	var burdens_string = ""
	for (var i = 0; i < array_length(level.burdens); i++)
		burdens_string += string(level.burdens[i])

	
	
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
				var tile_state = level.tiles[i][j]
				var tile_id = tile_state.tile.tile_id
				addition += tile_id
				switch (tile_id) {
					case wall_id:
					case edge_id:
						addition += num_to_string(tile_state.properties.ind, 2)
						break;
					case chest_id:
						addition += num_to_string(tile_state.properties.itm, 2)
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
			var object_state = level.objects[i][j]
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
					var arrlen = array_length(object_state.properties.txt)
					var sub_addition = ""
					var m
					for (m = 0; m < arrlen; m++) {
						var txt = object_state.properties.txt[m]
						if txt == ""
							break;
						sub_addition += base64_encode(txt) + BASE64_END_CHAR	
					}
					if m == 0 {
						addition += "0"
						break;	
					}
					addition += string(m) + sub_addition
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
	
	return combine_strings("|", version_string, name_string, description_string,
		music_string, author_string, author_brand_string, burdens_string, tile_string, object_string)

}


// imports a level from a level string
function import_level(level_string) {
	var level = new level_struct()
	
	var strings = string_split(level_string, "|");
	if array_length(strings) != 9 {
		return "Invalid amount of level data sections! Should be 9, instead got " + string(array_length(strings))	
	}
	var version_string = strings[0];
	if !string_is_uint(version_string)
		return "Invalid version: " + version_string
	level.version = int64(version_string);
		
	level.name = base64_decode(strings[1]);
	level.description = base64_decode(strings[2]);
	level.music = base64_decode(strings[3]);
	level.author = base64_decode(strings[4])
	level.author_brand = strings[5]
	
	var burdens_string = strings[6];
	if string_length(burdens_string) != 4
		return "Invalid burden string length: " + string_length(burdens_string);
	for (var i = 0; i < 4; i++)
		level.burdens[i] = (string_char_at(burdens_string, i + 1)) == "0" ? false : true;	

	var tile_string = strings[7]
	var object_string = strings[8]
	
	var tile_pointer = 1
	var object_pointer = 1
	var i = 0;
	var j = 0;
	
	var previous_tile_string = ""
	var previous_object_string = ""

	while (i < 9) {
		if i != 8 {
			tile_string = consider_multiplier(tile_string, tile_pointer, previous_tile_string)
			var tile_pointer_start = tile_pointer
			
			var tile_id = string_copy(tile_string, tile_pointer, 2)
			tile_pointer += 2
			var tile = ds_map_find_value(global.placeable_name_map, tile_id)
			if is_undefined(tile)
				tile = global.editor_instance.tile_pit
		

			switch (tile_id) {
				case edge_id:
				case wall_id:
					var read_ind = string_copy(tile_string, tile_pointer, 2)
					tile_pointer += 2;
					level.tiles[@ i][j] = new tile_with_state(tile, { ind: int64(read_ind) });
					break;
				case chest_id:
					var read_item = string_copy(tile_string, tile_pointer, 2)
					tile_pointer += 2
					level.tiles[@ i][j] = new tile_with_state(tile, { itm : int64(read_item) });
					break;
				default:
					level.tiles[@ i][j] = new tile_with_state(tile);
					break;
			}
			previous_tile_string = string_copy(tile_string, tile_pointer_start, tile_pointer - tile_pointer_start)
		}
		else
			level.tiles[@ i][j] = new tile_with_state(global.editor_instance.tile_unremovable);
		
		object_string = consider_multiplier(object_string, object_pointer, previous_object_string)
		var object_pointer_start = object_pointer
		var object_id = string_copy(object_string, object_pointer, 2)
		object_pointer += 2
		
		var object = ds_map_find_value(global.placeable_name_map, object_id)
		if is_undefined(object)
			object = global.editor_instance.object_empty
		
		switch (object_id) {
			case leech_id:
			case maggot_id:
				var read_dir = string_copy(object_string, object_pointer, 1)
				object_pointer++
				level.objects[@ i][j] = new tile_with_state(object, { dir: bool(int64(read_dir)) });
				break;
			case mimic_id:
				var read_type = string_copy(object_string, object_pointer, 1)
				object_pointer++	
				level.objects[@ i][j] = new tile_with_state(object, { typ: int64(read_type) });
				break;
			case egg_id:
				var read_length = string_copy(object_string, object_pointer, 1)
				object_pointer++	
				var arrlen = int64(read_length);
				var txt_arr = array_create(4, "")
				for (var m = 0; m < arrlen; m++) {
					var count = 0
					do {
						var read_end = string_copy(object_string, object_pointer + count, 1)	
						count++;
					} until read_end == BASE64_END_CHAR
				
					var read_string = string_copy(object_string, object_pointer, count)
					txt_arr[m] = base64_decode(read_string)
					
					object_pointer += count;
				}
				level.objects[@ i][j] = new tile_with_state(object, { txt: txt_arr });
				break;
			case cif_id:
				var read_lamp = string_copy(object_string, object_pointer, 1)
				object_pointer++
				level.objects[@ i][j] = new tile_with_state(object, { lmp: bool(int64(read_lamp)) });
				break;
			default:
				level.objects[@ i][j] = new tile_with_state(object)
				break;
		}
		previous_object_string = string_copy(object_string, object_pointer_start, object_pointer - object_pointer_start)
		
		j++;
		if j >= 14 {
			j = 0
			i++;
		}
	}
	
	
	return level
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