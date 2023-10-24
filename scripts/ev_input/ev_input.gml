function ev_mouse_held() {
	return global.mouse_held
}
function ev_mouse_pressed() {
	return global.mouse_pressed
}
function ev_mouse_released() {
	return mouse_check_button_released(mb_left)
}
function ev_is_mouse_on_me() {
	return position_meeting(mouse_x, mouse_y, id) && layer_num == global.mouse_layer
}
function ev_is_action_pressed() {
	return keyboard_check_pressed(ord("Z"))
}
function ev_get_action_key() {
	return ord("Z")
}
// This file will be patched inside Void Stranger to utilize its input system.