// called from gml_Object_obj_chest_small_Step_0
function ev_on_chest_collected() {
	static pack_player = agi("obj_ev_pack_player")
	ds_map_set(global.locusts_collected_this_level, (y div 16) * 14 + (x div 16), true)
	if instance_exists(pack_player)
		pack_player.total_locusts_collected++;
}