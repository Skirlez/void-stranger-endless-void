function ev_prepare_level(level = noone) {
	// resets all burdens
	var inv = agi("obj_inventory");
	global.memory_backup = 0
	global.wings_backup = 0
	global.blade_backup = 0	
    global.swapper_backup = 0	
	ds_grid_set(inv.ds_equipment, 0, 0, 0)
	ds_grid_set(inv.ds_equipment, 0, 1, 0)
	ds_grid_set(inv.ds_equipment, 0, 2, 0)
    ds_grid_set(inv.ds_equipment, 0, 4, 0)	
	ds_grid_set(inv.ds_player_info, 10, 2, 4)

	if level != noone {
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

	ds_grid_set(inv.ds_player_info, 0, 2, "V???")

	ds_grid_set(inv.ds_player_info, 0, 1, 1) // Display locusts flag
	ds_grid_set(inv.ds_player_info, 1, 1, 0) // Locust count
	
	// Some flags related to if you've collected a thing before?
	ds_grid_set(inv.ds_player_info, 15, 0, 0) 
	ds_grid_set(inv.ds_player_info, 15, 1, 0)
	ds_grid_set(inv.ds_player_info, 15, 2, 0)
	ds_grid_set(inv.ds_player_info, 15, 3, 0)


	global.player_blink = 0
}

