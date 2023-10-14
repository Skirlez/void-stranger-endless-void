
#macro compiled_for_merge false
if (!compiled_for_merge) {
	var ratio = display_get_height() / 144	
	surface_resize(application_surface, 224 * ratio, 144 * ratio)
}

window_set_cursor(cr_default)

global.editor_time = 0
global.mouse_pressed = false;
global.mouse_held = false;
#macro thing_eraser 1
#macro thing_placeable 2
#macro flag_unremovable 1
#macro flag_only_one 2
#macro flag_no_objects 4

global.tile_mode = true

global.editor_object = asset_get_index("obj_ev_editor");
global.display_object = asset_get_index("obj_ev_display");

global.selection_sprite = asset_get_index("spr_ev_selection")
global.white_floor_sprite = asset_get_index("spr_floor_white")

global.tileset_1 = asset_get_index("tile_bg_1")
global.tileset_edge = asset_get_index("tile_edges")

return_noone = function() {
	return noone;
}

empty_draw_function = function(tile_state, i, j) { };


default_draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
}

global.placeable_name_map = ds_map_create()


function editor_placeable(spr_ind, tile_id, flags = 0) constructor {
    self.spr_ind = spr_ind
	self.flags = flags
	self.draw_function = global.editor_object.default_draw_function
	self.zed_function = noone
	self.tile_id = tile_id;
	self.properties_generator = global.editor_object.return_noone
	global.placeable_name_map[? tile_id] = self;
} 

#macro pit_id "pt"
#macro glass_id "gl"
#macro mine_id "mn"
#macro default_tile_id "fl"
#macro floorswitch_id "fs"
#macro copyfloor_id "cr"
#macro exit_id "ex"
#macro white_id "wh"
#macro unremovable_id "ur"
#macro deathfloor_id "df"
#macro wall_id "wa"
#macro edge_id "ed"

#macro empty_id "em"
#macro player_id "pl"
#macro leech_id "cl"
#macro maggot_id "cc"
#macro gobbler_id "cs"
#macro bull_id "cg"
#macro hand_id "ch"
#macro mimic_id "cm"
#macro diamond_id "co"

floor_sprite = asset_get_index("spr_floor");

tile_pit = new editor_placeable(noone, pit_id)
tile_pit.draw_function = function(tile_state, i, j) {
	if (i == 0)
		return;
	var above_tile_state = global.level_tiles[i - 1][j];

	if above_tile_state.tile != tile_pit && above_tile_state.tile != tile_glass
			&& above_tile_state.tile != tile_edge
		draw_sprite(floor_sprite, 1, j * 16 + 8, i * 16 + 8)
}

tile_glass = new editor_placeable(asset_get_index("spr_glassfloor"), glass_id)
tile_glass.draw_function = function(tile_state, i, j) {
	tile_pit.draw_function(tile_state, i, j)
	default_draw_function(tile_state, i, j)
}
tile_mine = new editor_placeable(asset_get_index("spr_bombfloor"), mine_id)
tile_default = new editor_placeable(floor_sprite, default_tile_id)
tile_floorswitch = new editor_placeable(asset_get_index("spr_floorswitch"), floorswitch_id)
tile_floorswitch.draw_function = function(tile_state, i, j) {
	var ind = global.level_objects[i][j].tile == object_empty ? 0 : 1
	draw_sprite(tile_state.tile.spr_ind, ind, j * 16 + 8, i * 16 + 8)
}
tile_copyfloor = new editor_placeable(asset_get_index("spr_copyfloor"), copyfloor_id)


tile_exit = new editor_placeable(asset_get_index("spr_stairs"), exit_id)
tile_white = new editor_placeable(asset_get_index("spr_floor_white"), white_id)
tile_deathfloor = new editor_placeable(asset_get_index("spr_deathfloor"), deathfloor_id)
tile_wall = new editor_placeable(asset_get_index("spr_ev_wall"), wall_id, flag_no_objects)
tile_wall.properties_generator = function() {
	return { ind : 4 }
}

tile_edge = new editor_placeable(asset_get_index("spr_ev_edge"), edge_id, flag_no_objects)
tile_edge.properties_generator = function() {
	return { ind : 4 }	
}
tile_edge.draw_function = function(tile_state, i, j) {
	draw_set_color(c_white)
	draw_tile(global.tileset_edge, runtile_fetch_blob(j, i), 0, j * 16, i * 16)
}

tile_wall.draw_function = function(tile_state, i, j) {
	draw_set_color(c_white)
	draw_tile(global.tileset_1, tile_state.properties.ind, 0, j * 16, i * 16)	
}
tile_wall.zed_function = function() {
	new_window(10, 6, asset_get_index("obj_ev_wall_window"))	
	global.mouse_layer = 1
}



tile_unremovable = new editor_placeable(asset_get_index("spr_floor_white"), unremovable_id, flag_unremovable)
tile_unremovable.draw_function = empty_draw_function;

