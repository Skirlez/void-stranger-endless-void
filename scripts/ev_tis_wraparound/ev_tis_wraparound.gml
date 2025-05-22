
function ev_tis_wraparound() {
	if x + o_move_x < 0
		o_move_x += 224
	else if x + o_move_x > 224
		o_move_x -= 224
	if y + o_move_y < 0
		o_move_y += 144
	else if y + o_move_y > 144
		o_move_y -= 144
	
	// set the flag used for the lightning check so it'll trigger
	has_moved = true;
}