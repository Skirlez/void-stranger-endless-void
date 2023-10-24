clicked_element = noone;
if ev_mouse_pressed() {
	selected_element = noone;
	for (var i = 0; i < array_length(children); i++) {
		var child = children[i];
		if position_meeting(mouse_x, mouse_y, child) {
			selected_element = child;
			clicked_element = child;	
		}
	}
}