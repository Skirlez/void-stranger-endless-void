
#macro compiled_for_merge false

if (!compiled_for_merge) {
	var ratio = display_get_height() / 144	
	surface_resize(application_surface, 244 * ratio, 144 * ratio)
}

window_set_cursor(cr_default)

global.editor_time = 0

#macro thing_cursor 0
#macro thing_eraser 1
#macro thing_placeable 2
global.selected_thing = thing_cursor // cursor
global.selected_placeable_num = 0

#macro flag_unremovable 1

global.editor_object = asset_get_index("obj_ev_editor");
global.display_object = asset_get_index("obj_ev_display");

global.selection_sprite = asset_get_index("spr_ev_selection")
global.circle_sprite = asset_get_index("spr_ev_selected_circle");

return_noone = function() {
	return noone;
}

default_draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8)	
}

function editor_placeable(spr_ind, tile_id, flags = 0) constructor {
    self.spr_ind = spr_ind
	self.flags = flags
	self.pre_draw_function = noone
	self.draw_function = global.editor_object.default_draw_function
	self.zed_function = noone
	self.tile_id = tile_id;
	self.properties_generator = global.editor_object.return_noone
} 



floor_sprite = asset_get_index("spr_floor");

#macro glass_id "gl"
#macro mine_id "mn"
#macro default_tile_id "fl"
#macro exit_id "ex"

#macro player_id "pl"
#macro leech_id "cl"
#macro maggot_id "cc"
#macro bull_id "cg"
#macro gobbler_id "cg"


tile_glass = new editor_placeable(asset_get_index("spr_glassfloor"), glass_id)
tile_mine = new editor_placeable(asset_get_index("spr_bombfloor"), mine_id)
tile_default = new editor_placeable(floor_sprite, default_tile_id)
tile_exit = new editor_placeable(asset_get_index("spr_stairs"), exit_id)

var solid_pre_draw_function = function(tile_state, i, j) {
	if (i == 7)
		return;
	var below_tile_state = level_tiles[i + 1][j];

	if below_tile_state == noone || below_tile_state.tile == tile_glass
		draw_sprite(floor_sprite, 1, j * 16  + 8, (i + 1) * 16 + 8)
}


tile_default.pre_draw_function = solid_pre_draw_function
tile_mine.pre_draw_function = solid_pre_draw_function
tile_exit.pre_draw_function = solid_pre_draw_function

object_player = new editor_placeable(asset_get_index("spr_player_down"), player_id, flag_unremovable)



object_leech = new editor_placeable(asset_get_index("spr_cl_right"), leech_id, 0)
object_leech.draw_function = function(tile_state, i, j) {
	var xscale = tile_state.properties.dir == true ? 1 : -1
	draw_sprite_ext(tile_state.tile.spr_ind, 0, j * 16 + 8, i * 16 + 8, xscale, 1, 0, c_white, draw_get_alpha())
}


maggot_sprite_down = asset_get_index("spr_cc_down");
maggot_sprite_up = asset_get_index("spr_cc_up");

object_maggot = new editor_placeable(maggot_sprite_down, maggot_id, 0)
object_maggot.draw_function = function(tile_state, i, j) {
	draw_sprite(tile_state.properties.dir == true ? maggot_sprite_down : maggot_sprite_up, 0, j * 16 + 8, i * 16 + 8)
}

var directioned_zed_function = function(tile_state) {
	tile_state.properties.dir = !tile_state.properties.dir
}
var directioned_properties = function() {
	return { dir : true	}
}

object_leech.zed_function = directioned_zed_function
object_leech.properties_generator = directioned_properties
object_maggot.zed_function = directioned_zed_function
object_maggot.properties_generator = directioned_properties



object_bull = new editor_placeable(asset_get_index("spr_cg_idle"), bull_id, 0)
object_gobbler = new editor_placeable(asset_get_index("spr_cs_right"), gobbler_id, 0)



tiles_list = [tile_default, tile_glass, tile_mine, tile_exit]
objects_list = [object_leech, object_maggot, object_bull, object_gobbler]




level_tiles = array_create(8)
for (var i = 0; i < array_length(level_tiles); i++)
	level_tiles[i] = array_create(14, new tile_with_state(tile_default))	

level_objects = array_create(8)
for (var i = 0; i < array_length(level_objects); i++)
	level_objects[i] = array_create(14, noone)	

level_objects[5][5] = new tile_with_state(object_player)
