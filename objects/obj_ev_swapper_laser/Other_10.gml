var swap_x = x
var swap_y = y
with (swap_object)
{
    swap_x = x
    swap_y = y
    x = agi("obj_player").x
    y = agi("obj_player").y
	if (object_index == other.tree_index)
		y -= 24
	if (object_index == other.boulder_index && b_form == 10) {
		ev_tis_wraparound()
		if o_move_x == 0 && o_move_y == 0
			swapper_disable_lightning = true;
	}
	
    with (instance_place(x, y, agi("obj_glassfloor")))
        didplayermove = false
    with (instance_place(x, y, agi("obj_bombfloor")))
        didplayermove = false	
}
with (agi("obj_player"))
{
    x = swap_x
    y = swap_y
	if (other.swap_object.object_index == other.tree_index)
		y += 24;
    if (float == 1 && (!(instance_place(x, y, agi("obj_pit")))))
    {
        float = 0
        can_float = 1
        float_state = 0
        switch set_p_direction
        {
            case 0:
                var wings_dis = instance_create_layer(x, y, "Effects", agi("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 0
                break
            case 1:
                wings_dis = instance_create_layer(x, y, "Effects", agi("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 1
                break
            case 2:
                wings_dis = instance_create_layer(x, y, "Effects", agi("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 2
                break
            case 3:
                wings_dis = instance_create_layer(x, y, "Player", agi("obj_player_wings_dissipate"))
                with (wings_dis)
                    wing_dir = 3
                break
        }
    }
    with (instance_place(x, y, agi("obj_glassfloor")))
        didplayermove = true
    with (instance_place(x, y, agi("obj_bombfloor")))
        didplayermove = true		
}
with (agi("obj_ev_swapper_target"))
    fade_away = true
instance_create_layer(x, y, "Effects", agi("obj_sparkle"))
instance_create_layer(swap_x, swap_y, "Effects", agi("obj_sparkle"))
isfx = audio_play_sound(agi("snd_voidrod_place"), 1, 0)
audio_sound_pitch(isfx, 1.5)
lifetime = 5
