sprite_index = asset_get_index("spr_floor")
grid_size = global.grid_x
var collision = instance_place(x, y, asset_get_index("obj_collision"))
with (collision)
    instance_destroy()
destroyer_id = 0
depth = 399
draw_flash = false
flash_frame = 0
