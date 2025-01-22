event_inherited();

function create_funny_arrow(node_instance, other_node_instance) {
	var t = get_pack_line_arrow_progress();
	instance_create_layer(
		lerp(node_instance.center_x, other_node_instance.center_x, t),
		lerp(node_instance.center_y, other_node_instance.center_y, t),
		"ConnectingLines",
		asset_get_index("obj_ev_funny_arrow"))
}

function remove_connections_to_node(node) {
	
	with_all_nodes(function(node, target_node) {
		for (var i = 0; i < array_length(node.exit_instances); i++) {
			if (node.exit_instances[i] == target_node) {
				create_funny_arrow(node, target_node);
				array_delete(node.exit_instances, i, 1)
				return;
			}
		}
	}, node)	
}

switch (judgment_type) {
	case judgment_types.destroy_node:
		remove_connections_to_node(node_inst)
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			create_funny_arrow(node_inst, node_inst.exit_instances[i]);
		}
		if (node_inst.object_index == global.display_object)
			node_inst.destroy();
		else
			instance_destroy(node_inst)
		break;
	case judgment_types.close_connection:
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			if node_inst.exit_instances[i] == connection_to_destroy {
				create_funny_arrow(node_inst, node_inst.exit_instances[i]);
				array_delete(node_inst.exit_instances, i, 1)
				break;
			}
		}
		audio_play_sound(asset_get_index("snd_ev_node_disconnect"), 10, false, 1, 0, random_range(0.9, 1.1))
		if instance_number(object_index) == 1 // i'm the last one left
			pack_editor_inst().judging_node = noone;
		instance_destroy(id)

		break;
	
}