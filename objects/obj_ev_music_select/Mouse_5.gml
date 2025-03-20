if layer_num != global.mouse_layer
	exit
index--
if index < 0
	index = array_length(musics) - 1
	
ev_play_music(musics[index])
txt = string(index)