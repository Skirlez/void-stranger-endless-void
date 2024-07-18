// Object purpose: generic manager object for a lot of things EV does. 
// holds the tile/object structs, a lot of the global variables, 
// handles transitions, startup networking/file io and more

randomize()
global.latest_lvl_format = 2;
global.ev_version = "0.90";

global.compiled_for_merge = (asset_get_index("obj_game") != -1)


if (!global.compiled_for_merge) {
	var ratio = display_get_height() / 144	
	surface_resize(application_surface, 224 * ratio, 144 * ratio)
	audio_group_load(VoidStrangerAudio)
	global.debug = false;
	global.pause = false;
	global.music = -4;
	
}



#macro level_extension "vsl"

global.save_directory = game_save_id
global.server_ip = "skirlez.com"

global.author = { username : "Anonymous", brand : int64(irandom_range(0, $FFFFFFFFF)) }
global.stranger = 0;

if !file_exists(global.save_directory + "ev_options.ini") {
	ev_load()
	ev_save();
	ev_update_vars()
}
else
	ev_load()

window_set_cursor(cr_default)

// global.level is used for the level currently being edited / played.
// global.level_sha is only used for the level currently being played, in order to store its sha1 if beaten
global.level = noone;
global.level_sha = ""

global.editor_time = int64(0)
global.level_time = int64(0)

global.selected_thing_time = 0
global.mouse_pressed = false;
global.mouse_held = false;
#macro thing_nothing -1
#macro thing_plucker 0
#macro thing_eraser 1
#macro thing_placeable 2
#macro thing_multiplaceable 3
#macro thing_picker 7

#macro flag_unremovable 1
#macro flag_only_one 2
#macro flag_unplaceable 4
#macro flag_no_objects 8

#macro burden_memory 0
#macro burden_wings 1
#macro burden_sword 2 
#macro burden_stackrod 3

global.editor_room = asset_get_index("rm_ev_editor");
global.level_room = asset_get_index("rm_ev_level");

global.editor_instance = id;
global.display_object = asset_get_index("obj_ev_display");

global.selection_sprite = asset_get_index("spr_ev_selection")
global.white_floor_sprite = asset_get_index("spr_floor_white")

global.tileset_1 = asset_get_index("tile_bg_1")
global.tileset_mon = asset_get_index("tile_bg_secret")
global.tileset_dis = asset_get_index("tile_bg_true")
global.tileset_ex = asset_get_index("tile_bg_void")
global.tileset_edge = asset_get_index("tile_edges")
global.tileset_edge_dis = asset_get_index("tile_edges_true")

global.select_sound = asset_get_index("snd_ev_select")

global.ev_font = asset_get_index("fnt_text_12")

return_noone = function() {
	return noone;
}

empty_function = function(tile_state, i, j) { };

return_tile_state_function = function(tile_state) { 
	return tile_state 
};

default_draw_function = function(tile_state, i, j/*, preview, lvl, no_spoilers*/) {
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
}
music_draw_function = function(tile_state, i, j) {
	var spr = tile_state.tile.spr_ind
	draw_sprite(spr, ev_strobe_integer(sprite_get_number(spr)), j * 16 + 8, i * 16 + 8)	
}



default_reader = function(tile /*, lvl_str, pos, version*/ ) {
	var t = new tile_with_state(tile)
	return { value : t, offset : 0 }
}
default_writer = function(tile_state) {
	return tile_state.tile.tile_id
}
default_placer = function(tile_state, i, j /*, wall_tilemaps, edge_tilemaps */) {
	var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name))
	if (inst.persistent)
		inst.persistent = false;
}

default_tile_io = { 
	read : default_reader,
	write : default_writer,
	place : default_placer
}

enum editor_types {
	tile,
	object
}
enum cube_types {
	uniform,
	uniform_constant,
	edge,
	edge_constant,
}

global.placeable_name_map = ds_map_create()

function editor_tile(display_name, spr_ind, tile_id, obj_name, obj_layer = "Floor", flags = 0) constructor {
	self.display_name = display_name
	self.spr_ind = spr_ind
	self.obj_name = obj_name
	self.obj_layer = obj_layer
	self.flags = flags
	self.draw_function = global.editor_instance.default_draw_function
	self.place_function = global.editor_instance.return_tile_state_function
	self.zed_function = noone
	self.tile_id = tile_id;
	self.properties_generator = global.editor_instance.return_noone
	self.editor_type = editor_types.tile;
	self.iostruct = global.editor_instance.default_tile_io;
	self.cube_type = cube_types.uniform;
	global.placeable_name_map[? tile_id] = self;
} 
function editor_object(display_name, spr_ind, tile_id, obj_name, obj_layer = "Instances", flags = 0) 
		: editor_tile(display_name, spr_ind, tile_id, obj_name, obj_layer, flags) constructor {
	self.editor_type = editor_types.object;
} 

#macro pit_id "pt"
#macro pit_obj "obj_pit"

#macro glass_id "gl"
#macro glass_obj "obj_glassfloor"
#macro glass_name "Glass"

#macro bomb_id "mn"
#macro bomb_obj "obj_bombfloor"
#macro bomb_name "Bomb Tile"

#macro explo_id "xp"
#macro explo_obj "obj_explofloor"
#macro explo_name "Lit Bomb Tile"

#macro default_tile_id "fl"
#macro default_tile_obj "obj_floor"
#macro default_tile_name "Floor"


#macro floorswitch_id "fs"
#macro floorswitch_obj "obj_floorswitch"
#macro floorswitch_name "Button"

#macro copyfloor_id "cr"
#macro copyfloor_obj "obj_copyfloor"
#macro copyfloor_name "Shade Tile"

#macro exit_id "ex"
#macro exit_obj "obj_exit"
#macro exit_name "Exit"

#macro black_floor_id "bl"
#macro black_floor_obj "obj_floor"
#macro black_floor_name "Black Floor"

#macro white_id "wh"
#macro white_obj "obj_floor_blank"
#macro white_name "Blank Tile"


#macro unremovable_id "ur"
#macro unremovable_obj ""

#macro deathfloor_id "df"
#macro deathfloor_obj "obj_deathfloor"
#macro deathfloor_name "Lightning Tile"

#macro no_obj ""
#macro no_name ""

#macro wall_id "wa"
#macro wall_name "Wall"

#macro ex_wall_id "ew"
#macro ex_wall_name "EX Wall"

#macro mon_wall_id "mw"
#macro mon_wall_name "Funhouse Wall"

