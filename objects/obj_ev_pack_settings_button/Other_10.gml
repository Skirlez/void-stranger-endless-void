event_inherited();
global.mouse_layer++;
with (global.pack_editor_instance)
	on_menu_create();

new_window(14, 9, asset_get_index("obj_ev_pack_settings_window"), {
	mode : level_selector_modes.selecting_level_for_pack,
	layer_num : global.mouse_layer,
	buttons_layer : "LevelSelectWindowElements"
})

global.pack_editor_instance.select(pack_things.nothing)

