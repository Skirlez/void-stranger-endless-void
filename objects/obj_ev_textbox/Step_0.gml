event_inherited()
if !allow_edit {
	calculate_scale()
	image_xscale = xscale
	image_yscale = yscale
	update_position()
	exit	
}

if window != -1 && window.selected_element == id {
	cursor_time++
	if size_time < 100
		size_time += 10

	var dir = ev_get_horizontal_pressed()
	if dir != 0
		cursor_time = 0
	cursor_pos = clamp(cursor_pos + dir, 1, string_length(txt) + 1)
	if ev_is_mouse_on_me() && ev_mouse_pressed() && !first_expansion_frame {
		
		var line_height = 16;
		var line = (mouse_y - y) div line_height;
		
		// idea is to find where the line starts, then accumulate the widths of the character
		// until our x value is over the mouse position's x, and then place the cursor there.
		// we need to get the text as it is displayed on screen, and that is what filter_text()
		// gives. but we need to keep track of which newlines are real and which are "fake"/added by
		// having too long of a line, hence this fake newline char
		var fake_newline_char = "\r"
		var filtered_text = filter_text(txt, false, fake_newline_char);
		
		var current_line = 0;
		var current_pos = 1;
		var pos_offset = 0;
		while (current_pos <= string_length(filtered_text) && current_line < line) {
			var char = string_char_at(filtered_text, current_pos);
			if (char == "\n")
				current_line++;
			else if (char == fake_newline_char) {
				// not a real character, so keep track via pos_offset
				pos_offset++;
				current_line++;
			}
			current_pos++;
			
		}
		if current_line == line {
			draw_set_font(global.ev_font);
			var current_x_pos = x + 8;
			while (current_x_pos < mouse_x 
					&& current_pos <= string_length(filtered_text)) {
				var char = string_char_at(filtered_text, current_pos);
				if (char == "\n" || char == fake_newline_char) {
					break;	
				}
				current_x_pos += string_width(char);
				current_pos++;
			}
			cursor_pos = current_pos - pos_offset;
		}
	}
	
	
	var old = txt;
	switch (keyboard_lastkey) {
		case vk_delete:
			if (allow_deletion)
				txt = string_delete(txt, cursor_pos, 1)
			break;
		case vk_backspace:
			if (allow_deletion) {
				txt = string_delete(txt, cursor_pos - 1, 1)
				cursor_pos--
			}
			break;
		case vk_enter:
			// alowing keyboard_lastchar inserts an Evil and Fucked Up newline character that is not \n
			// so we do this instead.
			if allow_newlines && string_length(txt) < char_limit {
				txt = string_insert("\n", txt, cursor_pos)
				cursor_pos++
			}

			break;
		case vk_escape:
			window.selected_element = noone
			break;
		case ord("C"):
			if (keyboard_check(vk_control)) {
				clipboard_set_text(txt)
				ev_notify("Copied to clipboard!")
				break;
			}
		case ord("V"):
			if (keyboard_check(vk_control)) {
				var str = clipboard_get_text()
				for (var i = 1; i <= string_length(str); i++) {
					var char = string_char_at(str, i);	
					try_inserting_character_at_cursor(char)
				}
				break;
			}
		default:
			try_inserting_character_at_cursor(keyboard_lastchar)
			break;
	}
	if (old != txt && change_func != noone) {
		change_func();
	}
	keyboard_lastchar = ""
	keyboard_lastkey = 0
	first_expansion_frame = false;
}
else {
	cursor_time = 30
	cursor_pos = string_length(txt) + 1
	if size_time > 0 {
		size_time -= 10
		
		if size_time <= 0 {
			var should_make_closing_sound = (xscale != base_scale_x || yscale != base_scale_y 
				|| (opened_x != xstart) || (opened_y != ystart))
				
			if (should_make_closing_sound)
				audio_play_sound(asset_get_index("snd_ev_textbox_click"), 10, false, 1, 0, 1.2)	
		}
	}
}
calculate_scale()

var t = animcurve_channel_evaluate(curve, size_time / 100)
image_xscale = lerp(base_scale_x, xscale, t)
image_yscale = lerp(base_scale_y, yscale, t)
pos_x = lerp(xstart, opened_x, t)
pos_y = lerp(ystart, opened_y, t)
update_position()
