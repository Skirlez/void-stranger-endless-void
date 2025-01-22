var asset = asset_get_index("obj_ev_pack_player")
if asset == -1
	exit
with (asset)
	on_room_create();