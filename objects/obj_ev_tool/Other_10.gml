event_inherited()
switch (image_index) {
	case 0: // plucker
		if (global.selected_thing != thing_plucker)
			global.selected_thing = thing_plucker
		else
			global.selected_thing = -1
		break;
	case 1: // eraser
		if (global.selected_thing != thing_eraser)
			global.selected_thing = thing_eraser
		else
			global.selected_thing = -1
		break;
	case 2: // tile mode on
	case 3: // object mode on
		global.editor_instance.switch_tile_mode(!global.tile_mode);

		break;
	case 4: // undo
		global.editor_instance.undo();
		break;
	case 5: // trash bin
		global.erasing = 350;
		audio_play_sound(comes_sound, 10, false, 1, 0, 1)
		break;
	case 6: // picker
		if (global.selected_thing != thing_picker)
			global.selected_thing = thing_picker
		else
			global.selected_thing = -1
		break;
}