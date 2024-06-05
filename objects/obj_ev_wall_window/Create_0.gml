event_inherited()
var step = 22

var left_edge = x - (image_xscale * 8) + 8
var top_edge = y - (image_yscale * 8) + 8
var arr = [3, 5, 4, 6, 13, 14, 
		  9, 11, 10, 8, 16, 17]
		  
var i = 0, j = 0;
repeat (array_length(arr)) {
	var inst = instance_create_layer(left_edge + i * step, top_edge + j * step, "WindowElements", asset_get_index("obj_ev_wall_choose"), {
		ind : arr[i + j * 6],
		type : type
	}) 
	add_child(inst)
	i++;
	if i >= 6 {
		i = 0
		j++;
	}
}

