// called from gml_Object_obj_chest_small_Step_0
function ev_on_chest_collected() {
	ds_map_set(global.locusts_collected_this_level, (y div 16) * 14 + (x div 16), true)
}