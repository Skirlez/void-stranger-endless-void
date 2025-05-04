event_inherited()

elements_depth = layer_get_depth("WindowElements")
function commit() {
	with (asset_get_index("obj_ev_level_settings_window")) {
		global.level.name = name_textbox.txt
		global.level.description = description_textbox.txt
		global.level.music = global.music_names[music_select.index]
		for (var i = 0; i < 5; i++) {
			global.level.burdens[i] = burdens[i].image_index
		}
		global.level.theme = theme_selector.get_selected_index();
	}
}

save_button = instance_create_layer(112 - 65, 72 - 34, "WindowElements", asset_get_index("obj_ev_save_button"), 
{
	txt : "Save",
	pre_save_func : commit,
	base_scale_y : 0.7
})

quit_button = instance_create_layer(112 - 20, 72 - 34, "WindowElements", asset_get_index("obj_ev_main_menu_button"), 
{
	txt : "Quit",
	base_scale_x : 1.2,
	base_scale_y : 0.7,
	room_name : "rm_ev_level_select"
})
add_child(quit_button)
var textbox_scale = 5;
var textbox_left_pos = 112 - 78;
var textbox_x = textbox_left_pos + 8 * textbox_scale;

name_textbox = instance_create_layer(textbox_x, 72 - 10, "WindowElements", asset_get_index("obj_ev_textbox"), 
{
	txt : global.level.name,
	empty_text : "Level Name",
	base_scale_x : textbox_scale,
	allow_newlines : false,
	automatic_newline: false,
	char_limit : 30,
	opened_x : room_width / 2,
	opened_y : room_height / 2
	//exceptions: "~`!@#$%^&()_=-+{} [],.;'"
})
	
description_textbox = instance_create_layer(textbox_x, 72 + 10, "WindowElements", asset_get_index("obj_ev_textbox"), 
{
	txt : global.level.description,
	empty_text : "Level Description",
	char_limit : 256,
	base_scale_x : textbox_scale,
	allow_newlines : false,
	opened_x : room_width / 2,
	opened_y : room_height / 2
})

description_textbox.depth--;
	
add_child(save_button)
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

var man = instance_create_layer(112 + 43, 72 - 14, "WindowElements", asset_get_index("obj_ev_man"))
add_child(man)

music_select = instance_create_layer(112 + 48, 72 + 4, "WindowElements", asset_get_index("obj_ev_music_select"), {
	base_scale_x : 1,
	preselected_music : global.level.music
})

theme_selector = instance_create_layer(112 + 50, 72 - 35, "WindowElements", asset_get_index("obj_ev_selector"), {
	elements : ["Regular", "Universe", "White Void"],
	selected_element : global.level.theme,
	max_radius : 32
})
var claim_button = instance_create_layer(112 + 46, 72 + 40, "WindowElements", asset_get_index("obj_ev_executing_button"), {
	func : function () {
		global.mouse_layer++
		new_window(11, 6, asset_get_index("obj_ev_claim_window"), 
		{
			layer_num : global.mouse_layer,
			layer : layer_get_id("Windows2")
		})
	},
	layer_num : global.mouse_layer,
	sprite_index : agi("spr_ev_claim")
})

add_child(theme_selector)
add_child(music_select)
add_child(claim_button)
