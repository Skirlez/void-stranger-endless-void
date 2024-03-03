event_inherited()


for (var i = 0; i < array_length(children); i++) {
	var child = children[i]
	if child.object_index != asset_get_index("obj_ev_textbox")
		continue;
	if child == selected_element
		child.depth = elements_depth - 2
	else if child.image_xscale != child.base_scale_x || child.image_yscale != child.base_scale_y
		child.depth = elements_depth - 1
	else
		child.depth = elements_depth
}
