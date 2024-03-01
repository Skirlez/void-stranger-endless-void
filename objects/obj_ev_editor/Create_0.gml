randomize()
#macro compiled_for_merge false
if (!compiled_for_merge) {
	var ratio = display_get_height() / 144	
	surface_resize(application_surface, 224 * ratio, 144 * ratio)
	audio_group_load(VoidStrangerAudio)
	global.music = -4	
}

#macro level_extension "vsl"

global.levels_directory = game_save_id + "levels\\"
global.save_directory = game_save_id

global.server = "http://207.127.92.246:3000/voyager"

global.author = { username : "Anonymous", brand : string(irandom_range(0, $FFFFFFFFF)) }

if !file_exists(global.save_directory + "author.ini") {
	ev_save();
}
else
	ev_load()
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

#macro burden_memory 0
#macro burden_wings 1
#macro burden_sword 2 
#macro burden_stackrod 3

global.editor_room = asset_get_index("rm_ev_editor");
global.editor_instance = id;
global.display_object = asset_get_index("obj_ev_display");

global.selection_sprite = asset_get_index("spr_ev_selection")
global.white_floor_sprite = asset_get_index("spr_floor_white")

global.tileset_1 = asset_get_index("tile_bg_1")
global.tileset_edge = asset_get_index("tile_edges")

global.select_sound = asset_get_index("snd_ev_select")

global.ev_font = asset_get_index("fnt_text_12")

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
music_draw_function = function(tile_state, i, j) {
	var spr = tile_state.tile.spr_ind
	draw_sprite(spr, ev_strobe_integer(sprite_get_number(spr)), j * 16 + 8, i * 16 + 8)	
}

global.placeable_name_map = ds_map_create()


default_reader = function(tile /*, lvl_str, pos*/ ) {
	var t = new tile_with_state(tile)
	return { value : t, offset : 0 }
}
default_writer = function(tile_state) {
	return tile_state.tile.tile_id
}
default_placer = function(tile_state, i, j /*, wall_tilemap, edge_tilemap */) {
	instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name))
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

