// TODO don't get this shit every frame
function get_nodes() {
	static pack_levels_layer = layer_get_id("PackLevels")
	var display_instance_elements = layer_get_all_elements(pack_levels_layer)		
	var nodes = []
	for (var i = 0; i < array_length(display_instance_elements); i++) {
		var inst = layer_instance_get_instance(display_instance_elements[i]);
		if inst.object_index == global.display_object
			array_push(nodes, inst);
	}
	
	static nodes_layer = layer_get_id("Nodes")
	var node_instance_elements = layer_get_all_elements(nodes_layer)
	for (var i = 0; i < array_length(node_instance_elements); i++) {
		array_push(nodes, layer_instance_get_instance(node_instance_elements[i]))	
	}
	return nodes;
}

nodes = get_nodes();