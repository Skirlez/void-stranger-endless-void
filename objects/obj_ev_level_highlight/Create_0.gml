event_inherited()

var play = instance_create_layer(208, 40, "LevelHighlightButtons", asset_get_index("obj_ev_play_button"))
play.layer_num = 1
play.lvl = lvl
play.display_instance = display_instance
play.highlighter = id;
play.image_alpha = 0

var edit = instance_create_layer(192, 40, "LevelHighlightButtons", asset_get_index("obj_ev_edit_button"))
edit.layer_num = 1
edit.lvl = lvl
edit.display_instance = display_instance;
edit.highlighter = id;
edit.image_alpha = 0

var copy = instance_create_layer(192, 60, "LevelHighlightButtons", asset_get_index("obj_ev_copy_button"))
copy.layer_num = 1
copy.lvl = lvl
copy.image_alpha = 0

description_textbox = instance_create_layer(200, 125, "LevelDescription", asset_get_index("obj_ev_textbox"), 
{
	txt : lvl.description,
	empty_text : "No description provided.",
	base_scale_x : 2,
	base_scale_y : 1,
	layer_num : 1,
	allow_deletion : false,
	char_limit : 0,	
	opened_x : room_width / 2,
	opened_y : room_height / 2,
	image_alpha : 0
})


var back = instance_create_layer(200, 16, "LevelHighlightButtons", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : "rm_ev_level_select",
	layer_num : 1,
	image_alpha : 0
});



add_child(play)
add_child(edit)
add_child(back)
add_child(description_textbox)
add_child(copy)


if (!global.online_mode) {
	var deleteb = instance_create_layer(192, 90, "LevelHighlightButtons", asset_get_index("obj_ev_delete_button"))
	deleteb.layer_num = 1
	deleteb.level_select = instance_find(asset_get_index("obj_ev_level_select"), 0)
	deleteb.save_name = lvl.save_name
	deleteb.image_alpha = 0
	add_child(deleteb)
}


function hide_textbox() {
	layer_add_instance("LevelHighlightButtons", description_textbox)
	description_textbox.size_time = 0;
}