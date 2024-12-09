event_inherited();

function remove_connections_to_node(node) {
	with_all_nodes(function (node, target_node) {
		for (var i = 0; i < array_length(node.exit_instances); i++) {
			if (node.exit_instances[i] == target_node) {
				array_delete(node.exit_instances, i, 1)
				return;
			}
		}
	}, node)	
}

switch (judgment_type) {
	case judgment_types.destroy_node:
		remove_connections_to_node(node_inst)
		if (node_inst.object_index == global.display_object)
			node_inst.destroy();
		else
			instance_destroy(node_inst)
		break;
	case judgment_types.close_connection:
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			if node_inst.exit_instances[i] == connection_to_destroy {
				array_delete(node_inst.exit_instances, i, 1)
				break;
			}
		}
		audio_play_sound(asset_get_index("snd_ev_node_disconnect"), 10, false, 1, 0, random_range(0.9, 1.1))
		instance_destroy(id)
		break;
	
}