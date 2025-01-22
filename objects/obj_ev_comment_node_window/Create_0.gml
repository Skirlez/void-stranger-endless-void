event_inherited();

textbox_instance = instance_create_layer(x, y, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Comment",
	txt : node_instance.comment,
	allow_alphanumeric : true,
	char_limit : 100,
	base_scale_x : 8,
});

add_child(textbox_instance);