// Object purpose: Managing things relating to the pack room, such as the camera and editor state.
// It also holds structs relating to nodes.
// There's some similar terminology used in the code, so I should write this down:

// Node instance - a GameMaker object instance associated with a node (like obj_ev_pack_music_node)

// Node struct - a struct representing a node type. It has several instances, like brand_node.
// All instances of this struct are instantiated here.

// Node state - a struct that represents a node in the pack editor. (defined in ev_node_with_state) 


// Both node states and instances have some form of id, position, and list of exits 
// (outwards connections). There is one of each for each node a user creates in the editor.


destinations = ds_map_create()

previous_mouse_x = mouse_x;
previous_mouse_y = mouse_y;

dragging_camera = false;

zoom = 0;


// for development...
//ev_play_music(asset_get_index("msc_beecircle"))

enum pack_things {
	nothing,
	hammer,	
	selector,
}


select_tool_event = new ev_event();
function select(thing) {
	selected_thing = thing;
	select_tool_event.trigger({ new_selected_thing : selected_thing })
}

selected_thing = pack_things.nothing;

menu_remember_x = 0;
menu_remember_y = 0;

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

function calculate_zoom() {
	var zoom_factor = 1.2;
	var mult = power(zoom_factor, zoom);
	
	var cam_width = 224 * mult;
	var cam_height = 144 * mult
	
	if (cam_width > room_width || cam_height > room_height) {
		// go to last possible zoom level
		// 224 * 1.2^zoom = room_width
		// zoom = log1.2(room_width / 224) 
		
		zoom = floor(logn(1.2, room_width / 224))
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
	
	
	var mouse_uniform_x = display_mouse_get_x() / display_get_width()
	var mouse_uniform_y = display_mouse_get_y() / display_get_height()
	
	var target_x = clamp(cam_x - change_x * mouse_uniform_x, 0, room_width - cam_width)
	var target_y = clamp(cam_y - change_y * mouse_uniform_y, 0, room_height - cam_height)
	camera_set_view_pos(view_camera[0], target_x, target_y)	
}





// read node properties from instance
default_instance_reader = function (inst) {
	return global.empty_struct;
}
// read node properties from string
default_reader = function (properties_str /*, version */) {
	return { value : global.empty_struct, offset : 0 };
}
// write node properties to string
default_writer = function (node_state, node_index_map) {
	return "";
}
// create node instance from node state and return the instance
default_instance_writer = function (node_state) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "Nodes", node_state.node.object_ind);
}


function get_node_state_from_instance(node_inst) {
	var node = global.object_node_map[? node_inst.object_index]
	var properties = node.read_instance_function(node_inst);
	
	return new node_with_state(node, node_inst.x, node_inst.y, properties)
}


global.id_node_map = ds_map_create()
global.object_node_map = ds_map_create()
function node_struct(node_id, object_name) constructor {
	self.node_id = node_id;
	global.id_node_map[? node_id] = self;
	self.object_ind = asset_get_index(object_name);
	global.object_node_map[? object_ind] = self;
	
	self.properties_generator = global.editor_instance.return_noone;
	self.properties = {};
	
	
	self.read_function = pack_editor_inst().default_reader;
	self.read_instance_function = pack_editor_inst().default_instance_reader;
	self.write_function = pack_editor_inst().default_writer;
	self.write_instance_function = pack_editor_inst().default_instance_writer;
}



root_node = new node_struct("ro", "obj_ev_pack_root");

brand_node = new node_struct("br", "obj_ev_pack_brand_node");
brand_node.properties_generator = function () {
	return { brand : global.author.brand }	
}
brand_node.read_function = function (properties_str /*, version */) {
	var brand = int64_safe(properties_str, 0);
	return { brand : brand }; 
}
brand_node.read_instance_function = function (inst) {
	return { brand : inst.brand }
}
brand_node.write_function = function (node_state) {
	return string(node_state.properties.brand)
}
brand_node.write_instance_function = function (node_state) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "Nodes", node_state.node.object_ind, 
		{ brand : node_state.properties.brand })
}

level_node = new node_struct("lv", "obj_ev_display");
level_node.properties_generator = function () {
	return { lvl : new level_struct() }	
}
level_node.read_function = function (properties_str /*, version */) {
	var level = import_level(properties_str)
	return { level : level }; 
}
level_node.read_instance_function = function (node_inst) {
	return { level : node_inst.lvl } 
}
level_node.write_function = function (node_state) {
	return export_level(node_state.properties.level)
}
level_node.write_instance_function = function (node_state) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "PackLevels", node_state.node.object_ind, 
	{ 
		lvl : node_state.properties.level,
		draw_beaten : false,
		no_spoiling : false,
		display_context : display_contexts.pack_editor,
		image_xscale : 0.2,
		image_yscale : 0.2
	})
}

music_node = new node_struct("mu", "obj_ev_pack_music_node");
music_node.properties_generator = function () {
	return { music : "" }	
}
music_node.read_function = function (properties_str /*, version */) {
	return { music : base64_decode(properties_str) }; 
}
music_node.read_instance_function = function (inst) {
	return { music : inst.music }
}
music_node.write_function = function (node_state) {
	return string(node_state.properties.music)
}
music_node.write_instance_function = function (node_state) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "Nodes", node_state.node.object_ind, 
		{ music : node_state.properties.music })
}

branefuck_node = new node_struct("bf", "obj_ev_pack_branefuck_node");
branefuck_node.properties_generator = function () {
	return { program : "" }	
}
branefuck_node.read_function = function (properties_str /*, version */) {
	return { program : base64_decode(properties_str) }; 
}
branefuck_node.read_instance_function = function (inst) {
	return { program : inst.program }
}
branefuck_node.write_function = function (node_state) {
	return string(node_state.properties.program)
}
branefuck_node.write_instance_function = function (node_state) {
	return instance_create_layer(node_state.pos_x, node_state.pos_y, "Nodes", node_state.node.object_ind, 
		{ program : node_state.properties.program })
}

thumbnail_node = new node_struct("tn", "obj_ev_pack_thumbnail_node");




// List of all the nodes a user should be able to create
nodes_list = [brand_node, music_node, branefuck_node, thumbnail_node];