#macro dis_wall_id "dw"
#macro dis_wall_name "DIS Wall"

#macro edge_id "ed"
#macro edge_name "Edge Tile"

#macro dis_edge_id "de"
#macro dis_edge_name "DIS Edge Tile"


#macro chest_id "st"
#macro chest_obj "obj_chest_small"
#macro chest_name "Chest"

#macro empty_id "em"

#macro player_id "pl"
#macro player_obj "obj_spawnpoint"
#macro player_name "Player"

#macro leech_id "cl"
#macro leech_obj "obj_enemy_cl"
#macro leech_name "Leech"

#macro maggot_id "cc"
#macro maggot_obj "obj_enemy_cc"
#macro maggot_name "Maggot"

#macro gobbler_id "cs"
#macro gobbler_obj "obj_enemy_cs"
#macro gobbler_name "Smile"

#macro bull_id "cg"
#macro bull_obj "obj_enemy_cg"
#macro bull_name "Beaver"

#macro hand_id "ch"
#macro hand_obj "obj_enemy_ch"
#macro hand_name "Eye"

#macro mimic_id "cm"
#macro mimic_obj "obj_enemy_cm"
#macro mimic_name "Mimic"

#macro diamond_id "co"
#macro diamond_obj "obj_enemy_co"
#macro diamond_name "Octahedron"

#macro spider_id "ct"
#macro spider_obj "obj_enemy_ct"
#macro spider_name "Spider"

#macro orb_id "cv"
#macro orb_obj "obj_enemy_cv"
#macro orb_name "Orb Thing"

#macro egg_id "eg"
#macro egg_name "Egg"

#macro egg_statue_obj "obj_boulder"

#macro cif_id "cf"
#macro cif_name "Cif Statue"
#macro tan_id "tn"
#macro tan_name "Tan Statue"
#macro mon_id "mo"
#macro mon_name "Mon Statue"
#macro lev_id "lv"
#macro lev_name "Lev Statue"
#macro eus_id "eu"
#macro eus_name "Eus Statue"
#macro bee_id "be"
#macro bee_name "Bee Statue"
#macro gor_id "go"
#macro gor_name "Gor Statue"
#macro add_id "ad"
#macro add_name "Add Statue"

#macro jukebox_id "jb"
#macro jukebox_name "Jukebox"


#macro hologram_id "ho"
#macro hologram_obj "obj_fakewall"
#macro hologram_name "Fake Egg"

#macro secret_exit_id "se"
#macro secret_exit_obj "obj_na_secret_exit"
#macro secret_exit_name "Secret Exit"

#macro hungry_man_id "hu"
#macro hungry_man_obj "obj_npc_famished"
#macro hungry_man_name "Famished Man"

#macro memory_crystal_id "mm"
#macro memory_crystal_obj "obj_token_uncover"
#macro memory_crystal_name "Memory Crystal"

#macro scaredeer_id "sd"
#macro scaredeer_obj "obj_enemy_cs"
#macro scaredeer_name "Scaredeer"

floor_sprite = asset_get_index("spr_floor");

function tile_state_has_edge(tile_state) {
	var tile = tile_state.tile
	if tile == tile_pit || tile == tile_glass
			|| tile == tile_edge || tile == tile_edge_dis
		return false;
	if tile == tile_mon_wall || tile == tile_ex_wall {
		if (tile_state.properties.ind == 9 || tile_state.properties.ind == 11 || tile_state.properties.ind == 10)
			return false;
	}
	return true;
			
}

tile_pit = new editor_tile(no_name, noone, pit_id, pit_obj, "Pit", flag_unplaceable)
tile_pit.draw_function = function(tile_state, i, j, preview, lvl) {
	if i != 0 && global.editor_instance.tile_state_has_edge(lvl.tiles[i - 1][j])
		draw_sprite(floor_sprite, 1, j * 16 + 8, i * 16 + 8)
}
tile_pit.iostruct = {
	read: default_reader,
	write : default_writer,
	place : function(tile_state, i, j, wall_tilemaps, edge_tilemaps, lvl) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		if i == 0 || !global.editor_instance.tile_state_has_edge(lvl.tiles[i - 1][j])
			instance_destroy(inst.pit_bg)
			
	}
}

tile_glass = new editor_tile(glass_name, asset_get_index("spr_glassfloor"), glass_id, glass_obj, "Floor_INS")
tile_glass.draw_function = function(tile_state, i, j, preview, lvl) {
	tile_pit.draw_function(tile_state, i, j, preview, lvl)
	default_draw_function(tile_state, i, j)
}
tile_bomb = new editor_tile(bomb_name, asset_get_index("spr_bombfloor"), bomb_id, bomb_obj)
tile_explo = new editor_tile(explo_name, asset_get_index("spr_explofloor"), explo_id, explo_obj)

tile_default = new editor_tile(default_tile_name, floor_sprite, default_tile_id, default_tile_obj)
tile_default.cube_type = cube_types.edge

tile_floorswitch = new editor_tile(floorswitch_name, asset_get_index("spr_floorswitch"), floorswitch_id, floorswitch_obj)
tile_floorswitch.draw_function = function(tile_state, i, j, preview, lvl) {
	var ind = lvl.objects[i][j].tile == object_empty ? 0 : 1
	draw_sprite(tile_state.tile.spr_ind, ind, j * 16 + 8, i * 16 + 8)
}
tile_floorswitch.cube_type = cube_types.edge

tile_copyfloor = new editor_tile(copyfloor_name, asset_get_index("spr_copyfloor"), copyfloor_id, copyfloor_obj)
tile_copyfloor.cube_type = cube_types.edge

tile_exit = new editor_tile(exit_name, asset_get_index("spr_stairs"), exit_id, exit_obj)
tile_exit.cube_type = cube_types.edge

function can_tile_press_buttons(tile) {
	static exceptions = [object_empty, object_hologram, object_secret_exit]
	for (var i = 0; i < array_length(exceptions); i++) {
		if (tile == exceptions[i])
			return false;
	}
	return true;
}

function level_has_unpressed_button(lvl) {
	static fs = tile_floorswitch;
	for (var i = 0; i < 8; i++) {
		for (var j = 0; j < 14; j++) {
			if (lvl.tiles[i][j].tile == fs && !can_tile_press_buttons(lvl.objects[i][j].tile))
				return true;
		}
	}	
	return false;
}

