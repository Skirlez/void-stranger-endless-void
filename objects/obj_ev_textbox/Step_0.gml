event_inherited()
if window.clicked_element == id {
	keyboard_lastchar = ""
}

if window.selected_element == id {
	var char = keyboard_lastchar
	txt += char
	keyboard_lastchar = ""
	show_debug_message(txt)
}