function editor_tile(spr_ind, tile_id, obj_name, obj_layer = "Floor", flags = 0) constructor {
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
	global.placeable_name_map[? tile_id] = self;
} 
function editor_object(spr_ind, tile_id, obj_name, obj_layer = "Instances", flags = 0) 
		: editor_tile(spr_ind, tile_id, obj_name, obj_layer, flags) constructor {
	self.editor_type = editor_types.object;
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

#macro chest_id "st"
#macro chest_obj "obj_chest_small"

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

#macro secret_exit_id "se"
#macro secret_exit_obj "obj_na_secret_exit"

#macro hungry_man_id "hu"
#macro hungry_man_obj "obj_npc_famished"


floor_sprite = asset_get_index("spr_floor");

tile_pit = new editor_tile(noone, pit_id, pit_obj, "Pit", flag_unplaceable)
tile_pit.draw_function = function(tile_state, i, j, preview, lvl) {
	if (i == 0)
		return;
	var above_tile_state = lvl.tiles[i - 1][j];

	if above_tile_state.tile != tile_pit && above_tile_state.tile != tile_glass
			&& above_tile_state.tile != tile_edge
		draw_sprite(floor_sprite, 1, j * 16 + 8, i * 16 + 8)
}

tile_glass = new editor_tile(asset_get_index("spr_glassfloor"), glass_id, glass_obj, "Floor_INS")
tile_glass.draw_function = function(tile_state, i, j, preview, lvl) {
	tile_pit.draw_function(tile_state, i, j, preview, lvl)
	default_draw_function(tile_state, i, j)
}
tile_bomb = new editor_tile(asset_get_index("spr_bombfloor"), bomb_id, bomb_obj)
tile_default = new editor_tile(floor_sprite, default_tile_id, default_tile_obj)
tile_floorswitch = new editor_tile(asset_get_index("spr_floorswitch"), floorswitch_id, floorswitch_obj)
tile_floorswitch.draw_function = function(tile_state, i, j, preview, lvl) {
	var ind = lvl.objects[i][j].tile == object_empty ? 0 : 1
	draw_sprite(tile_state.tile.spr_ind, ind, j * 16 + 8, i * 16 + 8)
}
tile_copyfloor = new editor_tile(asset_get_index("spr_copyfloor"), copyfloor_id, copyfloor_obj)


tile_exit = new editor_tile(asset_get_index("spr_stairs"), exit_id, exit_obj)
tile_white = new editor_tile(asset_get_index("spr_floor_white"), white_id, white_obj)
tile_deathfloor = new editor_tile(asset_get_index("spr_deathfloor"), deathfloor_id, deathfloor_obj)


tilemap_tile_read = function(tile, lvl_str, pos) {
	var read_ind = string_copy(lvl_str, pos, 2)
	var ind = clamp(int64_safe(read_ind, 0), 0, 255)
	var t = new tile_with_state(tile, { ind : ind });
	return { value : t, offset : 2 };
}
tilemap_tile_write = function(tile_state) {
	return tile_state.tile.tile_id + num_to_string(tile_state.properties.ind, 2);
}


// we create the edge sprite in real time
var edge_surf = surface_create(16, 16)
surface_set_target(edge_surf)
draw_tile(asset_get_index("tile_edges"), 4, 0, 0, 0)
var edge_sprite = sprite_create_from_surface(edge_surf, 0, 0, 16, 16, false, false, 8, 8)
surface_reset_target()
surface_free(edge_surf)

tile_edge = new editor_tile(edge_sprite, edge_id, no_obj, "Floor", flag_no_objects)
tile_edge.properties_generator = function() {
	return { ind : 4 }	
}
tile_edge.draw_function = function(tile_state, i, j, preview, lvl) {
	draw_set_color(c_white)
	draw_tile(global.tileset_edge, preview ? runtile_fetch_blob(j, i, lvl) : tile_state.properties.ind, 0, j * 16, i * 16)
}
tile_edge.place_function = function(tile_state, i, j, lvl) {
	tile_state.properties.ind = runtile_fetch_blob(j, i, lvl);
	return tile_state;
}
tile_edge.iostruct = {
	read : tilemap_tile_read,
	write : tilemap_tile_write,
	place : function(tile_state, i, j, wall_tilemap, edge_tilemap) {
		tilemap_set(edge_tilemap, tile_state.properties.ind, j, i)
	}
}


tile_wall = new editor_tile(asset_get_index("spr_ev_wall"), wall_id, no_obj, "Floor", flag_no_objects)
tile_wall.draw_function = function(tile_state, i, j) {
	draw_set_color(c_white)
	draw_tile(global.tileset_1, tile_state.properties.ind, 0, j * 16, i * 16)	
}
tile_wall.zed_function = function() {
	new_window(10, 4.5, asset_get_index("obj_ev_wall_window"))	
	global.mouse_layer = 1
}

tile_wall.properties_generator = function() {
	return { ind : 4 }
}
tile_wall.iostruct = {
	read : tilemap_tile_read,
	write : tilemap_tile_write,
	place : function(tile_state, i, j, wall_tilemap, edge_tilemap) {
		tilemap_set(wall_tilemap, tile_state.properties.ind, j, i)
	}
}


tile_chest = new editor_tile(asset_get_index("spr_chest_regular"), chest_id, chest_obj, "Floor_INS")
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
	draw_sprite((itm == chest_items.locust || itm == chest_items.empty)
			? tile_state.tile.spr_ind
			: spr_burden_chest,
			0, j * 16 + 8, i * 16 + 8)	
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
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
		inst.persistent = false;
		inst.contents = chest_get_contents_num(tile_state.properties.itm)
		if (tile_state.properties.itm == chest_items.sword)
			inst.sprite_index = asset_get_index("spr_chest_small")
	}
}
function chest_get_contents_num(item_id) {
	switch (item_id) {
		case chest_items.locust: return 1;
		case chest_items.memory: return 4;
		case chest_items.wings: return 3;
		case chest_items.sword: return 2;
		case chest_items.empty: return 0;
		default: return 1;
	}
}

tile_unremovable = new editor_tile(asset_get_index("spr_floor_white"), unremovable_id, unremovable_obj, "Floor", flag_unremovable|flag_unplaceable)
tile_unremovable.draw_function = empty_function;

object_empty = new editor_object(noone, empty_id, no_obj, "Instances", flag_unplaceable)
object_empty.draw_function = empty_function;


sweat_sprite = asset_get_index("spr_sweat")
object_player = new editor_object(asset_get_index("spr_player_down"), player_id, player_obj, "Instances", flag_unremovable|flag_only_one)
object_player.draw_function = function(tile_state, i, j, preview, lvl) {
	if (preview && lvl.tiles[i][j].tile == tile_pit) {
		draw_sprite(tile_state.tile.spr_ind, ev_strobe_integer(2), j * 16 + 8 + dsin(global.editor_time * 24), i * 16 + 8)		
		draw_sprite(sweat_sprite, global.editor_time / 5, j * 16 + 16, i * 16)
		return;
	}
	draw_sprite(tile_state.tile.spr_ind, ev_strobe_integer(2), j * 16 + 8, i * 16 + 8)	
}


