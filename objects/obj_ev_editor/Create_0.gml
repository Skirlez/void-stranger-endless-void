
#macro compiled_for_merge false
if (!compiled_for_merge) {
	var ratio = display_get_height() / 144	
	surface_resize(application_surface, 224 * ratio, 144 * ratio)
	audio_group_load(VoidStrangerAudio)
}

window_set_cursor(cr_default)

global.editor_time = 0
global.mouse_pressed = false;
global.mouse_held = false;
#macro thing_plucker 0
#macro thing_eraser 1
#macro thing_placeable 2
#macro thing_multiplaceable 3

#macro flag_unremovable 1
#macro flag_only_one 2
#macro flag_unplaceable 4
#macro flag_no_objects 8

global.editor_room = asset_get_index("rm_ev_editor");
global.editor_object = asset_get_index("obj_ev_editor");
global.display_object = asset_get_index("obj_ev_display");

global.selection_sprite = asset_get_index("spr_ev_selection")
global.white_floor_sprite = asset_get_index("spr_floor_white")

global.tileset_1 = asset_get_index("tile_bg_1")
global.tileset_edge = asset_get_index("tile_edges")

global.select_sound = asset_get_index("snd_ev_select")

return_noone = function() {
	return noone;
}

empty_function = function(tile_state, i, j) { };

return_tile_state_function = function(tile_state) { 
	return tile_state 
};

default_draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
}

global.placeable_name_map = ds_map_create()


function editor_placeable(spr_ind, tile_id, obj_name, flags = 0) constructor {
    self.spr_ind = spr_ind
	self.obj_name = obj_name
	self.flags = flags
	self.draw_function = global.editor_object.default_draw_function
	self.place_function = global.editor_object.return_tile_state_function
	self.zed_function = noone
	self.tile_id = tile_id;
	self.properties_generator = global.editor_object.return_noone
	global.placeable_name_map[? tile_id] = self;
} 




#macro pit_id "pt"
#macro pit_obj "obj_pit"

#macro glass_id "gl"
#macro glass_obj "obj_glassfloor"


#macro bomb_id "mn"
#macro bomb_obj "obj_bombfloor"

#macro default_tile_id "fl"
#macro default_tile_obj "obj_floor"

#macro floorswitch_id "fs"
#macro floorswitch_obj "obj_floorswitch"

#macro copyfloor_id "cr"
#macro copyfloor_obj "obj_copyfloor"

#macro exit_id "ex"
#macro exit_obj "obj_exit"

#macro white_id "wh"
#macro white_obj "obj_floor_blank"

#macro unremovable_id "ur"
#macro unremovable_obj ""

#macro deathfloor_id "df"
#macro deathfloor_obj "obj_deathfloor"

#macro no_obj ""

#macro wall_id "wa"
#macro edge_id "ed"
#macro empty_id "em"

#macro player_id "pl"
#macro player_obj "obj_spawnpoint"


#macro leech_id "cl"
#macro leech_obj "obj_enemy_cl"

#macro maggot_id "cc"
#macro maggot_obj "obj_enemy_cc"

#macro gobbler_id "cs"
#macro gobbler_obj "obj_enemy_cs"

#macro bull_id "cg"
#macro bull_obj "obj_enemy_cg"


#macro hand_id "ch"
#macro hand_obj "obj_enemy_ch"

#macro mimic_id "cm"
#macro mimic_obj "obj_enemy_cm"

#macro diamond_id "co"
#macro diamond_obj "obj_enemy_co"

#macro spider_id "ct"
#macro spider_obj "obj_enemy_ct"

#macro egg_id "eg"

#macro egg_statue_obj "obj_boulder"

#macro cif_id "cf"
#macro tan_id "tn"
#macro mon_id "mo"
#macro lev_id "lv"
#macro eus_id "eu"
#macro bee_id "be"
#macro gor_id "go"
#macro add_id "ad"

#macro hologram_id "ho"
#macro hologram_obj "obj_fakewall"

floor_sprite = asset_get_index("spr_floor");

tile_pit = new editor_placeable(noone, pit_id, pit_obj, flag_unplaceable)
tile_pit.draw_function = function(tile_state, i, j) {
	if (i == 0)
		return;
	var above_tile_state = global.level_tiles[i - 1][j];

	if above_tile_state.tile != tile_pit && above_tile_state.tile != tile_glass
			&& above_tile_state.tile != tile_edge
		draw_sprite(floor_sprite, 1, j * 16 + 8, i * 16 + 8)
}

