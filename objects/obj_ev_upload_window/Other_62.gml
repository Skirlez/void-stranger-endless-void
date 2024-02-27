if ds_map_find_value(async_load, "id") == post_level_id
{
	var http_status = ds_map_find_value(async_load, "http_status");
	show_debug_message(http_status)

    if ds_map_find_value(async_load, "status") == 0
    {

		if (ds_map_find_value(async_load, "http_status") == 201) {
	        var key = ds_map_find_value(async_load, "result");
			on_finish_upload(key);
		}
    }
}
if ds_map_find_value(async_load, "id") == update_level_id
{
	var http_status = ds_map_find_value(async_load, "http_status");
	show_debug_message(http_status)
		show_debug_message("here")
	if (ds_map_find_value(async_load, "http_status") == 200)
		on_finish_update()
	else
		on_fail()
}

if ds_map_find_value(async_load, "id") == delete_level_id
{
	var http_status = ds_map_find_value(async_load, "http_status");
	show_debug_message(http_status)
	if (is_undefined(http_status))
		show_debug_message("here")
	if (ds_map_find_value(async_load, "http_status") == 204)
		on_finish_delete()
	else
		on_fail()
}