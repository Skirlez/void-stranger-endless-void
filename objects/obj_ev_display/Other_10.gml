event_inherited()
// display only has a window managing it on the level select and not in the editor,
// so we know that this is for when it's been clicked in the level select
if (global.mouse_layer != layer_num)
	exit

window.level_clicked(id);
