switch (image_index) {
	case 0: // cursor
	case 1: // eraser
		if (global.selected_thing != image_index)
			global.selected_thing = image_index
		else
			global.selected_thing = -1
		break;
	case 2: // tile mode on
	case 3: // object mode on
		global.tile_mode = !global.tile_mode;
		image_index = global.tile_mode ? 2 : 3
		if (global.selected_thing == 2) {
			global.selected_thing = -1
			global.selected_placeable_num = -1
		}
		break;
	case 4: // settings
		break;
}