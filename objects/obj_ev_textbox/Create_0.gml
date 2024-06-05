// will return true if a character is from a-z, A-Z, is a digit, or is in the exceptions string.
function is_char_valid(char) {
	if char == ""
		return false
	if allow_alphanumeric && string_lettersdigits(char) != ""
		return true
	for (var i = 1; i <= string_length(exceptions); i++) {
		if char == string_char_at(exceptions, i)
			return true
	}
	return false
		
}
pos_x = xstart
pos_y = ystart


function try_inserting_character_at_cursor(char) {
	if !is_char_valid(char) || string_length(txt) >= char_limit
		return false;
	var newtxt = string_insert(char, txt, cursor_pos)
	if !(automatic_newline) {
		draw_set_font(global.ev_font)
		if string_width(newtxt) >= max_line_width
			return false;
	}
	txt = newtxt
	cursor_pos++
	return true;
}

function update_position() {
	x = pos_x - image_xscale * 8 
	y = pos_y - image_yscale * 8
}

function calculate_scale() {
	draw_set_font(global.ev_font)
	var filtered_text = filter_text(txt)
	xscale = max(base_scale_x, (string_width(filtered_text) + string_width(" |")) / 16)
	yscale = max(base_scale_y, string_count("\n", filtered_text) + 1)
}

#macro CHARACTER_THAT_CANT_BE_TYPED "\r"

function filter_text(txt, cursor = false) {
	if (string_length(txt) >= char_limit && !allow_deletion)
		cursor = false;
	draw_set_font(global.ev_font)
	var accum_width = 0
	var new_txt = txt
	var last_space_ind = 0

	if cursor && window.selected_element == id
		new_txt = string_insert(CHARACTER_THAT_CANT_BE_TYPED, new_txt, cursor_pos)

	var ind_in_original = 1;
	for (var i = 1; i <= string_length(new_txt); i++) {
		var char = string_char_at(new_txt, i)
		if char == "\n"	
			accum_width = 0
		else {
			if char == " "
				last_space_ind = i
			if (char != "/")
				accum_width += string_width(char)
			if accum_width > max_line_width {
				if (i - last_space_ind <= 16) {
					var ind_to_newline = last_space_ind
					new_txt = string_delete(new_txt, ind_to_newline, 1)	
					
				}
				else
					ind_to_newline = i

						
				new_txt = string_insert("\n", new_txt, ind_to_newline)
		
				var str = string_copy(new_txt, ind_to_newline, i - ind_to_newline + 1)
				accum_width = string_width(str)
			}
		}
		ind_in_original++;
	}
	if cursor && window.selected_element == id
		new_txt = string_replace_all(new_txt, CHARACTER_THAT_CANT_BE_TYPED, cursor_time % 60 < 30 ? "/" : " ")

	
	return new_txt
}



size_time = 0
cursor_pos = string_length(txt) + 1
calculate_scale()
image_xscale = base_scale_x
image_yscale = base_scale_y
update_position()

curve = animcurve_get_channel(ac_textbox_size, 0)

cursor_time = 0


text_surface = noone


if !allow_edit
	is_selectable = false

