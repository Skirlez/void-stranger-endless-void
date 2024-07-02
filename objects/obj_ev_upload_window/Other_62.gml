if ds_map_find_value(async_load, "id") == post_level_id
{
	var http_status = ds_map_find_value(async_load, "http_status");
	if ds_map_find_value(async_load, "status") == 0
	{
		if (http_status == 201) {
			var key = ds_map_find_value(async_load, "result");
			on_finish_upload(key);
		}
		else
			on_fail(ds_map_find_value(async_load, "result"))
	}
	else
		on_fail("No idea tbh")
}
if ds_map_find_value(async_load, "id") == update_level_id
{
	var http_status = ds_map_find_value(async_load, "http_status");
	if (http_status == 200)
		on_finish_update()
	else
		on_fail(ds_map_find_value(async_load, "result"))
}

if ds_map_find_value(async_load, "id") == delete_level_id
{
	var http_status = ds_map_find_value(async_load, "http_status");
	if (http_status == 204)
		on_finish_delete()
	else
		on_fail(ds_map_find_value(async_load, "result"))
}
if ds_map_find_value(async_load, "id") == post_level_verify_id {
	var http_status = ds_map_find_value(async_load, "http_status");
	if (http_status == 200)
		on_verify_upload()
	else
		on_fail_verify()
}