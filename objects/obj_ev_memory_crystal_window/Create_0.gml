event_inherited()


text_element = instance_create_layer(112, 72 - 18, "WindowElements", agi("obj_ev_text_element"), {
	txt : "Offset"
});
add_child(text_element)

dpad = instance_create_layer(112, 72, "WindowElements", agi("obj_ev_dpad"), {
	offset_x : memory_crystal_properties.ofx,
	offset_y : memory_crystal_properties.ofy
});

add_child(dpad);