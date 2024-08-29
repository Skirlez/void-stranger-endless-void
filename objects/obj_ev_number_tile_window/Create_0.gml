event_inherited()
textbox = instance_create_layer(112, 72, "WindowElements", asset_get_index("obj_ev_textbox"), {
	txt : string(tile_properties.num),
	allow_alphanumeric : false,
	exceptions : "0123456789",
	char_limit : 2,
	base_scale_x : 1.4,
	base_scale_y : 1,
});
add_child(textbox)