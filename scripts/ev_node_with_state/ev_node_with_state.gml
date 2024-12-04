function node_with_state(node, pos_x, pos_y, properties = node.properties_generator()) constructor {
	self.node = node;
	self.pos_x = pos_x;
	self.pos_y = pos_y;
	self.exits = [];
	self.properties = properties;
	
	
	function write(node_index_map) {
		var position_string = string(floor(pos_x)) + "," + string(floor(pos_y))
		var properties_string = node.write_function(self);
		if array_length(exits) == 0
			return node.node_id + "#" + position_string + "##" + properties_string;
			
		var exits_string = string(ds_map_find_value(node_index_map, exits[0]))
		for (var i = 1; i < array_length(exits); i++) {
			exits_string += "," + string(ds_map_find_value(node_index_map, exits[i]))
		}
		
		
		return node.node_id + "#" + position_string + "#" + exits_string + "#" + properties_string;
	}
	
	function write_instance() {
		return node.write_instance_function(self);	
	}
	
	self.intermediary_numbered_exits = [];
}