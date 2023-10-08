event_inherited()
var margin_y = 10;
var margin_x = 16;
var step = (image_xscale * 16 - 2 * margin_x) / 6

var left_edge = x - (image_xscale * 8) + margin_x
var top_edge = y - (image_yscale * 8) + margin_y
for (var i = 0; i < 6; i++) {
	var inst = instance_create_layer(left_edge + i * step, top_edge, "WindowElements", asset_get_index("obj_ev_placeable_drag"), {
		num : i,
		layer_num : 1
	}) 
	add_child(inst)
}

var list = global.editor_object.current_list
var i = 0, j = 0;
repeat (array_length(list)) {
	
	var inst = instance_create_layer(left_edge + i * step, top_edge + 40 + j * step, "WindowElements", asset_get_index("obj_ev_placeable_selection"), {
		num : i + j * 6,
		direct: true,
		layer_num : 1
	}) 
	add_child(inst)
	i++;
	if i >= 6 {
		i = 0
		j++;
	}
}

