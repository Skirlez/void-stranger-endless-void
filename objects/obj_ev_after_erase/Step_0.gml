time--;

if grube && (start_time - time) > 60 {
	instance_destroy(id)
	exit
}
if time == 0 {
	audio_play_sound(agi("snd_voidrod_place"), 10, false)
	audio_stop_sound(global.goes_sound)
	room_goto(agi("rm_ev_editor"))	
}
outer_circle_size = lerp(outer_circle_size, 70, 0.08)
if (time < (start_time - 30) && outer_circle_alpha > 0)
	outer_circle_alpha -= 0.05
