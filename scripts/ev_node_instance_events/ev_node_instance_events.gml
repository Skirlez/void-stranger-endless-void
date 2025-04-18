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
	
	
}


function with_all_nodes(func, args) {
	with (global.node_object)
		func(id, args);
	with (global.display_object)
		func(id, args);
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
			if ev_mouse_pressed()
				mouse_moving = true;
			if ev_mouse_right_pressed() {
				if max_exits == 0 {
					shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false);	
				}
				else
					connecting_exit = true;
			}
		}
		else if global.pack_editor_instance.selected_thing == pack_things.hammer {
			if ev_mouse_pressed() {
				static judgment_object = asset_get_index("obj_ev_pack_node_judgment");
				
				instance_destroy(judgment_object)
				
				if !(global.pack_editor_instance.judging_node == id) {
					static hammer_sound = asset_get_index("snd_ev_hammer_judge")
					audio_play_sound(hammer_sound, 10, false, 1, 0, random_range(0.9, 1.1))
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
						audio_play_sound(not_possible_sound, 10, false);
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
				audio_play_sound(wrench_sound, 10, false, 1, 0, random_range(0.9, 1.1))
			}
		}
		else if global.pack_editor_instance.selected_thing == pack_things.play {
			if ev_mouse_pressed() {
				global.mouse_layer = 1;
				global.pack_editor_instance.start_play_transition(id)
			}
		}
	}
	
	if being_judged && global.pack_editor_instance.selected_thing != pack_things.hammer
		being_judged = false;
	
	if ev_mouse_released()
		mouse_moving = false;
	if connecting_exit {
		if ev_mouse_held() || global.pack_editor_instance.selected_thing != pack_things.nothing
			connecting_exit = false;	
		else if ev_mouse_right_released() {
			connecting_exit = false
			var node_inst = get_node_at_position(mouse_x, mouse_y)
			if instance_exists(node_inst) {
				if (!node_inst.can_connect_to_me) {
					node_inst.shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false);
				}
				else if (array_length(exit_instances) >= max_exits) {
					shake_seconds = 0.5;
					audio_play_sound(not_possible_sound, 10, false);
				}
				else if (!ev_array_contains(exit_instances, node_inst)) {
					// connection successful
					array_push(exit_instances, node_inst)
					var connect_sound = asset_get_index("snd_ev_node_connect")
					audio_play_sound(connect_sound, 10, false, 1, 0, random_range(0.9, 1.1))
					
					// automatically give brane count to connected level nodes
					if node_inst.object_index == global.display_object && array_length(exit_instances) == 1 {
						if object_index == root_node_obj {
							node_inst.lvl.bount = 1;
							node_inst.delete_cached_surface();
						}
						else if object_index == global.display_object {
							if lvl.bount != -1 {
								node_inst.lvl.bount = lvl.bount + 1;
								node_inst.delete_cached_surface();	
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
		x = mouse_x - center_x_offset
		y = mouse_y - center_y_offset
			
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
	
	if (shake_seconds > 0) {
		shake_seconds -= 1/60;
		shake_x_offset = sin(16 * shake_seconds * pi) * 3;
	}
}
