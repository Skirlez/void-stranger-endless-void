event_inherited();



/*
Removes all connections to a node and returns the list of node instances from which it disconnected.
*/
function remove_connections_to_node(target) {
	var list = []
	
	function disconnect_from_node_instance(target) {
		for (var i = 0; i < array_length(exit_instances); i++) {
			if (exit_instances[i] == target) {
				create_falling_arrow_and_number(id, target, i, array_length(exit_instances));
				array_delete(exit_instances, i, 1)
				return true;
			}
		}
		return false;
	}
	
	with (global.node_object) {
		if disconnect_from_node_instance(target)
			array_push(list, id)
	}

	return list;
}

switch (judgment_type) {
	case judgment_types.destroy_node:
		var nodes_connected_to_me = remove_connections_to_node(node_inst)
		for (var i = 0; i < array_length(nodes_connected_to_me); i++)
			nodes_connected_to_me[i] = nodes_connected_to_me[i].node_id
	
		var exit_node_ids = array_create(array_length(node_inst.exit_instances))
		for (var i = 0; i < array_length(exit_node_ids); i++)
			exit_node_ids[i] = node_inst.exit_instances[i].node_id
		
		
		global.pack_editor_instance.add_undo_action(function (args) {
			var state = new node_with_state(args.node_type,
				args.pos_x,
				args.pos_y,
				args.node_properties
			)
			var instance = state.create_instance(args.node_id);
			instance.exit_instances = array_create(array_length(args.previous_exit_ids))
			for (var i = 0; i < array_length(args.previous_exit_ids); i++) {
				instance.exit_instances[i] = ds_map_find_value(
					global.pack_editor_instance.node_id_to_instance_map, 
					args.previous_exit_ids[i])
			}
			for (var i = 0; i < array_length(args.previously_connected_ids); i++) {
				var instance_previously_connected_to_me = ds_map_find_value(
					global.pack_editor_instance.node_id_to_instance_map,
					args.previously_connected_ids[i])
				array_push(instance_previously_connected_to_me.exit_instances, instance)
			}
		}, {
			pos_x : node_inst.x,
			pos_y : node_inst.y,
			node_id : node_inst.node_id,
			node_type : node_inst.node_type,
			node_properties : node_inst.properties,
			previously_connected_ids : nodes_connected_to_me,
			previous_exit_ids : exit_node_ids
		})
		
		
		
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			create_falling_arrow_and_number(node_inst, 
				node_inst.exit_instances[i], 
				i,
				array_length(node_inst.exit_instances));
		}
		node_inst.node_type.on_death(node_inst);
		instance_destroy(node_inst)
		break;
	case judgment_types.close_connection:
		for (var i = 0; i < array_length(node_inst.exit_instances); i++) {
			if node_inst.exit_instances[i] == connection_to_destroy {
				create_falling_arrow_and_number(node_inst, node_inst.exit_instances[i], 
					i, array_length(node_inst.exit_instances));
					
				global.pack_editor_instance.add_undo_action(function (args) {
					var instance = ds_map_find_value(global.pack_editor_instance.node_id_to_instance_map, args.node_id)
					var exit_instance = ds_map_find_value(global.pack_editor_instance.node_id_to_instance_map, args.exit_id)
					array_push(instance.exit_instances, exit_instance)
				}, {
					node_id : node_inst.node_id,
					exit_id : connection_to_destroy.node_id,
				})
					
					
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