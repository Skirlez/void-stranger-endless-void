event_inherited();

textbox_instance = instance_create_layer(x, y, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Branefuck Program",
	txt : node_instance.program,
	allow_alphanumeric : false,
	exceptions : global.branefuck_characterset,
	char_limit : 260,
	base_scale_x : 8,
});

add_child(textbox_instance);