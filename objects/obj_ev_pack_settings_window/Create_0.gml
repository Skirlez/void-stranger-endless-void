event_inherited()




function on_press_save_button() {
	with (asset_get_index("obj_ev_pack_settings_window")) {
		global.pack.name = name_textbox.txt
		global.pack.description = description_textbox.txt
	}
	if (global.pack.name == "") {
		ev_notify("Cannot save a pack\nwithout a name.")
		exit;
	}
	var starting_nodes = convert_room_nodes_to_structs()
	global.pack.starting_node_states = starting_nodes;
	save_pack(global.pack)
	ev_notify("Pack saved!")
}


save_button = instance_create_layer(112 - 70, 72 - 34, "WindowElements", asset_get_index("obj_ev_executing_button"), 
{
	func : on_press_save_button,
	txt : "Save",
	base_scale_y : 0.7
})

quit_button = instance_create_layer(112 - 25, 72 - 34, "WindowElements", asset_get_index("obj_ev_main_menu_button"), 
{
	txt : "Quit",
	base_scale_x : 1.2,
	base_scale_y : 0.7,
	room_name : "rm_ev_pack_select"
})
add_child(quit_button)

save_and_quit_button = instance_create_layer(112 + 45, 72 - 34, "WindowElements", asset_get_index("obj_ev_executing_button"), 
{
	txt : "Save & Quit",
	func : function() {
		with (window)
			on_press_save_button();
		room_goto(asset_get_index("rm_ev_pack_select"))
	},
	base_scale_x : 2.5,
	base_scale_y : 0.7
})


name_textbox = instance_create_layer(112, 72 - 10, "WindowElements", asset_get_index("obj_ev_textbox"), 
{
	txt : global.pack.name,
	empty_text : "Pack Name",
	base_scale_x : 5,
	allow_newlines : false,
	automatic_newline: false,
	char_limit : 30,
	//exceptions: "~`!@#$%^&()_=-+{} [],.;'"
})
	
description_textbox = instance_create_layer(112, 72 + 10, "WindowElements", asset_get_index("obj_ev_textbox"), 
{
	txt : global.pack.description,
	empty_text : "Pack Description",
	char_limit : 256,
	base_scale_x : 7,
	allow_newlines : false
})

description_textbox.depth--;
	
add_child(save_button)
add_child(save_and_quit_button)
add_child(name_textbox)
add_child(description_textbox)
