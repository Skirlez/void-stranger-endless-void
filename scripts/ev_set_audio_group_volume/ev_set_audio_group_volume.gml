// EV can't actually have audio groups, that would place some audio outside the data.win
// having audio outside the data.win would complicate distributing the mod by a lot
// in VS audio groups are used to categorize sounds into sfx and music, and that's how
// the in game volume sliders work

// so instead of categorizing our sounds into audiogroups, 
// we categorize them at runtime using their name

// called from gml_GlobalScript_scr_audio_group_set_gain_vs
function ev_set_audio_group_volume(vs_group, volume, time) {
	static did_the_thing = false;
	static sounds = []
	static sound_base_volumes = []
	static music = []
	static music_base_volumes = []
	if (!did_the_thing) {
		var sound = 0;
		while (audio_exists(sound)) {
			if string_starts_with(audio_get_name(sound), "snd_ev_music_") {
				array_push(music, sound)
				array_push(music_base_volumes, audio_sound_get_gain(sound))	
			}
			else if string_starts_with(audio_get_name(sound), "snd_ev_") {
				array_push(sounds, sound)
				array_push(sound_base_volumes, audio_sound_get_gain(sound))		
			}
			sound++;
		}
		did_the_thing = true;
	}
	if vs_group == 1 { 
		// music
		for (var i = 0; i < array_length(music); i++)
			audio_sound_gain(music[i], volume * music_base_volumes[i], time)

	}
	else if vs_group == 2 {
		// sfx
		for (var i = 0; i < array_length(sounds); i++)
			audio_sound_gain(sounds[i], volume * sound_base_volumes[i], time)
	}
}