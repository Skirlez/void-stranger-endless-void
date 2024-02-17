event_inherited()


function commit() {
	with (asset_get_index("obj_ev_settings_window")) {
		global.level.name = name_textbox.txt
		global.level.description = description_textbox.txt

		for (var i = 0; i < 4; i++) {
			global.level.burdens[i] = burdens[i].image_index
		}
	}
}

save_button = instance_create_layer(112 - 45, 72 - 46, "WindowElements", asset_get_index("obj_ev_save_button"), 
{txt : "Save",
pre_save_func : commit,
base_scale_y : 0.7})

save_and_quit_button = instance_create_layer(112 + 30, 72 - 46, "WindowElements", asset_get_index("obj_ev_save_button"), 
{txt : "Save and Quit",
pre_save_func : commit,
post_save_func : function() {
	room_goto(asset_get_index("rm_ev_level_select"))	
},

base_scale_x : 2.8,
base_scale_y : 0.7})


name_textbox = instance_create_layer(112, 72 - 22, "WindowElements", asset_get_index("obj_ev_textbox"), 
{txt : global.level.name,
empty_text : "Level Name",
base_scale_x : 5,
allow_newlines : false,
automatic_newline: false,
exceptions: "~`!@#$%^&()_=-+{} [],.;'"})
	
description_textbox = instance_create_layer(112, 72 - 2, "WindowElements", asset_get_index("obj_ev_textbox"), 
{txt : global.level.description,
empty_text : "Level Description",
char_limit : 128,
base_scale_x : 7,
allow_newlines : false})

description_textbox.depth--;
	
add_child(save_button)
add_child(save_and_quit_button)
add_child(name_textbox)
add_child(description_textbox)
	
burdens = array_create(4)
for (var i = 0; i < 4; i++) {
	burdens[i] = instance_create_layer(112 - 72 + i * 16, 72 + 30, "WindowElements", asset_get_index("obj_ev_burden_toggle"), 
	{burden_ind : i,
	image_index : global.level.burdens[i]})
	
	add_child(burdens[i])
}

var man = instance_create_layer(112 + 63, 72 + 27, "WindowElements", asset_get_index("obj_ev_man"))
add_child(man)

var music_select = instance_create_layer(112 + 72 - 4, 72 + 45, "WindowElements", asset_get_index("obj_ev_music_select"))
music_select.base_scale_x = 1

add_child(music_select)

