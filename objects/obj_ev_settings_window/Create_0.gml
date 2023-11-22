event_inherited()
name_textbox = instance_create_layer(112, 72 - 46, "WindowElements", asset_get_index("obj_ev_textbox"), 
	{txt : global.level.name,
	empty_text : "Level Name",
	char_limit : 32,
	base_scale_x : 5,
	allow_newlines : false})
	
description_textbox = instance_create_layer(112, 72 - 26, "WindowElements", asset_get_index("obj_ev_textbox"), 
	{txt : global.level.description,
	empty_text : "Level Description",
	char_limit : 256,
	base_scale_x : 7,
	allow_newlines : false})
	
burdens = array_create(4)
for (var i = 0; i < 4; i++) {
	burdens[i] = instance_create_layer(112 - 72 + i * 16, 72 + 30, "WindowElements", asset_get_index("obj_ev_burden_toggle"), 
	{burden_ind : i,
	image_index : global.level.burdens[i]})
	
	add_child(burdens[i])
}

var man = instance_create_layer(112 + 72, 72 + 30, "WindowElements", asset_get_index("obj_ev_man"))
add_child(man)

add_child(name_textbox)
add_child(description_textbox)