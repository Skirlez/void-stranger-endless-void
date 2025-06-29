if !ev_is_mouse_on_me()
	exit;
index++
if index >= array_length(musics)
	index = 0
	
ev_play_music(musics[index])
txt = string(index)