object_leech = new editor_object(asset_get_index("spr_cl_right"), leech_id, leech_obj)
object_leech.draw_function = function(tile_state, i, j) {
	var xscale = tile_state.properties.dir == true ? -1 : 1
	draw_sprite_ext(tile_state.tile.spr_ind, ev_strobe_integer(2), j * 16 + 8, i * 16 + 8, xscale, 1, 0, c_white, draw_get_alpha())
}
maggot_sprite_down = asset_get_index("spr_cc_down");
maggot_sprite_up = asset_get_index("spr_cc_up");

object_maggot = new editor_object(maggot_sprite_down, maggot_id, maggot_obj, 0)
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
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
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

object_bull = new editor_object(asset_get_index("spr_cg_idle"), bull_id, bull_obj)
object_bull.draw_function = music_draw_function
object_gobbler = new editor_object(asset_get_index("spr_cs_right"), gobbler_id, gobbler_obj)
object_gobbler.draw_function = music_draw_function
object_hand = new editor_object(asset_get_index("spr_ch"), hand_id, hand_obj)
object_hand.draw_function = music_draw_function
object_mimic = new editor_object(asset_get_index("spr_cm_down"), mimic_id, mimic_obj)
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
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
		inst.editor_type = tile_state.properties.typ;
		return inst;
	}	
}

object_diamond = new editor_object(asset_get_index("spr_co_idle"), diamond_id, diamond_obj)
object_diamond.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, ev_strobe_fasttriplet_real(2), j * 16 + 8, i * 16 + 8)	
}

object_spider = new editor_object(asset_get_index("spr_ct_right"), spider_id, spider_obj)
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
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
		inst.set_e_direction = 3 - tile_state.properties.ang;
		return inst;
	}		
}

object_egg = new editor_object(asset_get_index("spr_boulder"), egg_id, egg_statue_obj)
object_egg.properties_generator = function() {
	return { txt : array_create(4, "") }	
}
object_egg.zed_function = function(tile_state) {
	new_window(10, 6, asset_get_index("obj_ev_egg_window"), 
	{ egg_properties : tile_state.properties })	
	global.mouse_layer = 1
}

object_egg.draw_function = function(tile_state, i, j) {
	default_draw_function(tile_state, i, j)
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
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
		with (inst) {
			var m;
			for (m = 0; m < 4; m++) {
				if tile_state.properties.txt[m] == ""
					break;
									
				count++
				text[m] = tile_state.properties.txt[m];
			}
			if m == 0
				break;
			special_message = -1
			voice = b_voice	
			moods = array_create(count, neutral)
			speakers = array_create(count, id)
		}
	}		
}


cif_sprite = asset_get_index("spr_atoner")
lamp_sprite = asset_get_index("spr_lamp")

object_cif = new editor_object(cif_sprite, cif_id, egg_statue_obj)
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
		var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
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
		place : method(self, function (tile_state, i, j) {
			var inst = instance_create_layer(j * 16 + 8, i * 16 + 8, tile_state.obj_layer, asset_get_index(tile_state.obj_name));
			inst.b_form = num
			return inst;
		}),
		num : b_form
	};
}	

object_add = new editor_object(asset_get_index("spr_voider"), add_id, egg_statue_obj)
object_add.iostruct = voidlord_io(8)
object_mon = new editor_object(asset_get_index("spr_greeder"), mon_id, egg_statue_obj)
object_mon.iostruct = voidlord_io(7)
object_tan = new editor_object(asset_get_index("spr_killer"), tan_id, egg_statue_obj)
object_tan.iostruct = voidlord_io(3)
object_lev = new editor_object(asset_get_index("spr_watcher"), lev_id, egg_statue_obj)
object_lev.iostruct = voidlord_io(1)
object_eus = new editor_object(asset_get_index("spr_lover"), eus_id, egg_statue_obj)
object_eus.iostruct = voidlord_io(6)
object_bee = new editor_object(asset_get_index("spr_smiler"), bee_id, egg_statue_obj)
object_bee.iostruct = voidlord_io(2)
object_gor = new editor_object(asset_get_index("spr_slower"), gor_id, egg_statue_obj)
object_gor.iostruct = voidlord_io(5)

