// I don't think i'll even use this for the project, i just wanted to see
// what a GML implementation could look like
function optional(val = EMPTY) constructor {
	self.val = val;

	static _get = function() {
		if (val == EMPTY)
			throw ("Called get() on an empty optional!")
		return val;
	}
	self.get = method(self, _get);
	
	
	static _get_or_else = function(else_var) {
		return (val != EMPTY) ? val : else_var
	}
	self.get_or_else = method(self, _get_or_else);
	
	
	static _is_empty = function() {
		return val != EMPTY;
	}
	self.is_empty = method(self, _is_empty);
	
	
	static EMPTY = pointer_invalid
}


