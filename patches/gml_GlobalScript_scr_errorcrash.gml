// TARGET: LINENUMBER
// 3
with (obj_player)
{
	lev_count = 1
	void_count = 9999
	var i = instance_create_depth(x, y, depth, obj_boulder)
	i.visible = false
	i.b_form = 1
}
exit