// TARGET: LINENUMBER
// 3

// resets all burdens
ds_grid_set(obj_inventory.ds_equipment, 0, 0, 0)
ds_grid_set(obj_inventory.ds_equipment, 0, 1, 0)
ds_grid_set(obj_inventory.ds_equipment, 0, 2, 0)
ds_grid_set(obj_inventory.ds_player_info, 10, 2, 4)


if (global.level.burdens[0])
	ds_grid_set(obj_inventory.ds_equipment, 0, 0, 1)
if (global.level.burdens[1])
	ds_grid_set(obj_inventory.ds_equipment, 0, 1, 2)
if (global.level.burdens[2])
	ds_grid_set(obj_inventory.ds_equipment, 0, 2, 3)
if (global.level.burdens[3])
	ds_grid_set(obj_inventory.ds_player_info, 10, 2, 999)


ds_grid_set(obj_inventory.ds_player_info, 0, 2, "B???")

ds_grid_set(obj_inventory.ds_player_info, 0, 1, 1) // Display locusts flag
ds_grid_set(obj_inventory.ds_player_info, 1, 1, 0) // Locust count

global.player_blink = 0