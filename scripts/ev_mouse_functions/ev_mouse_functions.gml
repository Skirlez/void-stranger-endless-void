function ev_mouse_held() {
	return global.mouse_held
}

function ev_mouse_pressed() {
	return global.mouse_pressed
}
function ev_is_mouse_on_me() {
	return position_meeting(mouse_x, mouse_y, id) && layer_num == global.mouse_layer
}