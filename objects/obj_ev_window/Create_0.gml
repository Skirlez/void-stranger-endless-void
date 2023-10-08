children = []

function add_child(obj) {
	array_push(children, obj)	
}

var inst = instance_create_layer(x + image_xscale * 8 - 8, y - image_yscale * 8 + 8, "WindowElements", asset_get_index("obj_ev_close_window"))
inst.window = id
add_child(inst)