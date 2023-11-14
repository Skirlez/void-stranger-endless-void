event_inherited()

for (var i = 0; i < 4; i++) {
	egg_textbox[i] = instance_create_layer(112, 72 - 2 * 16 + i * 16, "WindowElements", asset_get_index("obj_ev_textbox"), 
		{txt : egg_properties.txt[i],
		char_limit : 30 })
	add_child(egg_textbox[i])
}
	
	
elements_depth = layer_get_depth("WindowElements")