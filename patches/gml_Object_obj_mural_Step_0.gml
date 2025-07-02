// have textbox copy mural brand and mural text so it can draw them.
// TARGET: LINENUMBER
// 610
active_textbox.ev_mural_brand = ev_mural_brand
active_textbox.ev_mural_text = ev_mural_text

// have correct inscription dialogue. 
// could potentially write character specific stuff here
// TARGET: LINENUMBER
// 606
if (inscription == 19) {
	if ev_mural_brand == 0 {
		text[0] = scrScript(1245)
		moods = [neutral]
		speakers = [id]
	}
	else {
		if (ds_grid_get(obj_inventory.ds_equipment, 0, 0) == 0 || global.memory_toggle == false) {
			text[0] = scrScript(1200)
			moods = [neutral]
			speakers = [id]
		}
		else {
			text[0] = scrScript(1200)
			text[1] = scrScript(180)
			text[2] = string_upper(ev_mural_text)
			if text[2] == ""
				text[2] = " "
			moods = [neutral, neutral, neutral]
			speakers = [id, id, id]
		}
	}
}