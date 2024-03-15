// TARGET: LINENUMBER
// 3
with (obj_player)
{
	lev_count = 1
	void_count = 9999
	
	var lev = instance_create_depth(x, y, depth, obj_boulder)
	lev.visible = false
	lev.b_form = 1
	lev.x = -144
	lev.y = 0
}
exit