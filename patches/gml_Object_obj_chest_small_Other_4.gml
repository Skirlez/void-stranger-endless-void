// TARGET: LINENUMBER
// 58
// Make empty if we already have idol
if (contents == 495 && ds_grid_get(obj_inventory.ds_equipment, 0, 4) != 0)
{
    image_speed = 1
    empty = true
}