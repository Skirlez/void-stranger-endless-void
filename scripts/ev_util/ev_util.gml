// I don't think i'll even use this for the project, i just wanted to see
// what a GML implementation could look like
function optional(val = pointer_invalid) constructor {
	self.val = val;

	if (val != pointer_invalid) {
		self.get = method(self, function() {
			return val;
		});
		self.get_or_else = method(self, function(else_var) {
			return val;
		});
		self.is_empty = method(self, function() {
			return false;
		});
	}
	else {
		self.get = method(self, function() {
			throw ("Called get() on an empty optional!")
		});
		self.get_or_else = method(self, function(else_var) {
			return else_var;
		});
		self.is_empty = method(self, function() {
			return true;
		});
	}
}

function copy_array(arr) {
	if (array_length(arr) == 0)
		return [];
	arr[0] = arr[0]
	return arr;
}


function get_all_files(dir, ext) {
	var files = [];
	var file_name = string_replace(file_find_first(dir + "*." + ext, 0), "." + ext, "");
	while (file_name != "") {
	    array_push(files, file_name);
	    file_name = string_replace(file_find_next(),  "." + ext, "");
	}
	file_find_close(); 
	return files;
}

function array_contains(arr, value) {
	for (var i = 0; i < array_length(arr); i++) {
		if (arr[@ i] == value)
			return true;
	}
	return false;
}


function string_split(str, delimiter) {
	var arr = []
	var build = ""
	for (var i = 1; i <= string_length(str); i++) {
		var c = string_char_at(str, i)
		if (c == delimiter) {
			array_push(arr, build);	
			build = ""
		}
		else
			build += c;	
	}
	if (build != "")
		array_push(arr, build);	
	return arr;
}
function string_split_buffer(str, delimiter) {
	var delimiter_ord = ord(delimiter)
	var size = string_length(str) + 1;

	var buf = buffer_create(size, buffer_fast, 1);

    buffer_write(buf, buffer_string, str);
	buffer_seek(buf, buffer_seek_start, 0);
	var arr = []
	var build = "";

	while (buffer_tell(buf) < size) {
		var c = buffer_read(buf, buffer_u8)
		if (c == delimiter_ord) {
			array_push(arr, build);	
			build = ""
		}
		else
			build += chr(c)
	}
	if (build != "")
		array_push(arr, build);	
	return arr;
}