tile_exit.draw_function = function(tile_state, i, j, preview, lvl) {
	draw_sprite(tile_state.tile.spr_ind, level_has_unpressed_button(lvl) ? 4 : 0, j * 16 + 8, i * 16 + 8)	
}
tile_white = new editor_tile(white_name, asset_get_index("spr_floor_white"), white_id, white_obj)
tile_deathfloor = new editor_tile(deathfloor_name, asset_get_index("spr_deathfloor"), deathfloor_id, deathfloor_obj)
tile_deathfloor.cube_type = cube_types.edge


tilemap_tile_read = function(tile, lvl_str, pos) {
	var read_ind = string_copy(lvl_str, pos, 2)
	var ind = clamp(int64_safe(read_ind, 0), 0, 255)
	var t = new tile_with_state(tile, { ind : ind });
	return { value : t, offset : 2 };
}
tilemap_tile_write = function(tile_state) {
	return tile_state.tile.tile_id + num_to_string(tile_state.properties.ind, 2);
}

function make_sprite_from_tileset(tileset, ind) {
	var surf = surface_create(16, 16)
	surface_set_target(surf)
	draw_tile(tileset, ind, 0, 0, 0)
	var spr = sprite_create_from_surface(surf, 0, 0, 16, 16, false, false, 8, 8)
	surface_reset_target()
	surface_free(surf)	
	return spr;
}

enum edge_types {
	normal,
	dis,
	size
}

function make_edge_tile(name, tid, type) {
	var spr = make_sprite_from_tileset(get_edge_type_tileset(type), 31)
	var tile = new editor_tile(name, spr, tid, no_obj, "Floor", flag_no_objects)
	tile.draw_function = function(tile_state, i, j, preview, lvl) {
		draw_set_color(c_white)
		draw_tile(get_edge_type_tileset(tile_state.tile.edge_type), preview ? runtile_fetch_blob(j, i, lvl) : tile_state.properties.ind, 0, j * 16, i * 16)
	}
	tile.edge_type = type
	tile.properties_generator = function() {
		return { ind : 4 }	
	}
	tile.place_function = function(tile_state, i, j, lvl) {
		tile_state.properties.ind = runtile_fetch_blob(j, i, lvl);
		return tile_state;
	}
	tile.iostruct = {
		read : tilemap_tile_read,
		write : tilemap_tile_write,
		place : function(tile_state, i, j, wall_tilemaps, edge_tilemaps) {
			tilemap_set(edge_tilemaps[tile_state.tile.edge_type], tile_state.properties.ind, j, i)
			var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, "Pit", asset_get_index(global.editor_instance.tile_pit.obj_name))
			instance_destroy(inst.pit_bg)
		}
	}
	tile.cube_type = cube_types.uniform_constant
	return tile;
}


tile_edge = make_edge_tile(edge_name, edge_id, edge_types.normal)
tile_edge_dis = make_edge_tile(dis_edge_name, dis_edge_id, edge_types.dis)


enum wall_types {
	normal,
	mon,
	dis,
	ex,
	size
}

function make_wall_tile(name, tid, type) {
	var spr = make_sprite_from_tileset(get_wall_type_tileset(type), 4)
	var tile = new editor_tile(name, spr, tid, no_obj, "Floor", flag_no_objects);
	tile.draw_function = function(tile_state, i, j) {
		draw_set_color(c_white)
		draw_tile(get_wall_type_tileset(tile_state.tile.wall_type), tile_state.properties.ind, 0, j * 16, i * 16)	
	}
	tile.zed_function = function(tile_state) {
		new_window(10, 4.5, asset_get_index("obj_ev_wall_window"), {
			type : tile_state.tile.wall_type,	
		})	
		global.mouse_layer = 1
	}
	tile.wall_type = type;
	
	tile.properties_generator = function() {
		return { ind : 4 }
	}

	tile.iostruct = {
		read : tilemap_tile_read,
		write : tilemap_tile_write,
		place : function(tile_state, i, j, wall_tilemaps, edge_tilemaps) {
			tilemap_set(wall_tilemaps[tile_state.tile.wall_type], tile_state.properties.ind, j, i)
			if global.editor_instance.tile_state_has_edge(tile_state)
				instance_create_layer(j * 16 + 8, i * 16 + 8, "Pit", asset_get_index("obj_ev_pit_drawer"))
		}
	}

	tile.cube_type = cube_types.edge
	return tile;
}


tile_wall = make_wall_tile(wall_name, wall_id, wall_types.normal)
tile_mon_wall = make_wall_tile(mon_wall_name, mon_wall_id, wall_types.mon)
tile_dis_wall = make_wall_tile(dis_wall_name, dis_wall_id, wall_types.dis)
tile_ex_wall = make_wall_tile(ex_wall_name, ex_wall_id, wall_types.ex)


tile_black_floor = new editor_tile(black_floor_name, asset_get_index("spr_ev_blackfloor"), black_floor_id, black_floor_obj)
tile_black_floor.iostruct = {
	read : default_reader,
	write : default_writer,
	place : function(tile_state, i, j) {
		instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name), {
			black_floor : true,	
		});
		
		// We create this object to prevent the player from grabbing the tile.
		instance_create_layer(j * 16 + 8, i * 16 + 8, "Instances", asset_get_index("obj_jewel_collect"), {
			visible : false	
		});
	}
}
tile_black_floor.cube_type = cube_types.edge



enum chest_items {
	locust,
	memory,
	wings,
	sword,
	empty,
	opened,
	size // cool trick!
}

tile_chest = new editor_tile(chest_name, asset_get_index("spr_chest_regular"), chest_id, chest_obj, "Floor_INS")
tile_chest.properties_generator = function () {
	return { itm : chest_items.locust }	
}
tile_chest.zed_function = function(tile_state) {
	new_window(6, 5, asset_get_index("obj_ev_chest_window"), {
		chest_properties : tile_state.properties
	})
	global.mouse_layer = 1
}

tile_chest.draw_function = function (tile_state, i, j) {
	static spr_burden_chest = asset_get_index("spr_chest_small");
	var itm = tile_state.properties.itm;
	
	var spr	= (itm == chest_items.locust || itm == chest_items.empty || itm == chest_items.opened)
			? tile_state.tile.spr_ind
			: spr_burden_chest;
	
	var ind = (itm == chest_items.opened) ? 1 : 0;
	
	draw_sprite(spr, ind, j * 16 + 8, i * 16 + 8)	
}

