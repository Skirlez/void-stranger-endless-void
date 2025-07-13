event_inherited();

selector = instance_create_layer(x, y, "WindowElements", agi("obj_ev_selector"), {
	elements : global.palette_node_palettes,
	selected_element : node_instance.properties.palette_number,
	max_radius : 60
})

add_child(selector);