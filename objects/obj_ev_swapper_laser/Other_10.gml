var swap_x = x
var swap_y = y
with (swap_object)
{
    swap_x = x
    swap_y = y
    x = asset_get_index("obj_player").x
    y = asset_get_index("obj_player").y
	if (object_index == other.tree_index)
		y -= 24
	
    with (instance_place(x, y, asset_get_index("obj_glassfloor")))
        didplayermove = false
    with (instance_place(x, y, asset_get_index("obj_bombfloor")))
        didplayermove = false	
}
with (asset_get_index("obj_player"))
{
    x = swap_x
    y = swap_y
	if (other.swap_object.object_index == other.tree_index)
		y += 24;
    if (float == 1 && (!(instance_place(x, y, asset_get_index("obj_pit")))))
    {
        float = 0
        can_float = 1
        float_state = 0
        switch set_p_direction
        {
            case 0:
                var wings_dis = instance_create_layer(x, y, "Effects", asset_get_index("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 0
                break
            case 1:
                wings_dis = instance_create_layer(x, y, "Effects", asset_get_index("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 1
                break
            case 2:
                wings_dis = instance_create_layer(x, y, "Effects", asset_get_index("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 2
                break
            case 3:
                wings_dis = instance_create_layer(x, y, "Player", asset_get_index("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 3
                break
        }
    }
    with (instance_place(x, y, asset_get_index("obj_glassfloor")))
        didplayermove = false
    with (instance_place(x, y, asset_get_index("obj_bombfloor")))
        didplayermove = false		
}
with (asset_get_index("obj_ev_swapper_target"))
    fade_away = true
instance_create_layer(x, y, "Effects", asset_get_index("obj_sparkle"))
instance_create_layer(swap_x, swap_y, "Effects", asset_get_index("obj_sparkle"))
isfx = audio_play_sound(asset_get_index("snd_voidrod_place"), 1, 0)
audio_sound_pitch(isfx, 1.5)
lifetime = 5
