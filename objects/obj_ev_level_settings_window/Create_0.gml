event_inherited()


function commit() {
	with (asset_get_index("obj_ev_level_settings_window")) {
		global.level.name = name_textbox.txt
		global.level.description = description_textbox.txt
		global.level.music = global.music_names[music_select.index]
		for (var i = 0; i < 5; i++) {
			global.level.burdens[i] = burdens[i].image_index
		}
	}
}

save_button = instance_create_layer(112 - 70, 72 - 34, "WindowElements", asset_get_index("obj_ev_save_button"), 
{
	txt : "Save",
	pre_save_func : commit,
	base_scale_y : 0.7
})

quit_button = instance_create_layer(112 - 25, 72 - 34, "WindowElements", asset_get_index("obj_ev_main_menu_button"), 
{
	txt : "Quit",
	base_scale_x : 1.2,
	base_scale_y : 0.7,
	room_name : "rm_ev_level_select"
})
add_child(quit_button)

save_and_quit_button = instance_create_layer(112 + 45, 72 - 34, "WindowElements", asset_get_index("obj_ev_save_button"), 
{
	txt : "Save & Quit",
	pre_save_func : commit,
	post_save_func : function() {
		room_goto(asset_get_index("rm_ev_level_select"))	
	},
	base_scale_x : 2.5,
	base_scale_y : 0.7
})


name_textbox = instance_create_layer(112, 72 - 10, "WindowElements", asset_get_index("obj_ev_textbox"), 
{
	txt : global.level.name,
	empty_text : "Level Name",
	base_scale_x : 5,
	allow_newlines : false,
	automatic_newline: false,
	char_limit : 30,
	//exceptions: "~`!@#$%^&()_=-+{} [],.;'"
})
	
description_textbox = instance_create_layer(112, 72 + 10, "WindowElements", asset_get_index("obj_ev_textbox"), 
{
	txt : global.level.description,
	empty_text : "Level Description",
	char_limit : 256,
	base_scale_x : 7,
	allow_newlines : false
})

description_textbox.depth--;
	
add_child(save_button)
add_child(save_and_quit_button)
add_child(name_textbox)
add_child(description_textbox)
	
burdens = array_create(5)
for (var i = 0; i < 5; i++) {
	burdens[i] = instance_create_layer(112 - 72 + i * 16, 72 + 30, "WindowElements", asset_get_index("obj_ev_burden_toggle"), 
	{
		burden_ind : i,
		image_index : global.level.burdens[i]
	})
	
	add_child(burdens[i])
}

var man = instance_create_layer(112 + 63, 72 + 27, "WindowElements", asset_get_index("obj_ev_man"))
add_child(man)

music_select = instance_create_layer(112 + 72 - 4, 72 + 45, "WindowElements", asset_get_index("obj_ev_music_select"), {
	base_scale_x : 1	
})



add_child(music_select)