function chest_get_contents_num(item_id) {
	switch (item_id) {
		case chest_items.locust: return 1;
		case chest_items.memory: return 4;
		case chest_items.wings: return 3;
		case chest_items.sword: return 2;
		case chest_items.empty: return 0;
		case chest_items.opened: return 5;
		default: return 1;
	}
}

tile_chest.iostruct = {
	read : function(tile, lvl_str, pos) {
		var read_item = string_copy(lvl_str, pos, 2)
		var item = clamp(int64_safe(read_item, 0), 0, chest_items.size - 1)
		var t = new tile_with_state(tile, { itm : item });
		return { value : t, offset : 2 };
	},
	write : function (tile_state) {
		return tile_state.tile.tile_id + num_to_string(tile_state.properties.itm, 2);	
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		inst.persistent = false;
		inst.contents = global.editor_instance.chest_get_contents_num(tile_state.properties.itm)
		
		// For the edge to appear if a glass tile is below the chest, 
		// we create a normal tile. This is consistent with the base game.
		instance_create_layer(j * 16 + 8, i * 16 + 8, "Floor", asset_get_index(default_tile_obj))
	}
}


tile_unremovable = new editor_tile(no_name, asset_get_index("spr_floor_white"), unremovable_id, unremovable_obj, "Floor", flag_unremovable|flag_unplaceable)
tile_unremovable.draw_function = empty_function;

object_empty = new editor_object(no_name, noone, empty_id, no_obj, "Instances", flag_unplaceable)
object_empty.draw_function = empty_function;
object_empty.iostruct = {
	read: default_reader,
	write : default_writer,
	place : function () {
		
	}
}

sweat_sprite = asset_get_index("spr_sweat")
object_player = new editor_object(player_name, asset_get_index("spr_player_down"), player_id, player_obj, "Instances", flag_unremovable|flag_only_one)
object_player.draw_function = function(tile_state, i, j, preview, lvl) {

	var spr = ev_get_stranger_down_sprite(global.stranger)
	if (preview && lvl.tiles[i][j].tile == tile_pit) {
		draw_sprite(spr, ev_strobe_integer(2), j * 16 + 8 + dsin(global.editor_time * 24), i * 16 + 8)		
		draw_sprite(sweat_sprite, global.editor_time / 5, j * 16 + 16, i * 16)
		return;
	}
	draw_sprite(spr, ev_strobe_integer(2), j * 16 + 8, i * 16 + 8)	
}


object_leech = new editor_object(leech_name, asset_get_index("spr_cl_right"), leech_id, leech_obj)
object_leech.draw_function = function(tile_state, i, j) {
	var xscale = tile_state.properties.dir == true ? -1 : 1
	draw_sprite_ext(tile_state.tile.spr_ind, ev_strobe_integer(2), j * 16 + 8, i * 16 + 8, xscale, 1, 0, c_white, draw_get_alpha())
}
maggot_sprite_down = asset_get_index("spr_cc_down");
maggot_sprite_up = asset_get_index("spr_cc_up");

object_maggot = new editor_object(maggot_name, maggot_sprite_down, maggot_id, maggot_obj)
object_maggot.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.properties.dir == true ? maggot_sprite_up : maggot_sprite_down, ev_strobe_integer(2), j * 16 + 8, i * 16 + 8)
}
var directioned_zed_function = function(tile_state) {
	tile_state.properties.dir = !tile_state.properties.dir
}
var directioned_properties = function() {
	return { dir : false }
}
var directioned_iostruct = {
	read : function(tile_id, lvl_str, pos) {
		var read_dir = string_copy(lvl_str, pos, 1)
		var dir = bool(int64_safe(read_dir, 0))
		var t = new tile_with_state(tile_id, { dir : dir })
		return { value : t, offset : 1 };
	},
	write : function(tile_state) {
		return tile_state.tile.tile_id + (tile_state.properties.dir == true ? "1" : "0");
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		inst.editor_dir = tile_state.properties.dir;
		return inst;
	}
}

object_leech.zed_function = directioned_zed_function
object_leech.properties_generator = directioned_properties
object_leech.iostruct = directioned_iostruct

object_maggot.zed_function = directioned_zed_function
object_maggot.properties_generator = directioned_properties
object_maggot.iostruct = directioned_iostruct

object_bull = new editor_object(bull_name, asset_get_index("spr_cg_idle"), bull_id, bull_obj)
object_bull.draw_function = music_draw_function
object_gobbler = new editor_object(gobbler_name, asset_get_index("spr_cs_right"), gobbler_id, gobbler_obj)
object_gobbler.draw_function = music_draw_function
object_hand = new editor_object(hand_name, asset_get_index("spr_ch"), hand_id, hand_obj)
object_hand.draw_function = music_draw_function
object_mimic = new editor_object(mimic_name, asset_get_index("spr_cm_down"), mimic_id, mimic_obj)
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
	draw_sprite(mimic_sprite_arr[tile_state.properties.typ], ev_strobe_integer(2), j * 16 + 8, i * 16 + 8)
}
object_mimic.iostruct = {
	read : function(tile_id, lvl_str, pos) {
		var read_type = string_copy(lvl_str, pos, 1)
		var type = clamp(int64_safe(read_type, 0), 0, 2)
		var t = new tile_with_state(tile_id, { typ: type })
		return { value : t, offset : 1 };
	},
	write : function(tile_state) {
		return tile_state.tile.tile_id + string(tile_state.properties.typ);
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		inst.editor_type = tile_state.properties.typ;
		return inst;
	}	
}

object_diamond = new editor_object(diamond_name, asset_get_index("spr_co_idle"), diamond_id, diamond_obj)
object_diamond.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, ev_strobe_fasttriplet_real(2), j * 16 + 8, i * 16 + 8)	
}

object_spider = new editor_object(spider_name, asset_get_index("spr_ct_right"), spider_id, spider_obj)
object_spider.draw_function = function(tile_state, i, j) {
	var ind = (tile_state.properties.ang == 2 || tile_state.properties.ang == 3) 
		? 1 - ev_strobe_integer(2) : ev_strobe_integer(2)
		
	draw_sprite_ext(tile_state.tile.spr_ind, ind, j * 16 + 8, i * 16 + 8, 1, 1,
		tile_state.properties.ang * 90, c_white, draw_get_alpha())
}
object_spider.properties_generator = function() {
	return { ang : 0 }	
}
object_spider.zed_function = function(tile_state) {
	tile_state.properties.ang -= 1
	if tile_state.properties.ang < 0
		tile_state.properties.ang = 3
}
object_spider.iostruct = {
	read : function(tile_id, lvl_str, pos) {
		var read_angle = string_copy(lvl_str, pos, 1)
		var angle = clamp(int64_safe(read_angle, 0), 0, 3)
		var t = new tile_with_state(tile_id, { ang: angle })
		return { value : t, offset : 1 };
	},
	write : function(tile_state) {
		return tile_state.tile.tile_id + string(tile_state.properties.ang );
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		var val = tile_state.properties.ang - 1
		if (val < 0)
			val = 3
		inst.set_e_direction = 3 - val;
		return inst;
	}		
}

