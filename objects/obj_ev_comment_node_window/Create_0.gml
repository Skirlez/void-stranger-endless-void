event_inherited();

textbox_instance = instance_create_layer(x, y, "WindowElements", agi("obj_ev_textbox"), {
	empty_text : "Comment",
	txt : node_instance.properties.comment,
	allow_alphanumeric : true,
	char_limit : 999,
	max_line_width : 99999,
	base_scale_x : 8,
});

add_child(textbox_instance);