function ev_mouse_held() {
	return global.mouse_held
}
function ev_mouse_pressed() {
	return global.mouse_pressed
}

function ev_mouse_right_held() {
	return global.mouse_right_held
}
function ev_mouse_right_pressed() {
	return global.mouse_right_pressed
}
function ev_mouse_released() {
	return global.mouse_released
}
function ev_mouse_right_released() {
	return global.mouse_right_released
}


function ev_is_mouse_on_me() {
	if layer_num != global.mouse_layer
		return false
	return global.instance_touching_mouse == id
}

function ev_is_action_pressed() {
	if (global.compiled_for_merge) {
		static func = asset_get_index("scr_input_check_pressed");
		return func(4)
	}
	
	return keyboard_check_pressed(ord("Z"))
}
function ev_is_action_held() {
	if (global.compiled_for_merge) {
		static func = asset_get_index("scr_input_check");
		return func(4)
	}
	return keyboard_check(ord("Z"))
}
function ev_get_action_key() {
	if (global.compiled_for_merge) {

		return variable_global_get("key_action")
	}

	
	return ord("Z")
}
function ev_get_horizontal_pressed() {
	return keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
}
function ev_get_vertical_pressed() {
	return keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
}
function ev_get_horizontal_held() {
	return keyboard_check(vk_right) - keyboard_check(vk_left)
}
function ev_get_vertical_held() {
	return keyboard_check(vk_down) - keyboard_check(vk_up)
}

function ev_is_leave_key_pressed() {
	return keyboard_check_pressed(vk_backspace)
}
function ev_is_tile_mode_hotkey_pressed() {
	return keyboard_check_pressed(vk_shift)
}
function ev_is_picker_hotkey_pressed() {
	return mouse_check_button_pressed(mb_middle)
}