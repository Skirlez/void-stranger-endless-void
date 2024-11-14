event_inherited();

if !selected {
	pack_editor_inst().select(pack_things.selector)
	var nodes = pack_editor_inst().nodes_list;
	for (var i = 0; i < array_length(nodes); i++) {
		var node_state = new node_with_state(nodes[i], 100 + i * 20, 100);
		var instance = node_state.write_instance();
		instance.in_menu = true;
		instance.layer = layer_get_id("NodesInMenu");
		array_push(node_instances, instance)
	}
	
}
else
	pack_editor_inst().select(pack_things.nothing)