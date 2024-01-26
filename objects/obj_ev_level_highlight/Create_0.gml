event_inherited()
play = instance_create_layer(210, 40, "LevelHighlightButtons", asset_get_index("obj_ev_play"))
play.layer_num = 1


back = instance_create_layer(200, 16, "LevelHighlightButtons", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : "rm_ev_level_select",
	layer_num : 1,
});

