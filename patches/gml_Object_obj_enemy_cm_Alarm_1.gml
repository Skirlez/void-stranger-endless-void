// TARGET: LINENUMBER
// 24
if variable_instance_exists(id, "editor_type") {
	if editor_type == 0 {
		x_rotation = 0
		y_rotation = 0
	}
	else if editor_type == 1 {
		x_rotation = 1
		y_rotation = 1
	}
	else {
		x_rotation = 0
		y_rotation = 1
	}
}