event_inherited()
if window.clicked_element == id {
	keyboard_lastchar = ""
	keyboard_lastkey = 0

}

if window.selected_element == id {
	if size_time < 100
		size_time += 10

	switch (keyboard_lastkey) {
		case vk_backspace:
			txt = string_delete(txt, string_length(txt), 1)
			break;
		case vk_enter:
			// alowing keyboard_lastchar inserts an Evil and Fucked Up newline character that is not \n
			// so we do this instead.
			txt += "\n" 
			break;
		case vk_escape:
			window.selected_element = noone
			break;
		default:
			txt += keyboard_lastchar
	}

	keyboard_lastchar = ""
	keyboard_lastkey = 0
}
else {
	if size_time > 0
		size_time -= 10
}
calculate_scale()

var t = animcurve_channel_evaluate(curve, size_time / 100)
image_xscale = lerp(base_scale_x, xscale, t)
image_yscale = lerp(1, yscale, t)
update_position()
