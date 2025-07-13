event_inherited();
tog = instance_create_layer(x + 30, y, "WindowElements", agi("obj_ev_toggle"), {
	image_index : node_instance.properties.fall,
})
add_child(tog)

explanation = instance_create_layer(x - 30, y, "WindowElements", agi("obj_ev_textbox"), {
	allow_deletion : false,
	char_limit : 0,
	txt : "Start pack falling down",
})
explanation.depth = layer_get_depth("WindowElements") - 1; // above toggle
add_child(explanation)
