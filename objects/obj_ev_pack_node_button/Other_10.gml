event_inherited();

if !selected {
	global.pack_editor_instance.select(pack_things.selector)
	var nodes = global.pack_editor_instance.nodes_list;
	for (var i = 0; i < array_length(nodes); i++) {
		var node_state = new node_with_state(nodes[i], x, y);
		var instance = node_state.write_instance();
		instance.in_menu = true;
		if (nodes[i].flags & node_flags.only_one && instance_number(instance.object_index) != 1) {
			instance.unselectable = true;
		}
		instance.layer = layer_get_id("NodesInMenu");
		array_push(node_instances, instance)
	}
	update_node_instances_positions()
}
else
	global.pack_editor_instance.select(pack_things.nothing)