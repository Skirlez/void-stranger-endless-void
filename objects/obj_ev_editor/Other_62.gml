if ds_map_find_value(async_load, "id") == get_levels
{
    if ds_map_find_value(async_load, "status") == 0 {
        online_levels_str = ds_map_find_value(async_load, "result");
		
		
		var arr = string_split(online_levels_str, ",")
		global.online_levels = array_create(array_length(arr))
		for (var i = 0; i < array_length(arr); i++) {
			show_debug_message(arr[i])
			global.online_levels[i] = import_level(arr[i]);
		}
    }
    else {
		online_levels_str = noone;
		
    }
	show_debug_message(online_levels_str)
}