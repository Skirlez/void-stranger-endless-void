if audio_is_playing(death_sound)
	audio_stop_sound(death_sound)
if type == ev_grube_types.level_cube && visible {
	sprite_delete(sprite_index)
}
physics_fixture_delete(fix)