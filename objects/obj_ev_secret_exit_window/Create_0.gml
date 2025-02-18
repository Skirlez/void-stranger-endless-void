event_inherited()

selector = instance_create_layer(112, 72 - 30, "WindowElements", asset_get_index("obj_ev_selector"), {
	elements : ["Hidden", "Stars", "Stinklines"],
	selected_element : secret_exit_properties.typ,
	max_radius : 30
});
add_child(selector)


offset_hori = instance_create_layer(112 - 40, 72 + 50, "WindowElements", asset_get_index("obj_ev_textbox"), {
	txt : string(secret_exit_properties.ofx),
	allow_alphanumeric : false,
	exceptions : "-0123456789",
	char_limit : 3,
	base_scale_x : 1.4,
	base_scale_y : 1,
	allow_newlines : false,
});
add_child(offset_hori)

offset_verti = instance_create_layer(112 + 40, 72 + 50, "WindowElements", asset_get_index("obj_ev_textbox"), {
	txt : string(secret_exit_properties.ofy),
	allow_alphanumeric : false,
	exceptions : "-0123456789",
	char_limit : 3,
	base_scale_x : 1.4,
	base_scale_y : 1,
	allow_newlines : false,
});
add_child(offset_verti)

