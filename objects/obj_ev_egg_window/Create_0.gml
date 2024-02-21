event_inherited()

for (var i = 0; i < 4; i++) {
	egg_textbox[i] = instance_create_layer(70, 72 - 30 + i * 18, "WindowElements", asset_get_index("obj_ev_textbox"), 
	{
		txt : egg_properties.txt[i],
		char_limit : 200,
		opened_x : room_width / 2,
		opened_y : room_height / 2,
	})
	add_child(egg_textbox[i])
}
	
	
elements_depth = layer_get_depth("WindowElements")