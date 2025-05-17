// Object purpose: Managing things relating to the pack room, such as the camera and editor state.
// It also holds structs relating to nodes. It is created at the start of the game so these structs
// may be accessed outside the pack editor.

// There's some similar terminology used in the code, so I should write this down:

// Node instance - a GameMaker object instance associated with a node (like obj_ev_pack_music_node)
// These are the ones you actually see with your eyes.

// Node struct - a struct representing a node type. It has several instances, like brand_node.
// All instances of this struct are instantiated here.

// Node state - a struct that represents a node in the pack editor. (defined in ev_node_with_state) 

// Both node states and instances have some form of id, position, and list of exits 
// (outwards connections). There is one of each for each node a user creates in the editor.

global.pack_editor_instance = id;

previous_mouse_x = mouse_x;
previous_mouse_y = mouse_y;

dragging_camera = false;
zoom = 0;
enum pack_things {
	nothing,
	hammer,
	wrench,
	selector,
	play
}


select_tool_happening = new ev_happening();
function select(thing) {
	selected_thing = thing;
	select_tool_happening.trigger({ new_selected_thing : selected_thing })
}

selected_thing = pack_things.nothing;

menu_remember_x = 0;
menu_remember_y = 0;

judging_node = noone; // node currently being judged


function on_menu_create() {
	menu_remember_x = camera_get_view_x(view_camera[0])
	menu_remember_y = camera_get_view_y(view_camera[0])
	camera_set_view_pos(view_camera[0], 0, 0)	
	camera_set_view_size(view_camera[0], 224, 144)	
}
function on_menu_destroy() {
	calculate_zoom()
	camera_set_view_pos(view_camera[0], menu_remember_x, menu_remember_y)	
}

global.level_node_display_scale = 0.2;

zoom_factor = 1.2;

// since we want the zoom multiplier (zoom_factor^x)
// to be level_size, x would have to be log of zoom_factor(level_size)
zoom_level_needed_to_be_directly_on_level = logn(zoom_factor, global.level_node_display_scale); 

// last possible zoom level
// 224 * 1.2^zoom = room_width
// zoom = log1.2(room_width / 224) 
		
last_possible_zoom = floor(logn(1.2, 3360 / 224))

function calculate_zoom() {
	var mult = power(zoom_factor, zoom);
	
	var cam_width = 224 * mult;
	var cam_height = 144 * mult
	
	if (cam_width > room_width || cam_height > room_height) {

		zoom = last_possible_zoom
		calculate_zoom()
		return;
	}
	
	var previous_width = camera_get_view_width(view_camera[0])
	var previous_height = camera_get_view_height(view_camera[0])
	
	camera_set_view_size(view_camera[0], cam_width, cam_height)
	
	var change_x = 224 * mult - previous_width;
	var change_y = 144 * mult - previous_height;
	
	var cam_x = camera_get_view_x(view_camera[0])
	var cam_y = camera_get_view_y(view_camera[0])
	
	var mouse_uniform_x = window_mouse_get_x() / window_get_width()
	var mouse_uniform_y = window_mouse_get_y() / window_get_height()
	
	var target_x = clamp(cam_x - change_x * mouse_uniform_x, 0, room_width - cam_width)
	var target_y = clamp(cam_y - change_y * mouse_uniform_y, 0, room_height - cam_height)
	camera_set_view_pos(view_camera[0], target_x, target_y)	
}


play_transition_target = noone;
play_transition_time = -1;
function start_play_transition(target_node) {
	play_transition_time = 40;
	play_transition_target = target_node;
	remember_zoom = zoom;
	remember_camera_x = camera_get_view_x(view_camera[0])
	remember_camera_y = camera_get_view_y(view_camera[0])	
	var border = asset_get_index("obj_ev_pack_border")
	if instance_exists(border) && border.visible {
		border.toggle();
	}
	var border_hide_button = asset_get_index("obj_ev_pack_border_hide")
	if instance_exists(border_hide_button)
		border_hide_button.visible = false;
}

	
// read node properties from string
default_reader = function (properties_str /*, version */) {
	return { value : global.empty_struct, offset : 0 };
}
// write node properties to string
default_writer = function (node_state, node_index_map) {
	return "";
}


function get_node_state_from_instance(node_inst) {
	return new node_with_state(node_inst.node_type, node_inst.x, node_inst.y, node_inst.properties)
}


