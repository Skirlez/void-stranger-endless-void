function node_instance_setup(max_exits = 999, can_connect_to_me = true, center_x_offset = 0, center_y_offset = 0, animate = false) {
	id.max_exits = max_exits;
	id.can_connect_to_me = can_connect_to_me;
	id.center_x_offset = center_x_offset;
	id.center_y_offset = center_y_offset;

	id.animate = animate;
	image_speed = 0.1
	
	center_x = x + center_x_offset;
	center_y = y + center_y_offset;
	mouse_moving = false;
	connecting_exit = false;
	exit_instances = [];
	unselectable = false;
	being_judged = true;
	in_menu = false;
	node_type = global.object_node_map[? object_index];
	shake_seconds = 0;
	shake_x_offset = 0;
	properties = node_type.properties_generator();
	
	spin_time_h = 0;
	spin_time_v = 0;
	spin_h = 0
	spin_v = 0
	
	scale_x_start = image_xscale
	scale_y_start = image_yscale
	center_x_offset_start = center_x_offset;
	center_y_offset_start = center_y_offset;
	
	
	x_when_started_moving = x;
	y_when_started_moving = y;
	
	if !variable_instance_exists(id, "node_id") {
		global.pack_editor_instance.last_nid++;
		node_id = global.pack_editor_instance.last_nid
	}
	ds_map_add(global.pack_editor_instance.node_id_to_instance_map, node_id, id)	

}

function move_node_to_position(instance, new_x, new_y) {
	with (instance) {
		x = new_x
		y = new_y

		if (y < 0)
			y = 0
		if (y > room_height - sprite_height)
			y = room_height - sprite_height
		if (x < 0)
			x = 0
		if (x > room_width - sprite_width)
			x = room_width - sprite_width
		center_x = x + center_x_offset
		center_y = y + center_y_offset
	}
}


function expand_node_instance(node_instance) {
	var scale_factor = (object_index == global.display_object) ? 1.2 : 1.3
	with (node_instance) {
		image_xscale = scale_x_start * scale_factor;
		image_yscale = scale_y_start * scale_factor;
		x -= (image_xscale - scale_x_start) * ((center_x - x) * 4)
		y -= (image_yscale - scale_y_start) * ((center_y - y) * 4)
		center_x_offset = center_x_offset_start * scale_factor;
		center_y_offset = center_y_offset_start * scale_factor;
		center_x = x + center_x_offset;
		center_y = y + center_y_offset;
	}
}

function contract_node_instance(node_instance) {
	with (node_instance) {
		x += (image_xscale - scale_x_start) * ((center_x - x) * 4)
		y += (image_yscale - scale_y_start) * ((center_y - y) * 4)
		image_xscale = scale_x_start;
		image_yscale = scale_y_start;
		center_x_offset = center_x_offset_start;
		center_y_offset = center_y_offset_start;
		center_x = x + center_x_offset;
		center_y = y + center_y_offset;
	}
}



