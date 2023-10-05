switch (image_index) {
	case 0: // play
		room_goto(asset_get_index("rm_ev_level"))
		break;
	case 1: // eraser
		if (global.selected_thing != 1)
			global.selected_thing = 1
		else
			global.selected_thing = -1
		break;
	case 2: // tile mode on
	case 3: // object mode on
		global.editor_object.switch_tile_modes();
		image_index = global.tile_mode ? 2 : 3
		if (global.selected_thing == 2) {
			global.selected_thing = -1
			global.selected_placeable_num = -1
		}
		break;
	case 4: // settings
		break;
	case 5: // trash bin
		global.erasing = 350;
		audio_play_sound(comes_sound, 10, false)
		break;
}