object_orb = new editor_object(orb_name, asset_get_index("spr_cv"), orb_id, orb_obj)
object_orb.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, ev_strobe_integer(2), j * 16 + 8, i * 16 + 8)	
}

object_egg = new editor_object(egg_name, asset_get_index("spr_boulder"), egg_id, egg_statue_obj)
object_egg.properties_generator = function() {
	return { txt : array_create(4, "") }	
}
object_egg.zed_function = function(tile_state) {
	new_window(10, 6, asset_get_index("obj_ev_egg_window"), 
	{ egg_properties : tile_state.properties })	
	global.mouse_layer = 1
}

object_egg.draw_function = function(tile_state, i, j, preview, lvl, no_spoilers) {
	default_draw_function(tile_state, i, j)
	if no_spoilers
		return;
	static spr_eggtext = asset_get_index("spr_ev_eggtext");
	if (tile_state.properties.txt[0] != "") {
		draw_sprite(spr_eggtext, 0, j * 16 + 8, i * 16 + 8)
	}
}
object_egg.iostruct = {
	read : function(tile, lvl_str, pos) {
		var read_length = string_char_at(lvl_str, pos)
		var arrlen = clamp(int64_safe(read_length, 0), 0, 4);
		pos += 1;
		
		var txt_arr = array_create(4, "")
		var total_count = 0;
		
		for (var m = 0; m < arrlen; m++) {
			var endp = string_pos_ext(BASE64_END_CHAR, lvl_str, pos)	
			if (endp == 0)
				break;
			total_count += endp - pos + 1;
			var read_string = string_copy(lvl_str, pos, endp - pos)
			pos = endp + 1;
			txt_arr[m] = base64_decode(read_string)
		}
		var t = new tile_with_state(tile, { txt: txt_arr });
		return { value : t, offset : 1 + total_count };
	},
	write : function(tile_state) {
		var arrlen = array_length(tile_state.properties.txt)
		var encoded_text = "";
		var m;
		for (m = 0; m < arrlen; m++) {
			var txt = tile_state.properties.txt[m]
			if txt == ""
				break;
			encoded_text += base64_encode(txt) + BASE64_END_CHAR	
		}
		return tile_state.tile.tile_id + string(m) + encoded_text
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		with (inst) {
			var m;
			for (m = 0; m < 4; m++) {
				if tile_state.properties.txt[m] == ""
					break;
				text[m] = tile_state.properties.txt[m];
			}
			if m == 0
				break;
			special_message = -1
			voice = b_voice	
			moods = array_create(m, neutral)
			speakers = array_create(m, id)
		}
	}		
}


cif_sprite = asset_get_index("spr_atoner")
lamp_sprite = asset_get_index("spr_lamp")

object_cif = new editor_object(cif_name, cif_sprite, cif_id, egg_statue_obj)
object_cif.properties_generator = function() {
	return { lmp : false }
}
object_cif.zed_function = function(tile_state) {
	tile_state.properties.lmp = !tile_state.properties.lmp
}
object_cif.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.properties.lmp ? lamp_sprite : cif_sprite, 0, j * 16 + 8, i * 16 + 8)
}
object_cif.iostruct = {
	read : function(tile_id, lvl_str, pos) {
		var read_lamp = string_copy(lvl_str, pos, 1)
		var lamp = bool(int64_safe(read_lamp, 0))
		var t = new tile_with_state(tile_id, { lmp: lamp })
		return { value : t, offset : 1 };
	},
	write : function(tile_state) {
		return tile_state.tile.tile_id + string(tile_state.properties.lmp);
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		if (tile_state.properties.lmp)
			inst.editor_lamp = true

		inst.b_form = 4
		return inst;
	}		
}

function voidlord_io(b_form) {
	return {
		read : default_reader,
		write : default_writer,
		place : function (tile_state, i, j) {
			var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
			inst.b_form = self.num
			return inst;
		},
		num : b_form
	};
}	

object_add = new editor_object(add_name, asset_get_index("spr_voider"), add_id, egg_statue_obj)
object_add.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)
	if tile_state.properties.mde != 0 {
		static branefucked = asset_get_index("spr_ev_branefucked")
		draw_sprite(branefucked, 0, j * 16 + 8, i * 16 + 8)
	}
}
object_add.properties_generator = function() {
	return {
		mde : 0,
		in1 : "",
		in2 : "",
		val : "",
		pgm : "",
	}
}

#macro BRAINFUCK_SEP "!"

