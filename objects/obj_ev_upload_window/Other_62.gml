
if ds_map_find_value(async_load, "id") == post_level
{
    if ds_map_find_value(async_load, "status") == 0
    {
        var key = ds_map_find_value(async_load, "result");
		on_finish(key);
    }
}