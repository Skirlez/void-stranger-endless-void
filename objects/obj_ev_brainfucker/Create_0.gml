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

#region Normal Walls
command_tiles[? 101] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 3,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 102] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 4,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 103] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 5,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 104] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 6,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 105] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 8,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 106] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 9,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 107] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 10,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 108] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 11,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 109] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 13,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 110] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 14,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 111] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 16,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
command_tiles[? 112] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 17,
	obj_layer: "",
	wall_type: wall_types.normal,
	edge_type: 0,
}
#endregion

#region EX Walls
command_tiles[? 113] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 3,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 114] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 4,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 115] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 5,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 116] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 6,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 117] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 8,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 118] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 9,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 119] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 10,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 120] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 11,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 121] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 13,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 122] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 14,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 123] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 16,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
command_tiles[? 124] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 17,
	obj_layer: "",
	wall_type: wall_types.ex,
	edge_type: 0,
}
#endregion

#region DIS Walls
command_tiles[? 125] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 3,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 126] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 4,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 127] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 5,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 128] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 6,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 129] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 8,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 130] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 9,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 131] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 10,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 132] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 11,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 133] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 13,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 134] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 14,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 135] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 16,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
command_tiles[? 136] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 17,
	obj_layer: "",
	wall_type: wall_types.dis,
	edge_type: 0,
}
#endregion

#region Mon Walls
command_tiles[? 137] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 3,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 138] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 4,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 139] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 5,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 140] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 6,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 141] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 8,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 142] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 9,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 143] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 10,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 144] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 11,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 145] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 13,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 146] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 14,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 147] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 16,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
command_tiles[? 148] = {
	is_solid : true,
	is_wall_tile : true,
	is_edge_tile : false,
	obj_name : "",
	tile_index : 17,
	obj_layer: "",
	wall_type: wall_types.mon,
	edge_type: 0,
}
#endregion

#region Normal Edges
command_tiles[? 201] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 2,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 202] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 3,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 203] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 4,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 204] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 5,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 205] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 6,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 206] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 7,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 207] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 8,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 208] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 9,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 209] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 10,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 210] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 11,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 211] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 12,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 212] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 13,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 213] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 14,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 214] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 15,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 215] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 16,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 216] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 17,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 217] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 18,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 218] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 19,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 219] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 20,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 220] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 21,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 221] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 22,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 222] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 23,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 223] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 24,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 224] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 25,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 225] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 26,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 226] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 27,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 227] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 28,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 228] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 29,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 229] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 30,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 230] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 31,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 231] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 32,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 232] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 33,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 233] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 34,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 234] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 35,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 235] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 36,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 236] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 37,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 237] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 38,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 238] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 39,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 239] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 40,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 240] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 41,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 241] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 42,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 242] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 43,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 243] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 44,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 244] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 45,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 245] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 46,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
command_tiles[? 246] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 47,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.normal,
}
#endregion

#region DIS Edges
command_tiles[? 247] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 2,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 248] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 3,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 249] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 4,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 250] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 5,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 251] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 6,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 252] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 7,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 253] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 8,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 254] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 9,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 255] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 10,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 256] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 11,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 257] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 12,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 258] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 13,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 259] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 14,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 260] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 15,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 261] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 16,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 262] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 17,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 263] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 18,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 264] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 19,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 265] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 20,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 266] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 21,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 267] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 22,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 268] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 23,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 269] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 24,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 270] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 25,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 271] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 26,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 272] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 27,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 273] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 28,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 274] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 29,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 275] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 30,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 276] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 31,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 277] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 32,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 278] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 33,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 279] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 34,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 280] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 35,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 281] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 36,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 282] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 37,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 283] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 38,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 284] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 39,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 285] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 40,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 286] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 41,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 287] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 42,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 288] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 43,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 289] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 44,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 290] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 45,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 291] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 46,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
command_tiles[? 292] = {
	is_solid : true,
	is_wall_tile : false,
	is_edge_tile : true,
	obj_name : "",
	tile_index : 47,
	obj_layer: "",
	wall_type: 0,
	edge_type: edge_types.dis,
}
#endregion

#endregion

//Command functions below
command_functions = ds_map_create();

command_functions[? 0] = function(memory, pointer){
	ev_notify("random tests lol")
}

command_functions[? 1] = function(memory, pointer){
	var params = get_command_parameters(memory, pointer, 3)
	ev_notify(string("Params: ({0}, {1}) {2}", params[0], params[1], params[2]))
}

command_functions[? 2] = function(memory, pointer){
	var test_a = instance_number(asset_get_index("obj_collision"))
	
	ev_notify(string("obj_collision count:  {0}", test_a))
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

