for (var i = 0; i < array_length(nodes); i++) {

	with (nodes[i]) {
		if connecting_exit {
			ev_draw_pack_line(center_x, center_y, mouse_x, mouse_y)
		}
		for (var j = 0; j < array_length(exit_instances); j++) {
			var node = exit_instances[j];
		
			var other_center_x = node.center_x
			var other_center_y = node.center_y

			ev_draw_pack_line(center_x, center_y, other_center_x, other_center_y)
		}
	}
}