
event_inherited()
if instance_exists(asset_get_index("obj_ev_pack_editor")) {
	with (asset_get_index("obj_ev_pack_editor")) {
		on_menu_destroy()
	}
}