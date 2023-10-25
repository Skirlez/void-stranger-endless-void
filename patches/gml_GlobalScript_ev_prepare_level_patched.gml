// TARGET: LINENUMBER
// 3


ds_grid_set(obj_inventory.ds_equipment, 0, 0, 1)
/* all burdens and rod
ds_grid_set(obj_inventory.ds_equipment, 0, 1, 2)
ds_grid_set(obj_inventory.ds_equipment, 0, 2, 3)
ds_grid_set(obj_inventory.ds_player_info, 10, 2, 999)
*/

//ds_grid_set(obj_inventory.ds_equipment, 0, 0, 0)
ds_grid_set(obj_inventory.ds_equipment, 0, 1, 0)
ds_grid_set(obj_inventory.ds_equipment, 0, 2, 0)
ds_grid_set(obj_inventory.ds_player_info, 10, 2, 4)

ds_grid_set(obj_inventory.ds_player_info, 0, 2, "B???")

global.player_blink = 0