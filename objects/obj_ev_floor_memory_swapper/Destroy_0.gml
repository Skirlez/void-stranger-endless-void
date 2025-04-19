if (global.cif_destroy != 0)
    return;
if instance_exists(asset_get_index("obj_player"))
{
    if (asset_get_index("obj_player").state == (13 << 0) && destroyer_id == 1)
    {
        ds_grid_set(asset_get_index("obj_inventory").ds_player_info, 1, 3, 9)
        with (asset_get_index("obj_player"))
        {
            var new_tile_str = string_insert("N", tile_str, string_length(tile_str))
            tile_str = new_tile_str
            //show_debug_message(tile_str)
        }
    }
}
if (destroyer_id == 1)
{
    if (ds_grid_get(asset_get_index("obj_inventory").ds_equipment, 0, 4) == 1)
    {
        global.swapper_backup = 1 
		//Literally just use the entirety of scr_errmessage because using it in
		//asset_get_index makes it break for some reason, and putting it raw
		//appends self. to the start crashing the game...
        if (!instance_exists(asset_get_index("obj_errormessages")))
            instance_create_depth(0, 0, 710, asset_get_index("obj_errormessages"))
        with (asset_get_index("obj_errormessages"))
        {
            alarm[1] = 1
            alarm[2] = 1
            e_message = 495
			dummy_swapper = 1
            event_perform(ev_other, ev_user1)
        }
        ds_grid_set(asset_get_index("obj_inventory").ds_equipment, 0, 4, 0)
    }
}
