if (add_inst == noone || array_length(program) == 0)
	return;

value = execute(program, input_1, input_2)
if (value == expected_value) {
	instance_destroy(add_inst)
	instance_destroy(id)	
}
