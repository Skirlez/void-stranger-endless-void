event_inherited()
var step = 22

var left_edge = x - (image_xscale * 8) + 8
var top_edge = y - (image_yscale * 8) + 8
var arr = [3, 4, 5, 6, 14, 16, 10, 11, 12, 9, 18, 19]
var i = 0, j = 0;
repeat (array_length(arr)) {
	var inst = instance_create_layer(left_edge + i * step, top_edge + j * step, "WindowElements", asset_get_index("obj_ev_wall_choose"), {
		ind : arr[i + j * 6],
	}) 
	add_child(inst)
	i++;
	if i >= 6 {
		i = 0
		j++;
	}
}

