
function ev_switch_to_user_palette() {
	if global.is_merged
		agi("change_palette")(ds_grid_get(agi("obj_menu").ds_menu_graphics, 3, 8))

}