
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
		var global_value = variable_global_get(input)	
		return int64_safe(global_value, 0)
	}
	return 0;
}




program = string_to_array(program_str)

function execute(program, input_1, input_2, destroy_value) {
	var memory = array_create(23, 0)
	memory[0] = input_1
	memory[1] = input_2
	
	var memory_length = array_length(memory);
	var program_length = array_length(program);
	var pointer = 0
	var i = 0;
	var count = 0;
	while (i < program_length) {
		var command = program[i];
		count++;
		if (count > 100000)
			return destroy_value;
		switch (command) {
			case "<": 
				var ret = get_bf_multiplier(program, i)
				ret.mult %= memory_length;
				pointer -= ret.mult;
				if (pointer < 0)
					pointer += program_length;
				i++;
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
					var stack = 0;
					while (j < program_length) {
						j++;
						if (program[j] == "[")
							stack++;
						else if (program[j] == "]") {
							if (stack == 0)
								break;
							stack--;
						}
					}
					if (j == program_length)
						return; // TODO
					i = j + 1;
				}
				break;
			case "]":
				if (memory[pointer] != 0) {
					var j = i;
					var stack = 0;
					while (j > 0) {
						j--;
						if (program[j] == "]")
							stack++;
						else if (program[j] == "[") {
							if (stack == 0)
								break;
							stack--;
						}
					}
					if (j == program_length)
						return; // TODO
					i = j + 1;
				}

				break;
			case ".":
				return (memory[pointer])
			default:
				i++;
		}
	}
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

