event_inherited()
egg_textbox = instance_create_layer(112, 72, "WindowElements", asset_get_index("obj_ev_textbox"), 
	{txt : egg_properties.txt,
	char_limit : 30 })
add_child(egg_textbox)