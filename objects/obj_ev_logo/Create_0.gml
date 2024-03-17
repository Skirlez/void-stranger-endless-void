image_speed = 0
var date = date_current_datetime()
var hour = date_get_hour(date)
show_debug_message(hour)
if (hour % 2 == 0)
	image_index = 1;