enum node_flags {
	none = 0,
	// cannot be removed
	unremovable = 1,
	// if set, you cannot place more than 1 of this node type
	only_one = 2,
}


global.id_node_map = ds_map_create()
global.object_node_map = ds_map_create()
function node_struct(node_id, object_name, flags = 0, layer_name = "Nodes") constructor {
	self.node_id = node_id;
	global.id_node_map[? node_id] = self;
	self.object_ind = agi(object_name);
	global.object_node_map[? object_ind] = self;
	
	self.layer_name = "Nodes";

	self.properties_generator = global.editor_instance.return_noone;
	self.properties = {};
	
	self.read_function = global.pack_editor_instance.default_reader;
	self.write_function = global.pack_editor_instance.default_writer;


	// called when wrench is used
	// params: (node_instance)
	self.on_config = global.editor_instance.empty_function;
	
	self.on_death = function (node_instance) {
		audio_play_sound(agi("snd_ev_node_destroy"), 10, false, global.pack_zoom_gain, 0, random_range(0.9, 1.1))
		create_node_shards(node_instance)		
	}
	
	// what to do when evaluated while playing
	// nodes that use this function can immediately tell you where to go in the pack
	// if they can't, returns noone
	self.play_evaluate_immediate = function () {
		return noone;	
	};
	
	// runs after room restart
	// used by nodes that can't immediately tell you where to go in the pack,
	// like levels, since they have to wait for you to complete the level
	// doesn't return anything
	self.play_evaluate = global.editor_instance.empty_function;
	
	self.flags = flags;
}

root_node = new node_struct("ro", "obj_ev_pack_root", node_flags.unremovable);
root_node.play_evaluate_immediate = function (node_state) {
	return node_state.exits[0];
};
brand_node = new node_struct("br", "obj_ev_pack_brand_node");
brand_node.properties_generator = function () {
	return { brand : int64(irandom_range(1, $FFFFFFFFF)) }	
}
brand_node.read_function = function (properties_str /*, version */) {
	var brand = int64_safe(properties_str, 0);
	return { brand : brand }; 
}
brand_node.write_function = function (properties) {
	return string(properties.brand)
}
brand_node.on_config = function (node_instance) {
	global.mouse_layer = 1;
	new_window_with_pos(node_instance.x, node_instance.y, 5, 5, asset_get_index("obj_ev_brand_node_window"), {
		node_instance : node_instance
	});
}
brand_node.play_evaluate_immediate = function (node_state) {
	return node_state.exits[0];	
}


level_node = new node_struct("lv", "obj_ev_pack_level_node");
level_node.properties_generator = function () {
	return noone; // if this is called something went wrong
}
level_node.read_function = function (properties_str /*, version */) {
	var level = import_level(properties_str)
	return { level : level }; 
}
level_node.write_function = function (properties) {
	return export_level(properties.level)
}
level_node.play_evaluate_immediate = function (node_state) {
	return noone;
}
level_node.play_evaluate = function (node_state) {
	global.level = node_state.properties.level;
	ev_set_play_variables(true)
	ev_prepare_level_visuals(global.level)
	ev_place_level_instances(global.level)
	with (agi("obj_ev_pack_player")) {
		if is_first_level {
			instance_create_layer(x, y, "Effects", agi("obj_darkness_begins"))
			is_first_level = false;
		}
		evaluate_brand_room();
		
	}
}
level_node.on_config = function (node_instance) {
	global.mouse_layer = 1;
	new_window_with_pos(node_instance.x, node_instance.y, 10, 7, asset_get_index("obj_ev_level_node_window"), {
		node_instance : node_instance
	});
}
level_node.on_death = function(node_instance) {
	node_instance.display.destroy();	
}

redirect_node = new node_struct("re", "obj_ev_pack_redirect_node");
redirect_node.play_evaluate_immediate = function (node_state) {
	return node_state.exits[0];	
}


