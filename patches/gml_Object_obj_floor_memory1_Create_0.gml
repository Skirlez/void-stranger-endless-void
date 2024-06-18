// TARGET: REPLACE
sprite_index = spr_floor
grid_size = global.grid_x
spr_inv_items = spr_items
switch global.memory_style
{
    case 4:
        spr_inv_items = spr_ev_items_two
        break
    case 3:
        spr_inv_items = spr_ev_items_one
        break
    case 2:
        spr_inv_items = spr_items_special
        break
    case 1:
        spr_inv_items = spr_items_cif
        break
    default:
        spr_inv_items = spr_items
        break
}
cell_size = 16
spr_inv_items_columns = (sprite_get_width(spr_inv_items) / cell_size)
spr_inv_items_rows = (sprite_get_height(spr_inv_items) / cell_size)
var collision = instance_place(x, y, obj_collision)
with (collision)
    instance_destroy()
destroyer_id = 0
depth = 399
