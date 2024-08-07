if (state == selector_states.displaying) {
	text = elements[selected_element];
}
else if state == selector_states.animating {
	if bounce_text == ""
		exit;
	text = bounce_text
}
else
	exit;
draw_set_font(global.ev_font)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

image_xscale = max(1, (string_width(text) + string_width(" |")) / 16)
x = xstart - image_xscale * 8 
y = ystart - image_yscale * 8 + y_bounce

draw_self()
draw_text_ext(x + 3, y + 1, text, 15, -1)