object_add.iostruct = {
	read : function(tile, lvl_str, pos, version) {
		if (version == 1)
			return global.editor_instance.default_reader(tile, lvl_str, pos)	
		var original_pos = pos;
		var read_mode = string_copy(lvl_str, pos, 1)
		var mode = int64_safe(read_mode, 0)	
		pos++;
		
		if (mode == 0) {
			var t = new tile_with_state(tile)
			return { value : t, offset : pos - original_pos }
		}
		var read_input_1 = read_string_until(lvl_str, pos, BRAINFUCK_SEP)
		
		pos += read_input_1.offset + 1;
		
		if (mode == 1) {
			var read_destroy_value = read_string_until(lvl_str, pos, BRAINFUCK_SEP)
			pos += read_destroy_value.offset + 1;
			
			
			var t = new tile_with_state(tile, {
				mde : 1,
				in1 : base64_decode(read_input_1.substr),
				in2 : "",
				val : base64_decode(read_destroy_value.substr),
				pgm : "",
			})
			return { value : t, offset : pos - original_pos }
		}
		
		var read_input_2 = read_string_until(lvl_str, pos, BRAINFUCK_SEP)
		pos += read_input_2.offset + 1;
		var read_destroy_value = read_string_until(lvl_str, pos, BRAINFUCK_SEP)
		pos += read_destroy_value.offset + 1;
		var read_program = read_string_until(lvl_str, pos, BRAINFUCK_SEP)
		pos += read_program.offset + 1;
		
		var t = new tile_with_state(tile, {
			mde : 2,
			in1 : base64_decode(read_input_1.substr),
			in2 : base64_decode(read_input_2.substr),
			val : base64_decode(read_destroy_value.substr),
			pgm : read_program.substr,
		})
		return { value : t, offset : pos - original_pos }
	},
	write : function(tile_state) {
		
		var mode = tile_state.properties.mde
		var program = tile_state.properties.pgm;
		var input_1 = tile_state.properties.in1;
		var input_2 = tile_state.properties.in2;
		var destroy_value = tile_state.properties.val;
		
		if mode == 0 {
			return tile_state.tile.tile_id + "0"
		}
		if mode == 1 {
			return tile_state.tile.tile_id + "1" + base64_encode(input_1) + BRAINFUCK_SEP + base64_encode(destroy_value) + BRAINFUCK_SEP
		}
		return tile_state.tile.tile_id + "2" + base64_encode(input_1) + BRAINFUCK_SEP 
			+ base64_encode(input_2) + BRAINFUCK_SEP 
			+ base64_encode(destroy_value) + BRAINFUCK_SEP 
			+ program + BRAINFUCK_SEP; 
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		inst.b_form = 8;
		
		var mode = tile_state.properties.mde;
		
		if mode == 0
			return inst;
			
		
		var program 
		if mode == 1
			program = ".";
		else
			program = tile_state.properties.pgm
		instance_create_layer(0, 0, tile_state.tile.obj_layer, asset_get_index("obj_ev_brainfucker"), {
			add_inst : inst,
			input_1_str : tile_state.properties.in1,
			input_2_str : tile_state.properties.in2,
			destroy_value_str : tile_state.properties.val,
			program_str : program,
		});
		
		return inst;
	},
};
object_add.zed_function = function(tile_state) {
	new_window(13, 8, asset_get_index("obj_ev_add_statue_window"), {
		add_properties : tile_state.properties
	})
	global.mouse_layer = 1
}


object_mon = new editor_object(mon_name, asset_get_index("spr_greeder"), mon_id, egg_statue_obj)
object_mon.iostruct = voidlord_io(7)
object_tan = new editor_object(tan_name, asset_get_index("spr_killer"), tan_id, egg_statue_obj)
object_tan.iostruct = voidlord_io(3)
object_lev = new editor_object(lev_name, asset_get_index("spr_watcher"), lev_id, egg_statue_obj)
object_lev.iostruct = voidlord_io(1)
object_eus = new editor_object(eus_name, asset_get_index("spr_lover"), eus_id, egg_statue_obj)
object_eus.iostruct = voidlord_io(6)
object_bee = new editor_object(bee_name, asset_get_index("spr_smiler"), bee_id, egg_statue_obj)
object_bee.iostruct = voidlord_io(2)
object_gor = new editor_object(gor_name, asset_get_index("spr_slower"), gor_id, egg_statue_obj)
object_gor.iostruct = voidlord_io(5)

object_jukebox = new editor_object(jukebox_name, asset_get_index("spr_jb"), jukebox_id, egg_statue_obj)
object_jukebox.iostruct = voidlord_io(9)

object_secret_exit = new editor_object(secret_exit_name, asset_get_index("spr_ev_secret_exit_arrow"), secret_exit_id, secret_exit_obj)

// 0 - invisible, 1 - stars, 2 - stink lines
object_secret_exit.properties_generator = function () {
	return { typ : 0 }	
}
object_secret_exit.iostruct = {
	read : function(tile_id, lvl_str, pos, version) {
		if (version == 1) {
			var t = new tile_with_state(tile_id, { typ : 0 })
			return { value : t, offset : 0 };	
		}
		var read_type = string_copy(lvl_str, pos, 1)
		var type = clamp(int64_safe(read_type, 0), 0, 2)
		var t = new tile_with_state(tile_id, { typ : type })
		return { value : t, offset : 1 };
	},
	write : function(tile_state) {
		return tile_state.tile.tile_id + string(tile_state.properties.typ);
	},
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		
		var type = tile_state.properties.typ;
		
		if type == 1
			inst.secret_stars = true;
		else if type == 2
			instance_create_layer(j * 16 + 8, i * 16 + 8, "Effects", asset_get_index("obj_stinklines"))	
		
		return inst;
	}
}

object_secret_exit.draw_function = function(tile_state, i, j, preview, lvl, no_spoilers) {
	if (no_spoilers)
		return;
	static stinklines_sprite = asset_get_index("spr_stinklines")
	static stars_sprite = asset_get_index("spr_soulstar_spark")
	
	var type = tile_state.properties.typ;
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
		
	if type == 1 {
		draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
		draw_sprite(stars_sprite, 2, j * 16 + 5, i * 16 + 10)	
		draw_sprite(stars_sprite, 3, j * 16 + 13, i * 16 + 5)	
	}
	else if type == 2
		draw_sprite(stinklines_sprite, global.editor_time / 10, j * 16 + 8, i * 16 + 8)
}

object_secret_exit.zed_function = function(tile_state) {
	tile_state.properties.typ++;
	if tile_state.properties.typ > 2
		tile_state.properties.typ = 0;
}


object_hungry_man = new editor_object(hungry_man_name, asset_get_index("spr_fam_u"), hungry_man_id, hungry_man_obj)
object_hungry_man.draw_function = music_draw_function


// we make a memory crystal sprite with an outline for the object selection window only, in the draw
// function it uses the unmodified sprite
crystal_sprite = asset_get_index("spr_token_floor");

var surface_crystal = surface_create(16, 16)
surface_set_target(surface_crystal)

draw_sprite_ext(crystal_sprite, 0, 8 - 1, 8, 1, 1, 0, c_black, 1)
draw_sprite_ext(crystal_sprite, 0, 8 + 1, 8, 1, 1, 0, c_black, 1)
draw_sprite_ext(crystal_sprite, 0, 8, 8 - 1, 1, 1, 0, c_black, 1)
draw_sprite_ext(crystal_sprite, 0, 8, 8 + 1, 1, 1, 0, c_black, 1)

draw_sprite(crystal_sprite, 0, 8, 8)

surface_reset_target()


var crystal_sprite_with_outline = sprite_create_from_surface(surface_crystal, 0, 0, 16, 16, false, false, 8, 8)
surface_free(surface_crystal)

