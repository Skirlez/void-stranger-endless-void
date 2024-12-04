event_inherited()
base_scale_x_start = base_scale_x
base_scale_y_start = base_scale_y
window_sprite = asset_get_index("spr_ev_window")

window_size = 0;

window_xscale = 6;
window_yscale = 2;

node_instances = []

function update_node_instances_positions() {
	var center_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2
	var center_y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2
	
	var padding = 10;
	
	var top = center_y - (16 * window_yscale * window_size) / 2 + padding * window_size
	var left = center_x - (16 * window_xscale * window_size) / 2 + padding * window_size

	var pos_x = left;
	var pos_y = top;
	for (var i = 0; i < array_length(node_instances); i++) {
		node_instances[i].x = pos_x;
		node_instances[i].y = pos_y;
		pos_x += 16 * window_size;
		
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


pack_editor_inst().select_tool_event.subscribe(function (struct) {
	selected = (struct.new_selected_thing == pack_things.selector)
	
	if (array_length(node_instances) != 0) {
		for (var i = 0; i < array_length(node_instances); i++)
			instance_destroy(node_instances[i])
		node_instances = []
	}
})