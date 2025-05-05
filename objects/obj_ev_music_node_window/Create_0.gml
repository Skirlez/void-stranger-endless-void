event_inherited();
music_select = instance_create_layer(x, y, "WindowElements", asset_get_index("obj_ev_music_select"), {
	base_scale_x : 1,
	preselected_music : node_instance.properties.music
})
add_child(music_select)
global.void_radio_disable_stack++;
ev_play_music(agi(node_instance.properties.music), true);