object_memory_crystal = new editor_object(memory_crystal_name, crystal_sprite_with_outline, memory_crystal_id, memory_crystal_obj, "Instances", flag_only_one)
object_memory_crystal.draw_function = function(tile_state, i, j, preview, lvl, no_spoilers) {
	draw_sprite(global.editor_instance.crystal_sprite, 0, j * 16 + 8, i * 16 + 8)	
}



// The lengths I go to to not include base game sprites in the source.
var surface_deer = surface_create(16, 16)
surface_set_target(surface_deer)

draw_sprite(asset_get_index("spr_ee_enemy_reaper"), 0, 0, -16 * 3)
scaredeer_sprite_r = sprite_create_from_surface(surface_deer, 0, 0, 16, 16, false, false, 8, 8)

draw_clear_alpha(c_black, 0)
draw_sprite(asset_get_index("spr_ee_enemy_reaper"), 1, 0, -16 * 3)
var scaredeer_sprite_r_2 = sprite_create_from_surface(surface_deer, 0, 0, 16, 16, false, false, 8, 8)

draw_clear_alpha(c_black, 0)
draw_sprite_ext(asset_get_index("spr_ee_enemy_reaper"), 0, 16, -16 * 3, -1, 1, 0, c_white, 1)
scaredeer_sprite_l = sprite_create_from_surface(surface_deer, 0, 0, 16, 16, false, false, 8, 8)

draw_clear_alpha(c_black, 0)
draw_sprite_ext(asset_get_index("spr_ee_enemy_reaper"), 1, 16, -16 * 3, -1, 1, 0, c_white, 1)
var scaredeer_sprite_l_2 = sprite_create_from_surface(surface_deer, 0, 0, 16, 16, false, false, 8, 8)

scaredeer_sprite_fall = sprite_duplicate(scaredeer_sprite_r);
sprite_merge(scaredeer_sprite_fall, scaredeer_sprite_l_2)
sprite_merge(scaredeer_sprite_fall, scaredeer_sprite_l)
sprite_merge(scaredeer_sprite_fall, scaredeer_sprite_r_2)

sprite_merge(scaredeer_sprite_r, scaredeer_sprite_r_2)
sprite_merge(scaredeer_sprite_l, scaredeer_sprite_l_2)



sprite_delete(scaredeer_sprite_l_2)
sprite_delete(scaredeer_sprite_r_2)



surface_reset_target()

surface_free(surface_deer)
object_scaredeer = new editor_object(scaredeer_name, scaredeer_sprite_r, scaredeer_id, scaredeer_obj)
object_scaredeer.draw_function = music_draw_function;
object_scaredeer.iostruct = { 
	read : default_reader,
	write : default_writer,
	place : function (tile_state, i, j) {
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.tile.obj_layer, asset_get_index(tile_state.tile.obj_name));
		with (inst) {
			ev_scaredeer = true;
			spr_l = global.editor_instance.scaredeer_sprite_l
			spr_r = global.editor_instance.scaredeer_sprite_r
			e_fall_sprite = global.editor_instance.scaredeer_sprite_fall
			e_falling_sprite = asset_get_index("spr_fall");
		}
	},

}

// we create the hologram sprite in real time
var hologram_surf = surface_create(16, 16)
surface_set_target(hologram_surf)
draw_sprite(asset_get_index("spr_boulder"), 0, 8, 8)
draw_sprite(asset_get_index("spr_question_black"), 8, 8, 8)
var hologram_sprite = sprite_create_from_surface(hologram_surf, 0, 0, 16, 16, false, false, 8, 8)
surface_reset_target()
surface_free(hologram_surf)
object_hologram = new editor_object(hologram_name, hologram_sprite, hologram_id, hologram_obj)

object_hologram.draw_function = function(tile_state, i, j, preview, lvl, no_spoilers) {
	if no_spoilers {
		draw_sprite(global.editor_instance.object_egg.spr_ind, 0, j * 16 + 8, i * 16 + 8)
		return;
	}
	default_draw_function(tile_state, i, j)
}


global.player_tiles = array_create(7)
global.player_objects = array_create(7)
for (var i = 0; i < 7; i++) {
	global.player_tiles[i] = i	
	global.player_objects[i] = i	
}


tiles_list = [tile_default, tile_glass, tile_bomb, tile_explo, tile_floorswitch, tile_copyfloor, tile_exit, 
	tile_deathfloor, tile_black_floor, tile_white, tile_wall, tile_mon_wall, tile_dis_wall, tile_ex_wall, tile_edge, tile_edge_dis, tile_chest]
	
objects_list = [object_player, object_leech, object_maggot, object_bull, object_gobbler, object_hand, 
	object_mimic, object_diamond, object_hungry_man, object_add, object_cif, object_bee, object_tan, object_lev, object_mon, object_eus, object_gor, 
	object_jukebox, object_egg, object_hologram, object_memory_crystal, object_secret_exit,
	object_spider, object_scaredeer, object_orb]

global.music_names = ["", "msc_001", "msc_dungeon_wings", "msc_beecircle", "msc_dungeongroove", "msc_013",
	"msc_gorcircle_lo", "msc_levcircle", "msc_escapewithfriend", "msc_cifcircle", "msc_006", "msc_beesong", "msc_themeofcif",
	"msc_monstrail", "msc_endless", "msc_stg_extraboss", "msc_rytmi2", "msc_test2"]

function reset_everything() {
	global.tile_mode = false
	global.mouse_layer = 0
	global.selected_thing = -1 
	global.selected_placeable_num = 0
	
	global.level = new level_struct()

	place_placeholder_tiles(global.level)
	
	current_list = objects_list;
	current_placeables = global.level.objects
	current_empty_tile = object_empty
}

reset_everything()



function switch_tile_mode(new_tile_mode) {
	global.tile_mode = new_tile_mode;
	if (global.tile_mode) {
		current_list = tiles_list
		current_placeables = global.level.tiles
		current_empty_tile = tile_pit
	}
	else {
		current_list = objects_list
		current_placeables = global.level.objects
		current_empty_tile = object_empty
	}
	if (global.selected_thing == thing_placeable || global.selected_thing == thing_multiplaceable) {
		global.selected_thing = -1
		global.selected_placeable_num = -1
	}
}

global.erasing = -1;
erasing_surface = surface_create(224, 144)
global.goes_sound = asset_get_index("snd_ex_vacuumgoes")





history = []


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
	array_push(history, copy_tile_data(global.level.tiles), copy_tile_data(global.level.objects))
	if array_length(history) > 500 // will remember 250 changes before removing
		array_delete(history, 0, 2)
}

