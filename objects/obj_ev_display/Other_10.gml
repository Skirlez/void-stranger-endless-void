event_inherited()
if (global.mouse_layer != layer_num)
	exit

// display only has a window managing it on the level select and not in the editor,
// so we know that this is for when it's been clicked in the level select

global.mouse_layer = -1;
global.editor_instance.preview_level_transition(lvl, id)
highlighted = true;