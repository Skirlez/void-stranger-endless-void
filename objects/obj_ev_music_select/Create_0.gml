event_inherited();
index = 0
musics = array_create(array_length(global.music_names))
for (var i = 0; i < array_length(global.music_names); i++) {
	musics[i] = asset_get_index(global.music_names[i])	
	if global.level.music == global.music_names[i]
		index = i
}
txt = string(index)
	

	
