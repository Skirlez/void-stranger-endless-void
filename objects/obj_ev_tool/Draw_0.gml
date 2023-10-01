draw_set_color(c_white)

if !(image_index == 0 || image_index == 1) {
	draw_self()
	exit
}

if image_index == global.selected_thing {
	ev_draw_selected_circle(x, y)
}
draw_self()