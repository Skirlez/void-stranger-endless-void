function pack_struct() constructor {
	name = ""
	description = ""
	burdens = [false, false, false, false, false]
	author = "Anonymous"
	author_brand = int64(0)
	
	levels = []
	
	// this is a map of level indices to an array of level indicies
	// each index of the array corresponds to an exit in the level
	level_destinations = ds_map_create()
	array_push(global.struct_map_cleaner, weak_ref_create(self), level_destinations)
	
	// This name will be used for when the file is saved
	save_name = generate_level_save_name()
	
	upload_date = "";
	last_edit_date = "";	
}

