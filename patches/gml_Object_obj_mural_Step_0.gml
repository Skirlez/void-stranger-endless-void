// have textbox copy mural brand and mural text so it can draw them

// TARGET: LINENUMBER
// 610
active_textbox.ev_mural_brand = ev_mural_brand
active_textbox.ev_mural_text = ev_mural_text

// correct inscription dialogue
// could potentially write character specific stuff here

// TARGET: LINENUMBER
// 275
else if (inscription == 19) {
	text[0] = scrScript(1200)
	text[1] = scrScript(180)
	text[2] = string_upper(ev_mural_text)
	moods = [neutral, neutral, neutral]
	speakers = [id, id, id]
}

// this removes the inscription < 10 check, so our inscription goes through here
// TARGET: LINENUMBER_REPLACE
// 177
if (true)