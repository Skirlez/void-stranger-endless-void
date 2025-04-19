ev_set_play_variables()

current_node_state = noone;
function move_to_node_state(state) {
	current_node_state = state;
	room_restart();
}
function end_pack() {
	ev_leave_pack()	
}

function on_room_create() {
	if current_node_state == noone
		current_node_state = global.pack.starting_node_states[0];

	var potential_next_node = current_node_state.node.play_evaluate(current_node_state);
	if (potential_next_node != noone) {
		current_node_state = potential_next_node;
		room_restart();
	}
}