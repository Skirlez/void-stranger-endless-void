time--;

if time == 0 {
	if grube {
		instance_destroy(id)
		exit
	}
	audio_play_sound(asset_get_index("snd_voidrod_place"), 10, false)
	audio_stop_sound(global.goes_sound)
	room_goto(asset_get_index("rm_ev_editor"))
	
}
outer_circle_size = lerp(outer_circle_size, 70, 0.08)
if (time < (start_time - 30) && outer_circle_alpha > 0)
	outer_circle_alpha -= 0.05
