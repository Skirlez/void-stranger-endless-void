event_inherited()
var display_inst = instance_find(asset_get_index("obj_ev_display"), 0)

var play = instance_create_layer(208, 40, "LevelHighlightButtons", asset_get_index("obj_ev_play_button"))
play.layer_num = 1
play.lvl = display_inst.lvl
play.display_inst = display_inst

var edit = instance_create_layer(192, 40, "LevelHighlightButtons", asset_get_index("obj_ev_edit_button"))
edit.layer_num = 1
edit.lvl = display_inst.lvl


var back = instance_create_layer(200, 16, "LevelHighlightButtons", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : "rm_ev_level_select",
	layer_num : 1,
});

add_child(play)
add_child(edit)
add_child(back)