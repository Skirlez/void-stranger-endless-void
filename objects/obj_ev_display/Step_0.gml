if (ev_is_mouse_on_me()) {
	var tile_j = floor((mouse_x - x) / (16 * image_xscale))
	var tile_i = floor((mouse_y - y) / (16 * image_yscale))
	
	if ev_mouse_held() {
		if (last_clicked_i != tile_i || last_clicked_j != tile_j) {
		
			if painting = false {
				global.editor_object.add_undo()
				painting = true;
			}
		
			handle_click_before(tile_i, tile_j)
			handle_click(tile_i, tile_j)
		
			last_clicked_i = tile_i;
			last_clicked_j = tile_j;
		}
	}
	
	else if painting == true
		painting = false;	

	 

	if (!dragging && mouse_check_button_pressed(mb_right)
			&& !(global.selected_thing == thing_placeable 
				&& held_tile_state != noone 
				&& held_tile_state.tile.flags & flag_only_one)) {
		dragging = true
		drag_box_i = tile_i
		drag_box_j = tile_j
	}
	else if dragging && mouse_check_button_released(mb_right) {
		var small_tile_i = drag_box_i
		var small_tile_j = drag_box_j
		
		if (tile_i < drag_box_i) {
			small_tile_i = tile_i
			tile_i = drag_box_i
		}
		if (tile_j < drag_box_j) {
			small_tile_j = tile_j
			tile_j = drag_box_j
		}
		global.editor_object.add_undo()
		for (var i = small_tile_i; i <= tile_i; i++) {
			for (var j = small_tile_j; j <= tile_j; j++)
				handle_click(i, j)

		}
		
		dragging = false		
		drag_box_i = -1
		drag_box_j = -1
	}
	
	if global.selected_thing == 2 && keyboard_check_pressed(ord("Z"))
			&& held_tile_state != noone && held_tile_state.tile.zed_function != noone {
		held_tile_state.tile.zed_function(held_tile_state)
	}

}
else {
	painting = false;
	last_clicked_i = -1;
	last_clicked_j = -1;
	if dragging = true {
		dragging = false
		drag_box_i = -1
		drag_box_j = -1
	}
}
