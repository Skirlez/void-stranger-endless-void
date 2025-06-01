function ev_set_play_variables(display_locusts = true) {
	static inv = agi("obj_inventory");
	
	// idk what these do
	global.memory_backup = 0
	global.wings_backup = 0
	global.blade_backup = 0	
    global.swapper_backup = 0
	
	// burdens off
	ds_grid_set(inv.ds_equipment, 0, 0, 0)
	ds_grid_set(inv.ds_equipment, 0, 1, 0)
	ds_grid_set(inv.ds_equipment, 0, 2, 0)
	ds_grid_set(inv.ds_equipment, 0, 4, 0)
	ds_grid_set(inv.ds_player_info, 10, 2, 4)


	// Some flags related to if you've collected a thing before?
	ds_grid_set(inv.ds_player_info, 15, 0, 0) 
	ds_grid_set(inv.ds_player_info, 15, 1, 0)
	ds_grid_set(inv.ds_player_info, 15, 2, 0)
	ds_grid_set(inv.ds_player_info, 15, 3, 0)
	
	ds_grid_set(inv.ds_player_info, 0, 1, display_locusts)
	ds_grid_set(inv.ds_player_info, 1, 1, 0) // Locust count
	
	// stops the player from doing blink a animation when starting level
	global.player_blink = 0
}

function ev_prepare_level_burdens(level) {
	static inv = agi("obj_inventory");
	ds_grid_set(inv.ds_equipment, 0, 0, 0)
	ds_grid_set(inv.ds_equipment, 0, 1, 0)
	ds_grid_set(inv.ds_equipment, 0, 2, 0)
	ds_grid_set(inv.ds_equipment, 0, 4, 0)
	ds_grid_set(inv.ds_player_info, 10, 2, 4)
	if (level.burdens[0])
		ds_grid_set(inv.ds_equipment, 0, 0, 1)
	if (level.burdens[1])
		ds_grid_set(inv.ds_equipment, 0, 1, 2)
	if (level.burdens[2])
		ds_grid_set(inv.ds_equipment, 0, 2, 3)
	if (level.burdens[3])
		ds_grid_set(inv.ds_player_info, 10, 2, 999)
	if (level.burdens[4])
		ds_grid_set(inv.ds_equipment, 0, 4, 1)
}

function ev_prepare_level_visuals(level) {
	if level.theme == level_themes.universe
		global.universe = 1;
	else
		global.universe = 0;
	
	if level.theme == level_themes.white_void
		global.floorvanish = 1;
	else
		global.floorvanish = 0;
}

