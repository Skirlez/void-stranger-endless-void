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

function create_node_shards(node_inst) {
	var manager;
	var size;
	var sprite;
	if node_inst.node_type == global.pack_editor_instance.brand_node {
		sprite = node_inst.brand_sprite
		manager = instance_create_depth(0, 0, 0, agi("obj_ev_node_shard_manager"), {
			sprite : sprite
		})
		node_inst.brand_sprite = noone; // make sure the node doesn't delete the sprite	
		// the sprite is only 6x6, we need it to be 10x10
		size = 10/6;
	}
	else {
		sprite = node_inst.sprite_index
		manager = noone;
		// node sprites are 16x16, we need them to be 10x10
		size = 10/16;	
	}
	repeat (6) {
		instance_create_depth(node_inst.center_x, node_inst.center_y, node_inst.depth, agi("obj_ev_node_shard"), {
			sprite_index : sprite,
			image_speed : 0,
			image_xscale : size,
			image_yscale : size,
			manager : manager
		})	
	}	
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
		else {
			create_node_shards(node_inst)
			audio_play_sound(agi("snd_ev_node_destroy"), 10, false, global.pack_zoom_gain, 0, random_range(0.9, 1.1))
			instance_destroy(node_inst)
		}
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