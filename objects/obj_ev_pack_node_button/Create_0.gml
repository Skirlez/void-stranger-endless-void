event_inherited()
base_scale_x_start = base_scale_x
base_scale_y_start = base_scale_y
window_sprite = asset_get_index("spr_ev_window")

window_size = 0;

window_xscale = 6;
window_yscale = 3;

node_instances = []

function update_node_instances_positions() {
	var center_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2
	var center_y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2
	
	var padding = 15;
	
	var top = center_y - (16 * window_yscale * window_size) / 2 + padding * window_size
	var left = center_x - (16 * window_xscale * window_size) / 2 + padding * window_size

	var pos_x = 0;
	var pos_y = 0;
	for (var i = 0; i < array_length(node_instances); i++) {
		node_instances[i].x = left + pos_x * (16 * window_size);
		node_instances[i].y = top + pos_y * (20 * window_size);
		
		pos_x++;
		if (pos_x > 4) {
			pos_y++;
			pos_x = 0;
		}
		
	}
}
function pick(node_inst) {
	for (var i = 0; i < array_length(node_instances); i++) {
		if (node_instances[i] == node_inst) {
			array_delete(node_instances, i, 1)
			return;
		}
	}
}

update_node_instances_positions()


global.pack_editor_instance.select_tool_happening.subscribe(function (struct) {
	selected = (struct.new_selected_thing == pack_things.selector)
	
	if (array_length(node_instances) != 0) {
		for (var i = 0; i < array_length(node_instances); i++)
			instance_destroy(node_instances[i])
		node_instances = []
	}
	if selected {
		var nodes = global.pack_editor_instance.nodes_list;
		for (var i = 0; i < array_length(nodes); i++) {
			var node_state = new node_with_state(nodes[i], x, y);
			var instance = node_state.create_instance();
			instance.in_menu = true;
			if (nodes[i].flags & node_flags.only_one && instance_number(instance.object_index) != 1) {
				instance.unselectable = true;
			}
			instance.layer = layer_get_id("NodesInMenu");
			array_push(node_instances, instance)
		}
		update_node_instances_positions()	
	}
})