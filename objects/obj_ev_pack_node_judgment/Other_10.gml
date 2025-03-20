event_inherited();

function create_falling_arrow_and_number(node_instance, other_node_instance, index, total_exits) {
	var t = get_pack_line_arrow_progress();
	instance_create_layer(
		lerp(node_instance.center_x, other_node_instance.center_x, t),
		lerp(node_instance.center_y, other_node_instance.center_y, t),
		"ConnectingLines",
		asset_get_index("obj_ev_falling_pack_arrow"))
	var more_than_one_exit = (total_exits > 1)
	var number = (index + 1) * more_than_one_exit
	if number == 0
		exit;
	var t2 = get_pack_line_number_progress();
	instance_create_layer(
		lerp(node_instance.center_x, other_node_instance.center_x, t2),
		lerp(node_instance.center_y, other_node_instance.center_y, t2),
		"ConnectingLines",
		asset_get_index("obj_ev_falling_pack_number"), {
			number : number	
		})
}

function remove_connections_to_node(target_node_inst) {
	with_all_nodes(function(node_inst, target_node_inst) {
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			if (node_inst.exit_instances[i] == target_node_inst) {
				create_falling_arrow_and_number(node_inst, target_node_inst, i, array_length(node_inst.exit_instances));
				array_delete(node_inst.exit_instances, i, 1)
				return;
			}
		}
	}, target_node_inst)	
}

switch (judgment_type) {
	case judgment_types.destroy_node:
		remove_connections_to_node(node_inst)
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			create_falling_arrow_and_number(node_inst, 
				node_inst.exit_instances[i], 
				i,
				array_length(node_inst.exit_instances));
		}
		if (node_inst.object_index == global.display_object)
			node_inst.destroy();
		else
			instance_destroy(node_inst)
		break;
	case judgment_types.close_connection:
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			if node_inst.exit_instances[i] == connection_to_destroy {
				create_falling_arrow_and_number(node_inst, node_inst.exit_instances[i], 
					i, array_length(node_inst.exit_instances));
				array_delete(node_inst.exit_instances, i, 1)
				break;
			}
		}
		audio_play_sound(asset_get_index("snd_ev_node_disconnect"), 10, false, 1, 0, random_range(0.9, 1.1))
		if instance_number(object_index) == 1 // i'm the last one left
			global.pack_editor_instance.judging_node = noone;
		instance_destroy(id)

		break;
	
}