event_inherited();

if mode == level_selector_modes.selecting_level_for_pack {
	with (global.pack_editor_instance) {
		on_menu_destroy()
	}
}