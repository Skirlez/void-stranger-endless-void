function ev_draw_pack_line(x1, y1, x2, y2, number = 0) {
	draw_set_color(c_black)
	draw_line_width(x1, y1,	x2, y2, 2)
	static arrow_sprite = asset_get_index("spr_ev_pack_arrow")
	
	var t = get_pack_line_arrow_progress();
	var pos_x = lerp(x1, x2, t)
	var pos_y = lerp(y1, y2, t)


	// makes the spin happen twice
	var t2 = t % 0.5;
	
	var angle_target = point_direction(x1, y1, x2, y2);
	var angle_start = point_direction(x1, y1, x2, y2) + 360;

	// (1-1/exp(x)) goes from 0 to 1 in a nice curve
	var angle = lerp(angle_start, angle_target, 1 - (1 / exp(t2 * 12)))


	// roots of sin x give us a sort of "rectangular" curve from 0-pi, which is what we want -
	// very quickly going to a near 1 value at the start and very quickly dropping off at the end
	// t is between 0-1 so we multiply by pi
	var scale = power(sin(t * pi), 1/3)
	
	draw_sprite_ext(arrow_sprite, 0, pos_x + 0.5, pos_y + 0.5, scale, scale, angle, c_white, 1)
	if number > 0 {
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_font(global.ev_font)
		draw_set_color(c_white)
		var number_t = get_pack_line_number_progress()
		var number_pos_x = lerp(x1, x2, number_t)
		var number_pos_y = lerp(y1, y2, number_t)
		draw_text_shadow(number_pos_x, number_pos_y, string(number), c_black);
	}
	/*
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_color(c_white)
	draw_text_ext_transformed(
		pos_x + 9 * dcos(angle_target + 90), 
		pos_y - 9 * dsin(angle_target + 90) - 4, "1", 0, 300, scale * 0.5, scale * 0.5, 0)
	*/
}

function get_pack_line_arrow_progress() {
	return (global.editor_time % 200) / 200;	
}
function get_pack_line_number_progress() {
	var t = get_pack_line_arrow_progress() - 0.15;
	if t < 0
		t += 1;
	return t;
}

function get_all_level_node_instances() {
	static pack_levels_layer = layer_get_id("PackLevels")
	var display_instance_elements = layer_get_all_elements(pack_levels_layer)		
	var nodes = []
	for (var i = 0; i < array_length(display_instance_elements); i++) {
		var inst = layer_instance_get_instance(display_instance_elements[i]);
		if inst.object_index == global.display_object
			array_push(nodes, inst);
	}
	return nodes;
}

function get_all_node_instances() {
	var node_instances = get_all_level_node_instances();
	
	static nodes_layer = layer_get_id("Nodes")
	var node_instance_elements = layer_get_all_elements(nodes_layer)
	for (var i = 0; i < array_length(node_instance_elements); i++) {
		array_push(node_instances, layer_instance_get_instance(node_instance_elements[i]))	
	}
	return node_instances;
	
}
function destroy_all_node_instances() {
	var node_instances = get_all_node_instances();
	for (var i = 0; i < array_length(node_instances); i++) {
		instance_destroy(node_instances[i])
	}
}


// checks if any other nodes has this level's name, and if they do,
// renames the level by adding _number. or if there's already _number at the end,
// increases the number.
function try_level_name_and_rename(lvl, level_nodes) {
	for (var i = 0; i < array_length(level_nodes); i++) {
		var other_lvl = level_nodes[i].lvl;
		if (other_lvl == lvl)
			continue;
		if (other_lvl.name == lvl.name) {
			var arr = ev_string_split(other_lvl.name, "_")
			if array_length(arr) == 0 {
				lvl.name += "_1"
				try_level_name_and_rename(lvl, level_nodes)
				return;
			}
			else {
				var last = array_length(arr) - 1
				if string_is_uint(arr[last]) {
					var num = int64(arr[last])
					lvl.name = ""
					for (var i = 0; i < last; i++) {
						lvl.name += arr[i] + "_"
					}
					lvl.name += string(num + 1)
					try_level_name_and_rename(lvl, level_nodes)
					return;
				}
				else {
					lvl.name += "_1"
					try_level_name_and_rename(lvl, level_nodes)
					return;
				}
			}
		}
	}
}