music_node = new node_struct("mu", "obj_ev_pack_music_node");
music_node.properties_generator = function () {
	return { music : "" }	
}
music_node.read_function = function (properties_str /*, version */) {
	return { music : base64_decode(properties_str) }; 
}
music_node.write_function = function (properties) {
	return base64_encode(properties.music)
}
music_node.write_struct_function = function (node_state, node_id) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "Nodes", node_state.node.object_ind, 
		{ music : node_state.properties.music, node_id : node_id })
}
music_node.on_config = function (node_instance) {
	global.mouse_layer = 1;
	new_window_with_pos(node_instance.x, node_instance.y, 6, 6, asset_get_index("obj_ev_music_node_window"), {
		node_instance : node_instance
	});
}
music_node.play_evaluate_immediate = function (node_state) {
	ev_play_music(agi(node_state.properties.music), true, false)
	return node_state.exits[0];	
}

branefuck_node = new node_struct("bf", "obj_ev_pack_branefuck_node");
branefuck_node.properties_generator = function () {
	return { program : "" }	
}
branefuck_node.read_function = function (properties_str /*, version */) {
	return { program : properties_str }; 
}
branefuck_node.write_function = function (properties) {
	return string(properties.program)
}
branefuck_node.write_struct_function = function (node_state, node_id) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "Nodes", node_state.node.object_ind, 
		{ program : node_state.properties.program, node_id : node_id })
}
branefuck_node.on_config = function (node_instance) {
	global.mouse_layer = 1;
	new_window_with_pos(node_instance.x, node_instance.y, 10, 6, asset_get_index("obj_ev_branefuck_node_window"), {
		node_instance : node_instance
	});
}
branefuck_node.play_evaluate_immediate = function(node_state) {
	var program = string_to_array(node_state.properties.program);
	
	var return_value = execute_branefuck(program, undefined);
	if return_value == undefined {
		ev_notify("Branefuck node errored!")
		return_value = 1
	}
	var index = clamp(return_value, 1, array_length(node_state.exits)) - 1
	return node_state.exits[index];
	
}

thumbnail_node = new node_struct("tn", "obj_ev_pack_thumbnail_node", node_flags.only_one);
random_node = new node_struct("ct", "obj_ev_pack_random_node");
random_node.play_evaluate_immediate = function (node_state) {
	var rand = irandom_range(0, array_length(node_state.exits) - 1)
	return node_state.exits[rand];
};

comment_node = new node_struct("cm", "obj_ev_pack_comment_node");
comment_node.properties_generator = function () {
	return { comment : "" }	
}
comment_node.read_function = function (properties_str /*, version */) {
	return { comment : base64_decode(properties_str) }; 
}
comment_node.write_function = function (properties) {
	return base64_encode(properties.comment)
}
comment_node.on_config = function (node_instance) {
	global.mouse_layer = 1;
	new_window_with_pos(node_instance.x, node_instance.y, 10, 6, asset_get_index("obj_ev_comment_node_window"), {
		node_instance : node_instance
	});
}

oob_node = new node_struct("ob", "obj_ev_pack_oob_node", node_flags.only_one);
oob_node.play_evaluate_immediate = function (node_state) {
	return node_state.exits[0];	
}
end_node = new node_struct("en", "obj_ev_pack_end_node");
end_node.play_evaluate = function () {
	instance_create_layer(0, 0, "Text", agi("obj_ev_pack_end"))
	// TODO display end screen
}
// List of all the nodes a user should be able to create
nodes_list = [redirect_node, music_node, random_node, comment_node, thumbnail_node, 
				oob_node, branefuck_node, brand_node, end_node];


function reset_global_pack() {
	var pack = new pack_struct();
	place_default_nodes(pack)
	global.pack = pack;
}
reset_global_pack();

global.pack_zoom_gain = 1;



// NID/node ID used to identify nodes for undos, this keeps track of the last node ID
last_nid = -1;
node_id_to_instance_map = ds_map_create()


// maps NIDs to node states for remembering node IDs after playing/returning from playing
node_state_to_id_map = ds_map_create()

function add_undo_action(func, args) {
	array_push(undo_actions, {
		func : func,
		args : args,
	})
}

undo_actions = []

function undo() {
	static undo_sound = agi("snd_voidrod_place")
	if array_length(undo_actions) != 0 {
		var action = array_pop(undo_actions)
		action.func(action.args)
		audio_play_sound(undo_sound, 10, false)
		
	}
}

undo_repeat = -1
undo_repeat_frames_start = 18
undo_repeat_frames_speed = 0
undo_repeat_frames_max_speed = 10

in_pack_editor = false;

