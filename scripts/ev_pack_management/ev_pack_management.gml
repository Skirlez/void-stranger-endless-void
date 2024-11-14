function pack_struct() constructor {
	name = ""
	description = ""
	author = "Anonymous"
	author_brand = int64(0)
	
	starting_node_states = []

	// This name will be used for when the file is saved
	save_name = generate_level_save_name()
	
	upload_date = "";
	last_edit_date = "";	
}





// returns an array of all the starting nodes as structs with all the nodes they're connected to also converted to structs and linked to each other
function convert_room_nodes_to_structs() {
	var starting_node_states = []
	
	static root = asset_get_index("obj_ev_pack_root")
	var first_level = noone
 	with (root) {
		if array_length(exit_instances) == 1
			first_level = exit_instances[0]
	}
	if !instance_exists(first_level) {
		return starting_node_states;
	}
	
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
	
	var map = ds_map_create()
	var node_state = explore_node_and_convert_to_struct(first_level, map)
	ds_map_destroy(map)
	
	array_push(starting_node_states, node_state)
	
	return starting_node_states;
}


function export_pack_arr(pack) {
	var version_string = string(global.latest_lvl_format);
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
		var node_string = "";
		for (var i = 0; i < array_length(node_states_list); i++) {
			var node_state = node_states_list[i];
			node_string += "$" + node_state.write(node_index_map)
		}
		node_string = string_delete(node_string, 1, 1)
		ds_map_destroy(node_index_map);
	}
	
	
	return [version_string, name_string, description_string, author_string, 
		author_brand_string, upload_date_string, last_edit_date_string, node_string]
	
}