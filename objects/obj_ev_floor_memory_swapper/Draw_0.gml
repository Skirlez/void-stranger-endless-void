draw_sprite(asset_get_index("spr_empty"), 0, x, y)
draw_sprite(asset_get_index("spr_floor_white"), 0, x, y)
if ((!(place_meeting(x, (y + grid_size), asset_get_index("obj_floor_tile")))) && (!(place_meeting(x, (y + grid_size), asset_get_index("obj_collision")))))
    draw_sprite(sprite_index, 1, x, (y + grid_size))
else if place_meeting(x, (y + grid_size), asset_get_index("obj_glassfloor"))
    draw_sprite(sprite_index, 1, x, (y + grid_size))
if (global.swapper_toggle == true && ds_grid_get(asset_get_index("obj_inventory").ds_equipment, 0, 4) == 1)
{
    draw_sprite(asset_get_index("spr_ev_swapper"), 0, (x - 8), (y - 8))
    if (draw_flash == true)
        draw_sprite(asset_get_index("spr_ev_swapper_flash"), flash_frame, x, y)
}
if (global.swapper_toggle == false && ds_grid_get(asset_get_index("obj_inventory.ds_equipment"), 0, 4) == 1)
{
    draw_sprite(asset_get_index("spr_ev_swapper"), 0, (x - 8), (y - 8))
    draw_sprite(asset_get_index("spr_menu_crossed"), 0, x, y)
}
