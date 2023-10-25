// TARGET: LINENUMBER
// 80
// kill player if cif statue is ontop of exit instead of reseting the playthrough
with (obj_player)
	state = 6
with (obj_exit) {
	var cif_flicker = instance_place(x, (y - 16), obj_boulder)
	with (cif_flicker)
	{
		if (b_form == 4)
		{
			flicker = 1
		}
	}
}
next_room = 1
exit