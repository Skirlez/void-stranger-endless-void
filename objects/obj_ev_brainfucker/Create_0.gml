//Data for command functions below
#region command_tiles

command_tiles = ds_map_create();
// 0 will be the special case for the pit
#region Tiles
command_tiles[? 1] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_floor",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 2] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_glassfloor",
	tile_index : 0,
	obj_layer: "Floor_INS",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 3] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_bombfloor",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 4] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_explofloor",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 5] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_floorswitch",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 6] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_copyfloor",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 7] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_exit",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 8] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_deathfloor",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
//TODO:  The black floor tiles are super weird, my brain is dead
command_tiles[? 9] = {
	is_solid : false,
	is_voidrod_pickupable : false,  //Also does nothing atm
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_floor",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "spr_ev_blackfloor",  //Actually does nothing currently
}
//TODO: This should be the HUD tile
command_tiles[? 10] = {
	is_solid : false,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
command_tiles[? 11] = {
	is_solid : true,
	is_voidrod_pickupable : true,
	is_wall_tile : false,
	is_edge_tile : false,
	obj_name : "obj_chest_small",
	tile_index : 0,
	obj_layer: "Floor",
	wall_type: 0,
	edge_type: 0,
	custom_sprite: "",
}
#endregion

var wall_tile_indices = [3, 4, 5, 6, 8, 9, 10, 11, 13, 14, 16, 17]
#region Walls
// Normal Walls
for (var i = 0; i < array_length(wall_tile_indices); i++) {
  command_tiles[? 101 + i] = {
	  is_solid : true,
	  is_wall_tile : true,
	  is_edge_tile : false,
	  obj_name : "",
	  tile_index : wall_tile_indices[i],
	  obj_layer: "",
	  wall_type: wall_types.normal,
	  edge_type: 0,
  }
}
// EX Walls
for (var i = 0; i < array_length(wall_tile_indices); i++) {
  command_tiles[? 113 + i] = {
	  is_solid : true,
	  is_wall_tile : true,
	  is_edge_tile : false,
	  obj_name : "",
	  tile_index : wall_tile_indices[i],
	  obj_layer: "",
	  wall_type: wall_types.ex,
	  edge_type: 0,
  }
}
// DIS Walls
for (var i = 0; i < array_length(wall_tile_indices); i++) {
  command_tiles[? 125 + i] = {
	  is_solid : true,
	  is_wall_tile : true,
	  is_edge_tile : false,
	  obj_name : "",
	  tile_index : wall_tile_indices[i],
	  obj_layer: "",
	  wall_type: wall_types.dis,
	  edge_type: 0,
  }
}
// Mon Walls
for (var i = 0; i < array_length(wall_tile_indices); i++) {
  command_tiles[? 137 + i] = {
	  is_solid : true,
	  is_wall_tile : true,
	  is_edge_tile : false,
	  obj_name : "",
	  tile_index : wall_tile_indices[i],
	  obj_layer: "",
	  wall_type: wall_types.mon,
	  edge_type: 0,
  }
}
#endregion

#region Edges
//Normal Edges
for (var i = 0; i < 46; i++) {
	command_tiles[? 201 + i] = {
		is_solid : false,
		is_wall_tile : false,
		is_edge_tile : true,
		obj_name : "",
		tile_index : i + 2,
		obj_layer: "",
		wall_type: 0,
		edge_type: edge_types.normal,
	}
}
//DIS Edges
for (var i = 0; i < 46; i++) {
	command_tiles[? 247 + i] = {
		is_solid : false,
		is_wall_tile : false,
		is_edge_tile : true,
		obj_name : "",
		tile_index : i + 2,
		obj_layer: "",
		wall_type: 0,
		edge_type: edge_types.dis,
	}
}
#endregion

#endregion

//Command functions below
command_functions = ds_map_create();

command_functions[? 0] = function(memory, pointer){
	ev_notify(string("Add Coords: ({0}, {1})", global.add_current_x, global.add_current_y))
}

command_functions[? 1] = function(memory, pointer){
	var params = get_command_parameters(memory, pointer, 3)
	ev_notify(string("Params: ({0}, {1}) {2}", params[0], params[1], params[2]))
}

//move(direction)
command_functions[? 2] = function(memory, pointer){
	var params = get_command_parameters(memory, pointer, 1)
	var p_move_x = 0
	var p_move_y = 0
	switch params[0]{
		case 0: //Right
			p_move_x = 16
			break
		case 1: //Up
			p_move_y = -16
			break
		case 2: //Left
			p_move_x = -16
			break
		case 3: //Down
			p_move_y = 16
			break
	}
	// Invalid direction?  Exit.
	if p_move_x == 0 && p_move_y == 0{
		return
	}
	
	with(add_inst){
		if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_collision"))
		{
			//Collided, don't move
			//Removed the sound that played here cause it was really bad when it spammed....
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_boulder"))
		{
			var b_push_x = p_move_x
			var b_push_y = p_move_y
			with (instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_boulder")))
			{
				if (shaken == false){
					o_move_x += b_push_x
					o_move_y += b_push_y
					o_state = (10 << 0)
				}
			}
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_demonlords_statue"))
		{
			with (instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_demonlords_statue")))
				o_state = (10 << 0)
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_tail_void_hori"))
		{
			with (instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_tail_void_hori")))
				o_state = (10 << 0)
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_tail_void_vert"))
		{
			with (instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_tail_void_vert")))
				o_state = (10 << 0)
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_talk"))
		{
			var n_push_x = p_move_x
			var n_push_y = p_move_y
			with (instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_talk")))
			{
				if (shaken == false){
					o_move_x += n_push_x
					o_move_y += n_push_y
					o_state = (10 << 0)
				}
			}
			with (instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_rest")))
				counter = 0
		}
		else if (place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_enemy_parent")) || place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_npc_parent")))
		{
			x += p_move_x
			y += p_move_y
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_pit"))
		{
			x += p_move_x
			y += p_move_y
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_player"))
		{
			//tl;dr, mimics pushing boulders into the player just causes a collision
			//gonna use that as the behaviour here I guess....
		}
		else if place_meeting((x + p_move_x), (y + p_move_y), asset_get_index("obj_fakewall"))
		{
			//Collide with the fake hologram rockeggs, similar to other boulders/statues
		}
		else
		{
			var _explofloor_stepped = instance_place((x + p_move_x), (y + p_move_y), asset_get_index("obj_explofloor"))
			if (_explofloor_stepped != noone)
			{
				with (_explofloor_stepped)
					self.fnc_explofloor__check_if_stepped_on()
			}
			x += p_move_x
			y += p_move_y
		}
		//Update global variables for the statue's location
		global.add_current_x = floor(x/16)
		global.add_current_y = floor(y/16)
	}
	
}

//set_tile(x, y, index)
//Sets a tile at a given position to one from an custom array at a given index
command_functions[? 3] = function(memory, pointer){
	var params = get_command_parameters(memory, pointer, 3)
	var cell_x = params[0]
	var cell_y = params[1]
	var tile_index = params[2]
	
	//Out of range of level, exit early
	//TODO: Determine if this should do something like a DIS error or an ev_notify
	if (cell_x < 0 || cell_x > 13 || cell_y < 0 || cell_y > 8){
		return
	}
	
	//tile_index not found
	if !ds_map_exists(command_tiles, tile_index) {
		return
	}
	
	var tile_x = cell_x * 16 + 8
	var tile_y = cell_y * 16 + 8
	
	//Destroy any floor instances already there
	var _list = ds_list_create();
	var _num = instance_position_list(tile_x, tile_y, all, _list, false);
	if _num > 0 {
		for (var i = 0; i < _num; ++i;) {
			if (_list[| i].layer == layer_get_id("Floor")
			 || _list[| i].layer == layer_get_id("Floor_INS")){
				instance_destroy(_list[| i]);
			}
		}
	}
	ds_list_destroy(_list);
	
	//Destroy any wall tiles already there
	//layers and layers and layers...
	for (var i = 0; i < array_length(global.wall_tilemaps); ++i;) {
		var map_id = global.wall_tilemaps[i]
		var data = tilemap_get(map_id, cell_x, cell_y)
		data = tile_set_empty(data)
		tilemap_set(map_id, data, cell_x, cell_y)
	}
	for (var i = 0; i < array_length(global.edge_tilemaps); ++i;) {
		var map_id = global.edge_tilemaps[i]
		var data = tilemap_get(map_id, cell_x, cell_y)
		data = tile_set_empty(data)
		tilemap_set(map_id, data, cell_x, cell_y)
	}
	
	//Destroy wall collision
	var collision = instance_position(tile_x, tile_y, asset_get_index("obj_collision"))
	with (instance_position(tile_x, tile_y, asset_get_index("obj_collision")))
		instance_destroy(collision)
	
	//Finally set tile
	if tile_index == 0 {
		// Pits are a special case, since they don't fit cleanly into the whole command_tiles thing
		instance_create_layer(tile_x, tile_y, "Pit", asset_get_index("obj_pit"))
		return
	}
	else if command_tiles[? tile_index].is_wall_tile {
		var map_id = global.wall_tilemaps[command_tiles[? tile_index].wall_type]
		var data = tilemap_get(map_id, cell_x, cell_y)
		data = tile_set_index(data, command_tiles[? tile_index].tile_index)
		tilemap_set(map_id, data, cell_x, cell_y)
	}
	else if command_tiles[? tile_index].is_edge_tile {
		var map_id = global.edge_tilemaps[command_tiles[? tile_index].edge_type]
		var data = tilemap_get(map_id, cell_x, cell_y)
		data = tile_set_index(data, command_tiles[? tile_index].tile_index)
		tilemap_set(map_id, data, cell_x, cell_y)
	}
	else{
		instance_create_layer(tile_x, tile_y, command_tiles[? tile_index].obj_layer, asset_get_index(command_tiles[? tile_index].obj_name))
	}
	
	//Clear pit tiles
	var pit_tile = instance_position(tile_x, tile_y, asset_get_index("obj_pit"))
	with (instance_position(tile_x, tile_y, asset_get_index("obj_pit")))
		instance_destroy(pit_tile)
	
	//Set solid collision if applicable
	if command_tiles[? tile_index].is_solid{
		instance_create_layer(tile_x, tile_y, "Instances", asset_get_index("obj_collision"))
	}
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

