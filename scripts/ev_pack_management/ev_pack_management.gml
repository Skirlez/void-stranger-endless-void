function pack_struct() constructor {
	name = ""
	description = ""
	author = "Anonymous"
	author_brand = int64(0)
	
	starter_nodes = []

	// This name will be used for when the file is saved
	save_name = generate_level_save_name()
	
	upload_date = "";
	last_edit_date = "";	
}

	
function node_struct() constructor {
	exits = []
}
function brand_node(brand) : node_struct() constructor {
	self.brand = brand;
}
function level_node(lvl) : node_struct() constructor {
	self.lvl = lvl;
}
function music_node(music_string) : node_struct() constructor {
	self.music_string = music_string;
}
function conditional_node(branefuck) : node_struct() constructor {
	self.branefuck = branefuck;
}


// returns an array of all the starting nodes as structs with all the nodes they're connected to also converted to structs and linked to each other
function convert_room_nodes_to_structs() {
	var starter_nodes = []
	
	static root = asset_get_index("obj_ev_pack_root")
	var first_level = noone
 	with (root) {
		if array_length(exit_instances) == 1
			first_level = exit_instances[0]
	}
	if !instance_exists(first_level) {
		return starter_nodes;
	}
	
	// creates and returns a node struct for this node instance. any nodes this node connects to will also be converted to structs and linked.
	function explore_node(node_inst, explored_instances_map) {
		
		static display_object = asset_get_index("obj_ev_display");
		
		if (ds_map_exists(explored_instances_map, node_inst))
			return ds_map_find_value(explored_instances_map, node_inst);
		
		var node;
		if (node_inst.object_index == display_object)
			node = new level_node(node_inst.lvl)
		else
			node = new node_struct()
		
		ds_map_set(explored_instances_map, node_inst, node)
		
		var exit_nodes = []
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			var exit_node = explore_node(node_inst.exit_instances[i], explored_instances_map)
			array_push(exit_nodes, exit_node)
		}

			
		node.exits = exit_nodes;

		return node;
	}
	
	var map = ds_map_create()
	var node = explore_node(first_level, map)
	ds_map_destroy(map)
	
	array_push(starter_nodes, node)
	
	show_debug_message("test")

	return starter_nodes;
}


function export_pack_arr(pack) {

}