event_inherited();
index = 0
musics = array_create(array_length(global.music_names))
for (var i = 0; i < array_length(global.music_names); i++) {
	musics[i] = agi(global.music_names[i])	
	if preselected_music == global.music_names[i]
		index = i
}
txt = string(index)
calculate_scale_and_offset()