object_secret_exit = new editor_object(asset_get_index("spr_barrier"), secret_exit_id, secret_exit_obj)
object_secret_exit.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, global.editor_time / 20, j * 16 + 8, i * 16 + 8)	
}
object_hungry_man = new editor_object(asset_get_index("spr_fam_u"), hungry_man_id, hungry_man_obj)
object_hungry_man.draw_function = music_draw_function





enum chest_items {
	locust,
	memory,
	wings,
	sword,
	empty,
	size // cool trick!
}


// we create the hologram sprite in real time
var hologram_surf = surface_create(16, 16)
surface_set_target(hologram_surf)
draw_sprite(asset_get_index("spr_boulder"), 0, 8, 8)
draw_sprite(asset_get_index("spr_question_black"), 8, 8, 8)
var hologram_sprite = sprite_create_from_surface(hologram_surf, 0, 0, 16, 16, false, false, 8, 8)
surface_reset_target()
surface_free(hologram_surf)
object_hologram = new editor_object(hologram_sprite, hologram_id, hologram_obj)

global.player_tiles = array_create(7)
global.player_objects = array_create(7)
for (var i = 0; i < 7; i++) {
	global.player_tiles[i] = i	
	global.player_objects[i] = i	
}


tiles_list = [tile_default, tile_glass, tile_bomb, tile_floorswitch, tile_copyfloor, tile_exit, 
	tile_deathfloor, tile_white, tile_wall, tile_edge, tile_chest]
	
objects_list = [object_player, object_leech, object_maggot, object_bull, object_gobbler, object_hand, 
	object_mimic, object_diamond, object_spider, object_egg, object_hologram, object_add, object_cif, object_lev, object_tan, object_mon, object_eus, 
	object_bee, object_gor, object_hungry_man, object_secret_exit]

global.music_names = ["", "msc_001", "msc_dungeon_wings", "msc_beecircle", "msc_dungeongroove", "msc_013",
	"msc_gorcircle_lo", "msc_levcircle", "msc_cifcircle", "msc_beesong", "msc_monstrail"]




function reset_everything() {
	global.tile_mode = false
	global.mouse_layer = 0
	global.selected_thing = -1 
	global.selected_placeable_num = 0
	
	global.level = new level_struct()

	global.level.objects[@ 4][6] = new tile_with_state(object_player)
	global.level.tiles[@ 2][6] = new tile_with_state(tile_exit)
	for (var i = 0; i < 3; i++) {
		for (var j = 0; j < 3; j++)
			global.level.tiles[@ 3 + i][5 + j] = new tile_with_state(tile_default)
	}
	

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
		case 1: return "snd_ev_music_monsday"
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

function preview_level_transition(lvl, display_instance) {
	global.mouse_layer = -1
	display_instance.layer = layer_get_id("HighlightedLevel")
	preview_transition = max_preview_transition
	preview_transition_display = display_instance
	preview_transition_highlight = instance_create_layer(0, 0, "LevelHighlight", asset_get_index("obj_ev_level_highlight"), {
		lvl : lvl,
		display_instance : display_instance,
		alpha : 0
	})
}

function play_level_transition(lvl, display_instance) {
	global.level = lvl;
	global.mouse_layer = -1
	play_transition = max_play_transition
	play_transition_display = display_instance
}

function edit_level_transition(lvl, display_instance) {
	global.level = lvl;
	ev_stop_music()
	edit_transition = max_edit_transition
	edit_transition_display = display_instance
	display_instance.draw_brand = false;
	global.mouse_layer = -1
}

// used in obj_ev_level_select, is essentially the level "page". we want this to be global so it persists
global.level_start = 0;


global.online_mode = false;


get_levels = noone
validate_levels = noone
online_levels_str = noone
	
global.online_levels = []
function try_update_online_levels() {
	get_levels = http_get(global.server);
}
startup_timeout = -1;

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

uploaded_levels = get_all_files(global.levels_directory, "key")
uploaded_keys = array_create(array_length(uploaded_levels), "")

for (var i = 0; i < array_length(uploaded_levels); i++) {
	var save_name = uploaded_levels[i] 
	var file = file_text_open_read(global.levels_directory + save_name + ".key")
	var key = file_text_read_string(file);
	uploaded_keys[i] = key;
	file_text_close(file)
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
		
	on_startup_finish()
}
function on_startup_finish() {
	get_levels = noone;
	validate_levels = noone;
	startup_timeout = 0;
	room_goto(asset_get_index("rm_ev_menu"))
}

global.startup_room = asset_get_index("rm_ev_startup")
global.playtesting = false;