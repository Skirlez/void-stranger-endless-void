event_inherited()
global.mouse_layer++;
new_window(0, 0, asset_get_index("obj_ev_level_select"), {
	pack_selector : true,
	layer_num : global.mouse_layer,
	buttons_layer : "LevelSelectWindowElements"
})