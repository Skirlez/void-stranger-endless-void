event_inherited()

selector = instance_create_layer(112, 72 - 20, "WindowElements", agi("obj_ev_selector"), {
	elements : ["Hidden", "Stars", "Stinklines"],
	selected_element : secret_exit_properties.typ,
	max_radius : 30
});
add_child(selector)

text_element = instance_create_layer(112, 72 + 2, "WindowElements", agi("obj_ev_text_element"), {
	txt : "Offset"
});
add_child(text_element)

dpad = instance_create_layer(112, 72 + 20, "WindowElements", agi("obj_ev_dpad"), {
	offset_x : secret_exit_properties.ofx,
	offset_y : secret_exit_properties.ofy
});

add_child(dpad);