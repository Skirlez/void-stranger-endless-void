command_functions = ds_map_create();

command_functions[? 0] = function(memory, pointer){
	ev_notify("command 0 successful")
}

command_functions[? 1] = function(memory, pointer){
	ev_notify("command 1 successful")
}

command_functions[? 2] = function(memory, pointer){
	ev_notify("command 2 successful")
}

command_functions[? 3] = function(memory, pointer){
	var params = get_command_parameters(memory, pointer, 2)
	ev_notify("command 3's parameters are " + string(params[0]) + ", " + string(params[1]))
}


function get_command_parameters(memory, pointer, param_count){
	var params = array_create(param_count)
	
	var p = pointer
	for(var i = 0; i < param_count; i++){
		p -= 1
		if (p < 0){
			p += array_length(memory)
		}
		params[i] = memory[p]
	}
	
	return params;
}

function string_to_array(str) {
	var arr = array_create(string_length(str))
	for (var i = 0; i < array_length(arr); i++) {
		arr[i] = string_char_at(str, i + 1);	
	}
	return arr;
}

function evaluate_input(input) {
	if string_is_int(input)
		return int64_safe(input, 0)
	if variable_global_exists(input) {
		static input_blacklist = 
			["playtesting", "tile_mode", "is_steam_deck", "control_type", "s_g_res",
				"online_mode"]
		for (var i = 0; i < array_length(input_blacklist); i++) {
			if (input_blacklist[i] == input)
				return int64(0);
		}
		var global_value = variable_global_get(input)	
		return int64_safe(global_value, 0)
	}
	return int64(0);
}


program = string_to_array(program_str)

function execute(program, input_1, input_2, destroy_value) {
	var memory = array_create(23)
	var memory_length = array_length(memory);
	
	
	memory[0] = input_1
	memory[1] = input_2
	for (var i = 2; i < memory_length; i++)
		memory[i] = int64(0);	
	
	
	
	var program_length = array_length(program);
	var pointer = 0
	var i = 0;
	var count = 0;
	while (i < program_length) {
		var command = program[i];
		count++;
		if (count > 100000) {
			ev_notify("BF code ran for too long!")
			return destroy_value;
		}
		switch (command) {
			case "<": 
				var ret = get_bf_multiplier(program, i)
				ret.mult %= memory_length;
				pointer -= ret.mult;
				if (pointer < 0)
					pointer += memory_length;
				i += ret.offset + 1;
				break;
			case ">":
				var ret = get_bf_multiplier(program, i)
				pointer = (pointer + ret.mult) % memory_length;
				i += ret.offset + 1;
				break;
			case "+":
				var ret = get_bf_multiplier(program, i)
				memory[pointer] += ret.mult;
				i += ret.offset + 1;
				break;
			case "-":
				var ret = get_bf_multiplier(program, i)
				memory[pointer] -= ret.mult;
				i += ret.offset + 1;
				break;
			case "[": 
				if (memory[pointer] == 0) {
					var j = i;
					var stack = 1;
					while (j < program_length) {
						j++;
						if (program[j] == "[")
							stack++;
						else if (program[j] == "]") {
							stack--;
							if (stack == 0)
								break;
						}
					}
					if (stack != 0)
						return destroy_value;
					i = j + 1;
				}
				else
					i++;
				break;
			case "]":
				if (memory[pointer] != 0) {
					var j = i;
					var stack = 1;
					while (j > 0) {
						j--;
						if (program[j] == "]")
							stack++;
						else if (program[j] == "[") {
							stack--;
							if (stack == 0)
								break;
						}
					}
					if (stack != 0)
						return destroy_value;
					i = j + 1;
				}
				else
					i++;
				break;
			case ".":
				return (memory[pointer])
			case "?":
				memory[pointer] = sign(memory[pointer])
				i++;
				break;
			case "#":
				if ds_exists(command_functions, ds_type_map){
					var s = memory[pointer]
					if ds_map_exists(command_functions, s) {
						command_functions[? s](memory, pointer)
					}
				}
				i++;
				break;
			default:
				i++;
		}
	}
	return memory[pointer];
}


// get the multiplier following this character, if it exists.
function get_bf_multiplier(program, i) {
	var num_string = "";
	i++;
	var count = 0;
	while (i < array_length(program)) {
		var read_char = program[i]
		if !is_digit(read_char)
			break;
		num_string += read_char
		i++;
		count++;
	}
	if (num_string == "")
		num_string = "1"
	var num = int64(num_string)
	return { mult : num, offset : count };
}