function get_node_at_position(pos_x, pos_y) {
	var display_inst = instance_position(mouse_x, mouse_y, global.display_object)
	if instance_exists(display_inst) && display_inst != id
		return display_inst
	var node_inst = instance_position(mouse_x, mouse_y, global.node_object)
	if node_inst == id
		return noone;
	return node_inst;
}
function play_pickup_sound(pitch) {
	static sounds = [agi("snd_ev_node_pickup_1"), agi("snd_ev_node_pickup_2"), agi("snd_ev_node_pickup_3")]
	

	audio_play_sound(sounds[irandom_range(0, array_length(sounds) - 1)], 10, false, global.pack_zoom_gain, 0, pitch)
}
function node_instance_step() {
	static root_node_obj = asset_get_index("obj_ev_pack_root")
	static not_possible_sound = asset_get_index("snd_lorddamage")
	
	if (ev_is_mouse_on_me()) {
		if unselectable
			return;
		if in_menu && global.pack_editor_instance.selected_thing == pack_things.selector {
			// TODO
			if ev_mouse_pressed() {
				static node_button = asset_get_index("obj_ev_pack_node_button")
				node_button.pick(id);
				global.pack_editor_instance.select(pack_things.nothing)
				in_menu = false;
				layer = layer_get_id("Nodes");
			}
		}
		if global.pack_editor_instance.selected_thing == pack_things.nothing {
			if ev_mouse_pressed() {
				x_when_started_moving = x;
				y_when_started_moving = y;
				mouse_moving = true;
				play_pickup_sound(random_range(1, 1.05))
				expand_node_instance(id)
			}
			if ev_mouse_right_pressed() {
				if max_exits == 0 {
					shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false, global.pack_zoom_gain);	
				}
				else {
					static start_connect_sound = agi("snd_ev_node_start_connect")
					audio_play_sound(start_connect_sound, 10, false, global.pack_zoom_gain, 0, random_range(0.9, 1.1));	
					connecting_exit = true;
				}
			}
		}
		else if global.pack_editor_instance.selected_thing == pack_things.hammer {
			if ev_mouse_pressed() {
				static judgment_object = asset_get_index("obj_ev_pack_node_judgment");
				
				instance_destroy(judgment_object)
				
				if !(global.pack_editor_instance.judging_node == id) {
					static hammer_sound = asset_get_index("snd_ev_hammer_judge")
					audio_play_sound(hammer_sound, 10, false, global.pack_zoom_gain, 0, random_range(0.9, 1.1))
					if !(node_type.flags & node_flags.unremovable) {
						instance_create_layer(center_x, center_y, "NodeJudgments", judgment_object, {
							node_inst : id,
							judgment_type : judgment_types.destroy_node,
							target_y : center_y - sprite_height / 2 - 10,
						})
					}
					for (var i = 0; i < array_length(exit_instances); i++) {
						var exit_instance = exit_instances[i];
						instance_create_layer(center_x, center_y, "NodeJudgments", judgment_object, {
								node_inst : id,
								judgment_type : judgment_types.close_connection,
								connection_to_destroy : exit_instances[i],
								silent : true,
								target_x : lerp(center_x, exit_instance.center_x, 0.5),
								target_y : lerp(center_y, exit_instance.center_y, 0.5)
							}
						)
					}
					if (instance_exists(judgment_object)) // root node might not have anything to judge for example
						global.pack_editor_instance.judging_node = id;
					else {
						shake_seconds = 0.5;
						audio_play_sound(not_possible_sound, 10, false, global.pack_zoom_gain);
					}
				}
				else
					global.pack_editor_instance.judging_node = noone;
			}
		}
		else if global.pack_editor_instance.selected_thing == pack_things.wrench {
			if ev_mouse_pressed() {
				static wrench_sound = asset_get_index("snd_ev_use_wrench");
				node_type.on_config(id);	
				audio_play_sound(wrench_sound, 10, false, global.pack_zoom_gain, 0, random_range(0.9, 1.1))
			}
		}
		else if global.pack_editor_instance.selected_thing == pack_things.play {
			if ev_mouse_pressed() {
				if object_index != global.display_object {
					shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false, global.pack_zoom_gain);	
				}
				else {
					global.pack_editor_instance.start_play_transition(id)
					global.mouse_layer = 1;	
				}
			}
		}
	}
	
	if being_judged && global.pack_editor_instance.selected_thing != pack_things.hammer
		being_judged = false;
	
	if ev_mouse_released() && mouse_moving {
		mouse_moving = false;
		play_pickup_sound(0.8)
		contract_node_instance(id)
		global.pack_editor_instance.add_undo_action(function (args) {
			var instance = ds_map_find_value(global.pack_editor_instance.node_id_to_instance_map, args.node_id)
			move_node_to_position(instance, args.old_x, args.old_y)
		}, {
			node_id : node_id,
			old_x : x_when_started_moving,
			old_y : y_when_started_moving
		})
	}
	if connecting_exit {
		if ev_mouse_held() || global.pack_editor_instance.selected_thing != pack_things.nothing
			connecting_exit = false;	
		else if ev_mouse_right_released() {
			connecting_exit = false
			var node_inst = get_node_at_position(mouse_x, mouse_y)
			if instance_exists(node_inst) {
				if (!node_inst.can_connect_to_me) {
					node_inst.shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false, global.pack_zoom_gain);
				}
				else if (array_length(exit_instances) >= max_exits) {
					shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false, global.pack_zoom_gain);
				}
				else if (!ev_array_contains(exit_instances, node_inst)) {
					// connection successful
					array_push(exit_instances, node_inst)
					var connect_sound = asset_get_index("snd_ev_node_connect")
					audio_play_sound(connect_sound, 10, false, global.pack_zoom_gain, 0, random_range(0.9, 1.1))
					
					// automatically give brane count to connected level nodes
					if node_inst.object_index == global.display_object && array_length(exit_instances) == 1 {
						if object_index == root_node_obj {
							node_inst.lvl.bount = 1;
							node_inst.delete_cached_game_surface();
						}
						else if object_index == global.display_object {
							if lvl.bount != -1 {
								node_inst.lvl.bount = lvl.bount + 1;
								node_inst.delete_cached_game_surface();	
							}
							else
								node_inst.lvl.bount = -1;
						}
					}
					
				}
			}
		}
	}
	if (mouse_moving) {
		move_node_to_position(id, mouse_x - center_x_offset, mouse_y - center_y_offset)
	}
	
	if (shake_seconds > 0) {
		shake_seconds -= 1/60;
		shake_x_offset = sin(16 * shake_seconds * pi) * 3;
	}
}

function node_instance_destroy() {
	ds_map_delete(global.pack_editor_instance.node_id_to_instance_map, node_id)	
}

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
