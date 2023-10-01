/*
function ev_mouse_held() {
	return mouse_check_button(mb_left)
}

function ev_mouse_clicked(){
	return mouse_check_button_pressed(mb_left)
}

function ev_mouse_right_clicked() {
	return mouse_check_button_pressed(mb_right)
}

function ev_mouse_right_click_released() {
	return mouse_check_button_released(mb_right)
}
*/

function ev_is_mouse_on_me() {
	return position_meeting(mouse_x, mouse_y, id)
}