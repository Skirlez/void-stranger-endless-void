sprite_index = agi("spr_floor")
grid_size = global.grid_x
var collision = instance_place(x, y, agi("obj_collision"))
with (collision)
    instance_destroy()
destroyer_id = 0
depth = 399
draw_flash = false
flash_frame = 0
