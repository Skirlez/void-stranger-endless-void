function pack_struct() constructor {
	name = ""
	description = ""
	author = "Anonymous"
	author_brand = int64(0)
	starting_node_states = []
	// This name will be used for when the file is saved
	save_name = generate_save_name()
	upload_date = "";
	last_edit_date = "";
	
	
	current_node = noone;
}




function place_pack_into_room(pack) {
	var node_instances = get_all_node_instances();
	for (var i = 0; i < array_length(node_instances); i++) {
		instance_destroy(node_instances[i]);	
	}
	
	var map = ds_map_create();
	function place_node_and_exits(node_state, explored_structs_map) {
		if (ds_map_exists(explored_structs_map, node_state))
			return ds_map_find_value(explored_structs_map, node_state);
		var instance = node_state.write_instance();
		ds_map_set(explored_structs_map, node_state, instance);
		
		for (var i = 0; i < array_length(node_state.exits); i++) {
			var exit_instance = place_node_and_exits(node_state.exits[i], explored_structs_map)
			array_push(instance.exit_instances, exit_instance)
		}
		return instance;
	}
	
	for (var i = 0; i < array_length(pack.starting_node_states); i++) {
		place_node_and_exits(pack.starting_node_states[i], map);
	}
	ds_map_destroy(map);
}

// returns an array of all the starting nodes as structs with all the nodes they're connected to also converted to structs and linked to each other
function convert_room_nodes_to_structs() {
	var starting_node_states = []
	
	static root = asset_get_index("obj_ev_pack_root")
	
	// creates and returns a node state struct for this node instance
	// any nodes this node connects to will also have state structs created and linked.
	function explore_node_and_convert_to_struct(node_inst, explored_instances_map) {
		static display_object = asset_get_index("obj_ev_display");
		
		if (ds_map_exists(explored_instances_map, node_inst))
			return ds_map_find_value(explored_instances_map, node_inst);
		
		var node_state = pack_editor_inst().get_node_state_from_instance(node_inst);
		
		ds_map_set(explored_instances_map, node_inst, node_state)
		
		var exits = []
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			var exit_node_state = explore_node_and_convert_to_struct(node_inst.exit_instances[i], explored_instances_map)
			array_push(exits, exit_node_state)
		}
		node_state.exits = exits;
		return node_state;
	}
	var root_id = noone
	with (root)
		root_id = id;
	
	var map = ds_map_create()
	var node_state = explore_node_and_convert_to_struct(root_id, map)
	array_push(starting_node_states, node_state)
	
	var instances = get_all_node_instances()
	for (var i = 0; i < array_length(instances); i++) {
		var node_inst = instances[i];
		if (ds_map_exists(map, node_inst))
			continue;
		node_state = explore_node_and_convert_to_struct(node_inst, map)
		array_push(starting_node_states, node_state)
	}
	
	ds_map_destroy(map)
	
	
	
	return starting_node_states;
}

function import_pack_nodeless(pack_string) {
	var pack = new pack_struct();
	var arr = ev_string_split(pack_string, "&")
	pack.version = int64_safe(arr[0], 1);
	pack.name = base64_decode(arr[1])
	pack.description = base64_decode(arr[2])
	pack.author = base64_decode(arr[3])
	pack.author_brand = int64_safe(arr[4], 0);
	pack.upload_date = arr[5]
	pack.last_edit_date = arr[6];
	return pack;
}

function import_pack(pack_string) {
	var pack = new pack_struct();
	
	var arr = ev_string_split(pack_string, "&")
	
	pack.version = int64_safe(arr[0], 1);
	pack.name = base64_decode(arr[1])
	pack.description = base64_decode(arr[2])
	pack.author = base64_decode(arr[3])
	pack.author_brand = int64_safe(arr[4], 0);
	pack.upload_date = arr[5]
	pack.last_edit_date = arr[6];
	var node_string = arr[7];
	
	var all_node_states = [];
	
	
	// $ is reserved for this purpose - it cannot be used anywhere else but delimiting node state strings
	var node_state_strings = ev_string_split(node_string, "$");
	
	for (var i = 0; i < array_length(node_state_strings); i++) {
		var node_state = read_node_state(node_state_strings[i])
		array_push(all_node_states, node_state)
	}
		
	// this list is the same size as `all_node_states`, and keeps track of if the node at that index has any other nodes connecting to it.
	// later we check for nodes without any connections - those are the starting nodes.
	var has_anyone_connected = array_create(array_length(all_node_states), false);
		
	for (var i = 0; i < array_length(all_node_states); i++) {
		var node_state = all_node_states[i];
		for (var j = 0; j < array_length(node_state.intermediary_numbered_exits); j++) {
			var index = node_state.intermediary_numbered_exits[j];
			array_push(node_state.exits, all_node_states[index])
			has_anyone_connected[index] = true;
		}
		node_state.intermediary_numbered_exits = [];
	}
	
	for (var i = 0; i < array_length(has_anyone_connected); i++) {
		if (!has_anyone_connected[i])
			array_push(pack.starting_node_states, all_node_states[i])
	}
		
	return pack;
}


