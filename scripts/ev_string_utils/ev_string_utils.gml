function is_digit(str) {
	return str != "" && str == string_digits(str)	
}
function string_is_uint(str) {
	return str != "" && string_length(str) == string_length(string_digits(str));
}

function string_is_int(str) {
	if str == ""
		return false;
	var char = string_char_at(str, 1);
	if char != "-" && char != "+" && !is_digit(char)
		return false;
	
	if char == "-" || char == "+"
		return string_length(str) - 1 == string_length(string_digits(str));
	return string_length(str) == string_length(string_digits(str));
}


function read_uint(str, i) {
	var num_string = "";
	var count = 0;
	while (i <= string_length(str)) {
		var read_char = string_char_at(str, i)
		if !is_digit(read_char)
			break;
		num_string += read_char
		i++;
		count++;
	}
	if (num_string == "")
		num_string = "0";
	var num = int64(num_string)
	return { number : num, offset : count };
}
function read_int(str, i) {
	var num_string = "";
	var count = 0;
	if i > string_length(str)
		return 0;
		
	var mult;
	if (string_char_at(str, i) == "-") {
		mult = -1;
		i++;
	}
	else
		mult = 1
		
	while (i <= string_length(str)) {
		var read_char = string_char_at(str, i)
		if !is_digit(read_char)
			break;
		num_string += read_char
		i++;
		count++;
	}
	if (num_string == "")
		num_string = "0";
	var num = int64(num_string) * mult
	return { number : num, offset : count };
}

function read_string_until(str, i, until_char) {
	var count = 0;
	while (i + count <= string_length(str)) {
		var read_char = string_char_at(str, i + count)
		if read_char == until_char
			break;
		count++;
	}
	var result = string_copy(str, i, count);
	return { substr : result, offset : count };
}