function undo() {
	static undo_sound = asset_get_index("snd_voidrod_place")
	if array_length(history) != 0 {
		array_copy(global.level.objects, 0, array_pop(history), 0, array_length(global.level.objects))
		array_copy(global.level.tiles, 0, array_pop(history), 0, array_length(global.level.tiles))
		audio_play_sound(undo_sound, 10, false)
	}
}

undo_repeat = -1
undo_repeat_frames_start = 18
undo_repeat_frames_speed = 0
undo_repeat_frames_max_speed = 10

function get_menu_music_name() {
	switch (current_weekday) {
		case 0: return "snd_ev_music_astra_jam"
		case 1: return "snd_ev_music_monsday"
		case 2: return "snd_ev_music_Teusday"
		case 3: return "snd_ev_music_alsoGooeyPhantasm"
		case 5: return "snd_ev_music_gooeyPhantasm"
		default: return "snd_ev_music_stealie_feelies"
	}
}
global.menu_music = asset_get_index(get_menu_music_name())



play_transition = -1
max_play_transition = 20
play_transition_display = noone

preview_transition = -1
max_preview_transition = 20
preview_transition_display = noone
preview_transition_highlight = noone


edit_transition = -1
max_edit_transition = 30
edit_transition_display = noone

move_curve = animcurve_get_channel(ac_play_transition, "move")
grow_curve = animcurve_get_channel(ac_play_transition, "grow")
preview_curve = animcurve_get_channel(ac_preview_curve, 0)
edit_curve = animcurve_get_channel(ac_edit_curve, 0)

function preview_level_transition(lvl, lvl_sha, display_instance) {
	global.mouse_layer = -1
	display_instance.layer = layer_get_id("HighlightedLevel")
	preview_transition = max_preview_transition
	preview_transition_display = display_instance
	preview_transition_highlight = instance_create_layer(0, 0, "LevelHighlight", asset_get_index("obj_ev_level_highlight"), {
		lvl : lvl,
		lvl_sha : lvl_sha,
		display_instance : display_instance,
		alpha : 0
	})
}

function play_level_transition(lvl, lvl_sha, display_instance) {
	global.level = lvl;
	global.level_sha = lvl_sha
	play_transition = max_play_transition
	play_transition_display = display_instance
	display_instance.draw_brand = false;
	display_instance.draw_beaten = 0;
	global.mouse_layer = -1
}

function edit_level_transition(lvl, display_instance) {
	global.level = lvl;
	ev_stop_music()
	edit_transition = max_edit_transition
	edit_transition_display = display_instance
	display_instance.draw_brand = false;
	display_instance.draw_beaten = 0;
	global.mouse_layer = -1
}

// used in obj_ev_level_select, is essentially the level "page". we want this to be global so it persists
global.level_start = 0;


global.online_mode = false;


get_levels = noone
validate_levels = noone
online_levels_str = noone
get_version = noone
	
global.online_levels = []
function try_update_online_levels() {
	get_levels = http_get(global.server);
}
startup_timeout = -1;

function request_version_string() {
	get_version = http_get(global.server + "/version")
}

global.key_level_map = ds_map_create()
global.level_key_map = ds_map_create()

function add_level_key(key, level_save_name) {
	ds_map_add(global.key_level_map, key, level_save_name)
	ds_map_add(global.level_key_map, level_save_name, key)
}
function remove_level_key(level_save_name) {
	var key = ds_map_find_value(global.level_key_map, level_save_name)
	ds_map_delete(global.key_level_map, key)
	ds_map_delete(global.level_key_map, level_save_name)
}



function on_server_validate_startup(valid_str) {
	var arr_ind = 0;
	for (var i = 1; i <= string_length(valid_str); i++) {
		var char = string_char_at(valid_str, i)
		if (char == "0") {
			file_delete(global.levels_directory + uploaded_levels[arr_ind] + ".key")
			array_delete(uploaded_keys, arr_ind, 1)
			array_delete(uploaded_levels, arr_ind, 1)
		}
		else
			arr_ind++;
	}
	for (var i = 0; i < array_length(uploaded_keys); i++) {
		add_level_key(uploaded_keys[i], uploaded_levels[i])	
	}
		

}
function on_startup_finish() {
	get_levels = noone;
	validate_levels = noone;
	startup_timeout = 0;
	room_goto(asset_get_index("rm_ev_menu"))
}



global.beaten_levels_map = ds_map_create()
function read_beaten_levels() {
	ds_map_clear(global.beaten_levels_map)
	if !file_exists(global.levels_directory + "beaten_levels.txt")
		exit
	var file = file_text_open_read(global.levels_directory + "beaten_levels.txt")
	
	var arr = []
	while (!file_text_eof(file)) {
		array_push(arr, file_text_readln(file));
	}
	
	for (var i = 0; i < array_length(arr); i++) {
		arr[i] = string_replace(arr[i], "\n", "")
		arr[i] = string_replace(arr[i], "\r", "")
	
		var split = ev_string_split(arr[i], "|")
		var value;
		var key;
		if array_length(split) == 2 {
			key = split[0]	
			value = int64_safe(split[1], 1)
		}
		else {
			key = arr[i]
			value = 1;
		}
		
		ds_map_add(global.beaten_levels_map, key, value);
	}
	file_text_close(file)
}
function save_beaten_levels() {	
	var str = ""
	
	var size = ds_map_size(global.beaten_levels_map);
	var key = ds_map_find_first(global.beaten_levels_map);
	if (is_undefined(key))
		return;
	var value = ds_map_find_value(global.beaten_levels_map, key)		
	str += key + "|" + string(value);
	
	for (var i = 0; i < size - 1; i++;) {
		key = ds_map_find_next(global.beaten_levels_map, key);
		value = ds_map_find_value(global.beaten_levels_map, key)		
		str += ("\n" + key + "|" + string(value))
	}
	var file = file_text_open_write(global.levels_directory + "beaten_levels.txt")
	file_text_write_string(file, str)
	file_text_close(file)
}


global.there_is_a_newer_version = false;
global.newest_version = "0.875";

global.startup_room = asset_get_index("rm_ev_startup")
global.playtesting = false;

spin_surface = surface_create(16, 16)

stupid_sprite_i_can_only_delete_later_lest_the_cube_shall_whiten = noone

spin_time_h = 0
spin_time_v = 0;

global.death_count = 0

global.turn_frames = 0
global.death_frames = -1

