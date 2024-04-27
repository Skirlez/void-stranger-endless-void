draw_self()
if (image_index == 0) {
	if (hour == 2 || hour == 3 || hour == 5 || hour == 7 || hour == 11 || hour == 13 || hour == 17 || hour == 23) {
		ev_draw_pixel(x + 96, y + 17, $808080)
	}
}