// even though it does nothing, we do need an object parallel to tile_empty as opposed to having it be noone
// as to not be inconsistent
object_empty = new editor_placeable(noone, empty_id)
object_empty.draw_function = empty_draw_function;

object_player = new editor_placeable(asset_get_index("spr_player_down"), player_id, flag_unremovable|flag_only_one)



object_leech = new editor_placeable(asset_get_index("spr_cl_right"), leech_id, 0)
object_leech.draw_function = function(tile_state, i, j) {
	var xscale = tile_state.properties.dir == true ? -1 : 1
	draw_sprite_ext(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8, xscale, 1, 0, c_white, draw_get_alpha())
}

maggot_sprite_down = asset_get_index("spr_cc_down");
maggot_sprite_up = asset_get_index("spr_cc_up");

object_maggot = new editor_placeable(maggot_sprite_down, maggot_id, 0)
object_maggot.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.properties.dir == true ? maggot_sprite_up : maggot_sprite_down, 0, j * 16 + 8, i * 16 + 8)
}

var directioned_zed_function = function(tile_state) {
	tile_state.properties.dir = !tile_state.properties.dir
}
var directioned_properties = function() {
	return { dir : false }
}

object_leech.zed_function = directioned_zed_function
object_leech.properties_generator = directioned_properties
object_maggot.zed_function = directioned_zed_function
object_maggot.properties_generator = directioned_properties

object_bull = new editor_placeable(asset_get_index("spr_cg_idle"), bull_id, 0)
object_gobbler = new editor_placeable(asset_get_index("spr_cs_right"), gobbler_id, 0)
object_hand = new editor_placeable(asset_get_index("spr_ch"), hand_id, 0)
object_mimic = new editor_placeable(asset_get_index("spr_cm_down"), mimic_id)
object_diamond = new editor_placeable(asset_get_index("spr_co_move"), diamond_id)



global.player_tiles = array_create(6)
global.player_objects = array_create(6)
for (var i = 0; i < 6; i++) {
	global.player_tiles[i] = i	
	global.player_objects[i] = i	
}


tiles_list = [tile_default, tile_glass, tile_mine, tile_floorswitch, tile_copyfloor, tile_exit, 
	tile_deathfloor, tile_white, tile_wall, tile_edge]
	
objects_list = [object_player, object_leech, object_maggot, object_bull, object_gobbler, object_hand, 
	object_mimic, object_diamond]

function reset_everything() {
	
	global.mouse_layer = 0
	global.selected_thing = -1 
	global.selected_placeable_num = 0
	
	global.level_tiles = array_create(9)
	for (var i = 0; i < array_length(global.level_tiles) - 1; i++)
		global.level_tiles[i] = array_create(14, new tile_with_state(tile_pit))	
	global.level_tiles[8] = array_create(14, new tile_with_state(tile_unremovable))	


	global.level_objects = array_create(9)
	for (var i = 0; i < array_length(global.level_objects); i++)
		global.level_objects[i] = array_create(14, new tile_with_state(object_empty))	

	global.level_objects[4][6] = new tile_with_state(object_player)
	global.level_tiles[2][6] = new tile_with_state(tile_exit)
	for (var i = 0; i < 3; i++) {
		for (var j = 0; j < 3; j++)
			global.level_tiles[3 + i][5 + j] = new tile_with_state(tile_default)
	}
	
	current_list = tiles_list;
	current_placeables = global.level_tiles
	current_empty_tile = tile_pit
}

reset_everything()



function switch_tile_modes() {
	global.tile_mode = !global.tile_mode;
	if (global.tile_mode) {
		current_list = tiles_list
		current_placeables = global.level_tiles
		current_empty_tile = tile_pit
	}
	else {
		current_list = objects_list
		current_placeables = global.level_objects
		current_empty_tile = object_empty
	}
}

global.erasing = -1;
erasing_surface = surface_create(224, 144)
global.goes_sound = asset_get_index("snd_ex_vacuumgoes")


global.play_transition = -1
global.max_play_transition = 20

history = []

function copy_array(arr) {
	arr[0] = arr[0]
	return arr;
}

function copy_tile_data(tiles) {
	for (var i = 0; i < array_length(tiles); i++) {
		tiles[i] = copy_array(tiles[i])
		for (var j = 0; j < array_length(tiles[i]); j++) {
			var tile_state = tiles[i][j]
			tiles[i][j] = new tile_with_state(tile_state.tile, struct_copy(tile_state.properties))
			
		}
	}
	
	return tiles;
}

// computers have infinite memory.
function add_undo() {
	
	array_push(history, copy_tile_data(global.level_tiles), copy_tile_data(global.level_objects))
	show_debug_message(array_length(history))
	if array_length(history) > 500
		array_delete(history, 0, 2)
}



function undo() {
	if array_length(history) != 0 {
		array_copy(global.level_objects, 0, array_pop(history), 0, array_length(global.level_objects))
		array_copy(global.level_tiles, 0, array_pop(history), 0, array_length(global.level_tiles))
		show_debug_message(array_length(history))
	}
	

}

