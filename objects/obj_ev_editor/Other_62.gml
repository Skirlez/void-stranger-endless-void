if ds_map_find_value(async_load, "id") == get_levels
{
    if ds_map_find_value(async_load, "status") == 0 {
        online_levels_str = ds_map_find_value(async_load, "result");
		
		global.online_levels = string_split_buffer(online_levels_str, ",")
		
		with (asset_get_index("obj_ev_level_select"))
			on_online_update();
		
    }
    else {
		online_levels_str = noone;
		
    }
}