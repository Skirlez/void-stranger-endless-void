// Lightning Bolt!
function ev_run_tis_lightning_check() {
	if b_form != 10
		exit;
	if !variable_instance_exists(id, "swapper_disable_lightning")
		swapper_disable_lightning = false;
	
	if o_move_x == 0 and o_move_y == 0 {
		if point_distance(xprevious, yprevious, x, y) > 16 {
			if !swapper_disable_lightning {
				instance_create_layer(x, (y - 56), "Effects", agi("obj_judgment_flash"));
				var angle = point_direction(xprevious, yprevious, x, y)
				
				
				// -45 so the 4 directions we get correspond to right/up/left/right, rather
				// than upright/upleft/downleft/downright
				
				// + 90 after because VS directions start with up (0) for this object at least
				
				var dir = (angle - 45 + 90) div 90;
				// smoke cloud not created when o_move_x/y are over 16. so We gotta do it
				smokecloud = instance_create_layer(xprevious, yprevious, "Effects", agi("obj_smokecloud"))
				with (smokecloud)
					smoke_dir = dir;
			}
			else
				swapper_disable_lightning = false;
		}
	}
}