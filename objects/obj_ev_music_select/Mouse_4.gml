if layer_num != global.mouse_layer
	exit
index++
if index >= array_length(musics)
	index = 0
	
ev_play_music(musics[index])
txt = string(index)