tile_glass = new editor_placeable(asset_get_index("spr_glassfloor"), glass_id, glass_obj)
tile_glass.draw_function = function(tile_state, i, j) {
	tile_pit.draw_function(tile_state, i, j)
	default_draw_function(tile_state, i, j)
}
tile_bomb = new editor_placeable(asset_get_index("spr_bombfloor"), bomb_id, bomb_obj)
tile_default = new editor_placeable(floor_sprite, default_tile_id, default_tile_obj)
tile_floorswitch = new editor_placeable(asset_get_index("spr_floorswitch"), floorswitch_id, floorswitch_obj)
tile_floorswitch.draw_function = function(tile_state, i, j) {
	var ind = global.level_objects[i][j].tile == object_empty ? 0 : 1
	draw_sprite(tile_state.tile.spr_ind, ind, j * 16 + 8, i * 16 + 8)
}
tile_copyfloor = new editor_placeable(asset_get_index("spr_copyfloor"), copyfloor_id, copyfloor_obj)


tile_exit = new editor_placeable(asset_get_index("spr_stairs"), exit_id, exit_obj)
tile_white = new editor_placeable(asset_get_index("spr_floor_white"), white_id, white_obj)
tile_deathfloor = new editor_placeable(asset_get_index("spr_deathfloor"), deathfloor_id, deathfloor_obj)
tile_wall = new editor_placeable(asset_get_index("spr_ev_wall"), wall_id, no_obj, flag_no_objects)
tile_wall.properties_generator = function() {
	return { ind : 4 }
}

tile_edge = new editor_placeable(asset_get_index("spr_ev_edge"), edge_id, no_obj, flag_no_objects)
tile_edge.properties_generator = function() {
	return { ind : 4 }	
}
tile_edge.draw_function = function(tile_state, i, j, preview) {
	draw_set_color(c_white)
	draw_tile(global.tileset_edge, preview ? runtile_fetch_blob(j, i) : tile_state.properties.ind, 0, j * 16, i * 16)
}
tile_edge.place_function = function(tile_state, i, j) {
	tile_state.properties.ind = runtile_fetch_blob(j, i);
	show_debug_message(tile_state.properties.ind)
	return tile_state;
}

tile_wall.draw_function = function(tile_state, i, j) {
	draw_set_color(c_white)
	draw_tile(global.tileset_1, tile_state.properties.ind, 0, j * 16, i * 16)	
}
tile_wall.zed_function = function() {
	new_window(10, 4.5, asset_get_index("obj_ev_wall_window"))	
	global.mouse_layer = 1
}



tile_unremovable = new editor_placeable(asset_get_index("spr_floor_white"), unremovable_id, unremovable_obj, flag_unremovable|flag_unplaceable)
tile_unremovable.draw_function = empty_function;

// even though it does nothing, we do need an object parallel to tile_empty as opposed to having it be noone
// as to not be inconsistent
object_empty = new editor_placeable(noone, empty_id, no_obj, flag_unplaceable)
object_empty.draw_function = empty_function;


sweat_sprite = asset_get_index("spr_sweat")
object_player = new editor_placeable(asset_get_index("spr_player_down"), player_id, player_obj, flag_unremovable|flag_only_one)
object_player.draw_function = function(tile_state, i, j, preview) {
	if (preview && global.level_tiles[i][j].tile == tile_pit) {
		draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8 + dsin(global.editor_time * 24), i * 16 + 8)		
		draw_sprite(sweat_sprite, global.editor_time / 5, j * 16 + 16, i * 16)
		return;
	}
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
}


object_leech = new editor_placeable(asset_get_index("spr_cl_right"), leech_id, leech_obj)
object_leech.draw_function = function(tile_state, i, j) {
	var xscale = tile_state.properties.dir == true ? -1 : 1
	draw_sprite_ext(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8, xscale, 1, 0, c_white, draw_get_alpha())
}

maggot_sprite_down = asset_get_index("spr_cc_down");
maggot_sprite_up = asset_get_index("spr_cc_up");

object_maggot = new editor_placeable(maggot_sprite_down, maggot_id, maggot_obj, 0)
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

object_bull = new editor_placeable(asset_get_index("spr_cg_idle"), bull_id, bull_obj)
object_gobbler = new editor_placeable(asset_get_index("spr_cs_right"), gobbler_id, gobbler_obj)
object_hand = new editor_placeable(asset_get_index("spr_ch"), hand_id, hand_obj)
object_mimic = new editor_placeable(asset_get_index("spr_cm_down"), mimic_id, mimic_obj)
object_mimic.properties_generator = function() {
	return { typ : 0 } 	
}
object_mimic.zed_function = function(tile_state) {
	tile_state.properties.typ++;
	if tile_state.properties.typ > 2
		tile_state.properties.typ = 0
}

