// TARGET: LINENUMBER
// 3
global.justice = 0
global.voider = true
ds_grid_set(obj_inventory.ds_equipment, 0, 0, 1)
ds_grid_set(obj_inventory.ds_equipment, 0, 1, 2)
ds_grid_set(obj_inventory.ds_equipment, 0, 2, 3)

room_goto(rm_ev_startup)
exit