// TARGET: LINENUMBER
// 13
var boulder = instance_place(x, y, obj_boulder)
with (boulder)
{
	if ((b_form == 4) && variable_instance_exists(id, "editor_lamp"))
		exit;
}
