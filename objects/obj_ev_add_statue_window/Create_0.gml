event_inherited();
mode = add_properties.mde;
program_text = noone;


function add_mode_switch_button(mode) {
	mode_button = instance_create_layer(112, 72 + 40, "WindowElements", asset_get_index("obj_ev_executing_button"), {
		txt : mode == 0 ? "Nothing" : (mode == 1 ? "Simple" : "BRANEFUCK"),
		base_scale_y : 0.6,
		base_scale_x : mode == 0 ? 1.55 : (mode == 1 ? 1.35 : 2.5),
		func : function () {
			with (window) {
				var prev_mode = mode
				mode++;
				if mode > 2
					mode = 0;
				reset_window(prev_mode, mode);
				create_base_buttons(mode)
			}
		},
		layer_num : 1,
	})
	add_child(mode_button);
}

function reset_window(prev_mode, new_mode) {
	selected_element = noone;
	save_add(prev_mode)
	
	for (var i = 0; i < array_length(children); i++) {
		instance_destroy(children[i]);	
	}
	children = []	
	add_x_button()
	add_mode_switch_button(new_mode)
	
}

function create_base_buttons(mode) {
	if mode == 0
		return;
	if mode == 1 {
		input_1_text = instance_create_layer(112, 72 - 40, "WindowElements", asset_get_index("obj_ev_textbox"), {
			empty_text : "Input",
			txt : add_properties.in1,
			exceptions : "_-",
			base_scale_x : 2.5,
			allow_newlines : false,
		})
		add_child(input_1_text)
		destroy_value_text = instance_create_layer(112, 72 - 20, "WindowElements", asset_get_index("obj_ev_textbox"), {
			empty_text : "Destroy Value",
			txt : add_properties.val,
			exceptions : "_-",
			base_scale_x : 6,
			allow_newlines : false,
		})
		add_child(destroy_value_text)	
	}
	else {
		input_1_text = instance_create_layer(112 - 32, 72 - 40, "WindowElements", asset_get_index("obj_ev_textbox"), {
			empty_text : "Input 1",
			txt : add_properties.in1,
			exceptions : "_-",
			base_scale_x : 3.5,
			allow_newlines : false,
		})
		add_child(input_1_text)
		input_2_text = instance_create_layer(112 + 32, 72 - 40, "WindowElements", asset_get_index("obj_ev_textbox"), {
			empty_text : "Input 2",
			txt : add_properties.in2,
			exceptions : "_-",
			base_scale_x : 3.5,
			allow_newlines : false,
		})
		add_child(input_2_text)
		program_text = instance_create_layer(112, 72 - 20, "WindowElements", asset_get_index("obj_ev_textbox"), {
			empty_text : "Branefuck Program",
			txt : add_properties.pgm,
			allow_alphanumeric : false,
			exceptions : global.branefuck_characterset,
			char_limit : 260,
			opened_y : 72,
			base_scale_x : 8,
		})
		add_child(program_text)
		destroy_value_text = instance_create_layer(112, 72, "WindowElements", asset_get_index("obj_ev_textbox"), {
			empty_text : "Destroy Value",
			txt : add_properties.val,
			exceptions : "_-",
			base_scale_x : 6,
			allow_newlines : false,	
		})
		add_child(destroy_value_text)
	}
}


create_base_buttons(mode)
add_mode_switch_button(mode);

elements_depth = layer_get_depth("WindowElements")

function save_add(mode) {
	add_properties.mde = mode;
	if mode == 1 {
		add_properties.in1 = input_1_text.txt;
		add_properties.val = destroy_value_text.txt;
	}
	else if mode == 2 { 
		add_properties.in1 = input_1_text.txt;
		add_properties.in2 = input_2_text.txt;
		add_properties.val = destroy_value_text.txt;
		add_properties.pgm = program_text.txt;
	}
	
}