mimic_sprite_arr = [asset_get_index("spr_cm_down"), asset_get_index("spr_cm_up1"), asset_get_index("spr_cm_up2")]
object_mimic.draw_function = function(tile_state, i, j) {
	draw_sprite(mimic_sprite_arr[tile_state.properties.typ], 0, j * 16 + 8, i * 16 + 8)
}

object_diamond = new editor_placeable(asset_get_index("spr_co_idle"), diamond_id, diamond_obj)

object_spider = new editor_placeable(asset_get_index("spr_ct_right"), spider_id, spider_obj)

object_egg = new editor_placeable(asset_get_index("spr_boulder"), egg_id, egg_statue_obj)
object_egg.properties_generator = function() {
	return { txt : "" }	
}
object_egg.zed_function = function(tile_state) {
	new_window(10, 6, asset_get_index("obj_ev_egg_window"), 
	{ egg_properties : tile_state.properties })	
	global.mouse_layer = 1
}
cif_sprite = asset_get_index("spr_atoner")
lamp_sprite = asset_get_index("spr_lamp")

object_cif = new editor_placeable(cif_sprite, cif_id, egg_statue_obj)
object_cif.properties_generator = function() {
	return { lmp : false }
}
object_cif.zed_function = function(tile_state) {
	tile_state.properties.lmp = !tile_state.properties.lmp
}
object_cif.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.properties.lmp ? lamp_sprite : cif_sprite, 0, j * 16 + 8, i * 16 + 8)
}
object_add = new editor_placeable(asset_get_index("spr_voider"), add_id, egg_statue_obj)
object_mon = new editor_placeable(asset_get_index("spr_greeder"), mon_id, egg_statue_obj)
object_tan = new editor_placeable(asset_get_index("spr_killer"), tan_id, egg_statue_obj)
object_lev = new editor_placeable(asset_get_index("spr_watcher"), lev_id, egg_statue_obj)
object_eus = new editor_placeable(asset_get_index("spr_lover"), eus_id, egg_statue_obj)
object_bee = new editor_placeable(asset_get_index("spr_smiler"), bee_id, egg_statue_obj)
object_gor = new editor_placeable(asset_get_index("spr_slower"), gor_id, egg_statue_obj)


// we create the hologram sprite in real time!
var hologram_surf = surface_create(16, 16)
surface_set_target(hologram_surf)
draw_sprite(asset_get_index("spr_boulder"), 0, 8, 8)
draw_sprite(asset_get_index("spr_question_black"), 8, 8, 8)
var hologram_sprite = sprite_create_from_surface(hologram_surf, 0, 0, 16, 16, false, false, 8, 8)
surface_reset_target()
surface_free(hologram_surf)
object_hologram = new editor_placeable(hologram_sprite, hologram_id, hologram_obj)

global.player_tiles = array_create(7)
global.player_objects = array_create(7)
for (var i = 0; i < 7; i++) {
	global.player_tiles[i] = i	
	global.player_objects[i] = i	
}


tiles_list = [tile_default, tile_glass, tile_bomb, tile_floorswitch, tile_copyfloor, tile_exit, 
	tile_deathfloor, tile_white, tile_wall, tile_edge]
	
objects_list = [object_player, object_leech, object_maggot, object_bull, object_gobbler, object_hand, 
	object_mimic, object_diamond, object_spider, object_egg, object_hologram, object_add, object_cif, object_lev, object_tan, object_mon, object_eus, 
	object_bee, object_gor]

function reset_everything() {
	global.tile_mode = true
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



function switch_tile_mode(new_tile_mode) {
	global.tile_mode = new_tile_mode;
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
	if array_length(history) > 500 // will remember 250 changes before removing
		array_delete(history, 0, 2)
}



function undo() {
	static undo_sound = asset_get_index("snd_voidrod_place")
	if array_length(history) != 0 {
		array_copy(global.level_objects, 0, array_pop(history), 0, array_length(global.level_objects))
		array_copy(global.level_tiles, 0, array_pop(history), 0, array_length(global.level_tiles))
		audio_play_sound(undo_sound, 10, false)
	}
}
undo_repeat = -1
undo_repeat_frames_start = 18
undo_repeat_frames_speed = 0
undo_repeat_frames_max_speed = 10