function read_node_struct_from_state_string(str) {
	var node_id = string_copy(str, 1, 2);
	return ds_map_find_value(global.id_node_map, node_id);
}
function read_node_properties_from_state_string(str) {
	var hash_count = 0;
	var pos = 1
	while (hash_count < 3 && pos <= string_length(str)) {
		if string_char_at(str, pos) == "#"
			hash_count++;
		pos++;
	}
	var properties_str = string_copy(str, pos, string_length(str) - pos + 1);
	return properties_str;
}

function read_node_state(str) {
	var pos = 1;
	var node_id = string_copy(str, pos, 2)
	pos += 2
	var node = ds_map_find_value(global.id_node_map, node_id)

	// skip over hash
	pos++;
	
	var pos_x;
	
	var result_1 = read_string_until(str, pos, ",")
	var pos_x = int64_safe(result_1.substr, 0);
	pos += result_1.offset + 1;
	
	var result_2 = read_string_until(str, pos, "#")
	var pos_y = int64_safe(result_2.substr, 0);
	pos += result_2.offset + 1;
	
	var node_state = new node_with_state(node, pos_x, pos_y, noone)
	
	
	// TODO: this sucks
	if (string_copy(str, pos, 1) != "#") {
		while (true) {
			var read_num = read_uint(str, pos);
			array_push(node_state.intermediary_numbered_exits, read_num.number);
			pos += read_num.offset;
			if (string_copy(str, pos, 1) == "#")
				break;
			pos++;
		}
	}
	// skip over hash
	pos++; 
	
	var properties_str = string_copy(str, pos, string_length(str) - pos + 1);
	node_state.properties = node.read_function(properties_str, global.newest_version);
	
	return node_state;
}


function export_pack_arr(pack) {
	var version_string = string(global.latest_pack_format);
	var name_string = base64_encode(pack.name)	
	var description_string = base64_encode(pack.description)	
	var author_string = base64_encode(pack.author)
	var author_brand_string = string(pack.author_brand)
	var upload_date_string = "";
	var last_edit_date_string = "";
	var node_string = ""
	
	
	// populates list with a list of all the node states that came from the `node_state` parameter.
	// the map will be a map of nodes to their indices.
	function explore_node_and_map_to_index(node_state, node_index_map, list) {
		if (ds_map_exists(node_index_map, node_state))
			return;
		ds_map_set(node_index_map, node_state, ds_map_size(node_index_map))
		array_push(list, node_state)
		for (var i = 0; i < array_length(node_state.exits); i++) {
			explore_node_and_map_to_index(node_state.exits[i], node_index_map, list)
		}
	}
	
	
	if (array_length(pack.starting_node_states) > 0) {
		var node_states_list = []
		var node_index_map = ds_map_create();
		for (var i = 0; i < array_length(pack.starting_node_states); i++) {
			explore_node_and_map_to_index(pack.starting_node_states[i], node_index_map, node_states_list)
		}

		for (var i = 0; i < array_length(node_states_list); i++) {
			var node_state = node_states_list[i];
			node_string += node_state.write(node_index_map) + "$"
		}
		node_string = string_delete(node_string, string_length(node_string), 1);
		
		ds_map_destroy(node_index_map);
	}
	
	
	return [version_string, name_string, description_string, author_string, 
		author_brand_string, upload_date_string, last_edit_date_string, node_string]
	
}


function export_pack(pack) {
	var arr = export_pack_arr(pack)
	var str = arr[0]
	for (var i = 1; i < array_length(arr); i++) {
		str += "&" + arr[i];
	}
	
	return str;
}


function get_thumbnail_level_string_from_pack_string(pack_string) {
	var arr = ev_string_split(pack_string, "&")
	// the seventh section contains all the nodes
	var node_string = arr[7];
	
	var node_state_strings = ev_string_split(node_string, "$");
	for (var i = 0; i < array_length(node_state_strings); i++) {
		var node = read_node_struct_from_state_string(node_state_strings[i]);
		if (node != pack_editor_inst().thumbnail_node) 
			continue;
		var node_state = read_node_state(node_state_strings[i]);
		if (array_length(node_state.intermediary_numbered_exits) != 1) 
			continue;
		var index = node_state.intermediary_numbered_exits[0];
		
		var level_node_string = node_state_strings[index];
		if (read_node_struct_from_state_string(level_node_string) != pack_editor_inst().level_node)
			continue;
			
		var level_string = read_node_properties_from_state_string(level_node_string);
		return level_string;
	}
	// haven't got any thumbnail nodes connected to levels. just use any level we find
	for (var i = 0; i < array_length(node_state_strings); i++) {
		var node = read_node_struct_from_state_string(node_state_strings[i]);
		if (node == pack_editor_inst().level_node) {
			var level_string = read_node_properties_from_state_string(node_state_strings[i]);
			return level_string;
		}
	}
	// fuck
	return noone;
}

function read_pack_string_from_file(save_name) {
	var file = file_text_open_read(global.packs_directory + save_name + "." + pack_extension)
	var pack_string = file_text_read_string(file)
	file_text_close(file)
	return pack_string;
}