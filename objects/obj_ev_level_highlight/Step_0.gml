event_inherited()

for (var i = 0; i < array_length(children); i++) {
	var child = children[i]
	if child.object_index != asset_get_index("obj_ev_textbox")
		continue;
	if child == selected_element
		child.depth = textbox_open_depth - 1
	else if child.image_xscale != child.base_scale_x || child.image_yscale != child.base_scale_y
		child.depth = textbox_open_depth
	else
		child.depth = textbox_depth
}