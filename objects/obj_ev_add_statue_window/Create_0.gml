event_inherited();
input_1_text = instance_create_layer(112 - 32, 72 - 40, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Input 1",
	base_scale_x : 3.5,
})
add_child(input_1_text)
input_2_text = instance_create_layer(112 + 32, 72 - 40, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Input 2",
	base_scale_x : 3.5,
})
add_child(input_2_text)
program_text = instance_create_layer(112, 72 - 20, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Brainfuck Program",
	base_scale_x : 8,
})
add_child(program_text)


destroy_value_text = instance_create_layer(112, 72 + 40, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Destroy Value",
	base_scale_x : 6,
})
add_child(destroy_value_text)


elements_depth = layer_get_depth("WindowElements")