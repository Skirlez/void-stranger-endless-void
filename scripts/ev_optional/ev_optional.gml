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
		self.is_empty =method(self, function() {
			return true;
		});
	}
}


