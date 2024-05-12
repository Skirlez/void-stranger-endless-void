if (!instance_exists(add_inst)|| array_length(program) == 0)
	return;

var input_1 = evaluate_input(input_1_str)
var input_2 = evaluate_input(input_2_str)
var destroy_value = evaluate_input(destroy_value_str)

value = execute(program, input_1, input_2, destroy_value)
if (value == destroy_value) {
	with (add_inst)
		event_perform(ev_other, ev_user1)
	instance_destroy(id)	
}
