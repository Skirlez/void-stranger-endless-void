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