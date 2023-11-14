function update_position() {
	x = xstart - image_xscale * 8 
	y = ystart - image_yscale * 8
}

function calculate_scale() {
	draw_set_font(global.ev_font)
	var filtered_text = filter_text(txt, last_text != txt)
	last_text = txt
	xscale = max(base_scale_x, (string_width(filtered_text) + string_width(" |")) / 16)

	yscale = string_count("\n", filtered_text) + 1
}

function filter_text(txt, debug = false) {
	draw_set_font(global.ev_font)
	var accum_width = 0
	var new_txt = txt
	var last_space_ind = 0
	for (var i = 1; i <= string_length(new_txt); i++) {
		var char = string_char_at(new_txt, i)
		if char == "\n"	
			accum_width = 0
		else {
			if char == " "
				last_space_ind = i

			accum_width += string_width(char)
			if debug {
				show_debug_message(accum_width)	
			}
			if accum_width > max_line_width {
				if debug {
					show_debug_message("balls")	
				}

				if (i - last_space_ind <= 16) {
					var ind_to_newline = last_space_ind
					new_txt = string_delete(new_txt, ind_to_newline, 1)
				}
				else
					ind_to_newline = i

				
					
				new_txt = string_insert("\n", new_txt, ind_to_newline)
			
				var str = string_copy(new_txt, ind_to_newline, i - ind_to_newline + 1)
				if debug {
					show_debug_message(str)
					show_debug_message(accum_width)
				}
				accum_width = string_width(str)
			}
		}
	}
	show_debug_message(string_width(new_txt))
	return new_txt
}
last_text = ""
calculate_scale()
update_position()

curve = animcurve_get_channel(ac_textbox_size, 0)
size_time = 0

text_surface = noone

