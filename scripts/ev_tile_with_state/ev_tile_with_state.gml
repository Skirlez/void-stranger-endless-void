global.empty_struct = { }
function tile_with_state(tile, properties = tile.properties_generator()) constructor {
	self.tile = tile
	self.properties = properties
}

// https://forum.gamemaker.io/index.php?threads/copy-struct.93707/ 
// gamemaker is dumb for not having this
function struct_copy(SS) {
	var AR = variable_struct_get_names(SS);
	
	var SS_new = {};
	for (var i = 0; i < array_length(AR); i++;) {
		SS_new[$ AR[i]] = SS[$ AR[i]];
	}
	return(SS_new);
}

