event_inherited()

grube_mode = false
grube_button = instance_create_layer(200, 30, "WindowElements", asset_get_index("obj_ev_executing_button"), {
	txt : "Grube",
	base_scale_x : 1.2,
	base_scale_y : 0.9,
	count : 0,
	func : function () {
		var grube = instance_create_layer(200 + irandom_range(-20, 20), y + 42, "Grube", asset_get_index("obj_ev_grube"))
		grube.window = window;
		array_push(window.grubes, grube)
		count++;
		if count == 5 {
			window.grube_mode = true;
			
			if global.compiled_for_merge {
				audio_sound_gain(global.music_inst, 0, 1000)
				global.music_inst = noone
				ev_play_music(asset_get_index("msc_stg_extraboss"))
				audio_sound_gain(global.music_inst, 0, 0)
				audio_sound_gain(global.music_inst, 1, 1000)
				
			}
			else {
				audio_sound_gain(global.music, 0, 1000)
				global.music = noone
				ev_play_music(asset_get_index("msc_stg_extraboss"))
				audio_sound_gain(global.music, 0, 0)
				audio_sound_gain(global.music, 1, 1000)
			}
		
			instance_create_layer(mouse_x, mouse_y, "Plucker", asset_get_index("obj_ev_plucker"))
			
			with (window) {
				var t = instance_create_layer(200, 72, "Textbox", asset_get_index("obj_ev_textbox"), {
					opened_x : 112,
					opened_y : 72,
					txt : "Stack the grubes!\nLeft click to grab, right click to destroy. " 
						+ "You can scroll with the scroll wheel or the up/down keys."
						+ "\nCAREFUL: Grubes under too much pressure may be destroyed...\n"
						+ "Try to keep a modest amount."
					,
					layer_num : 0,
					allow_deletion : false,
					char_limit : 0,
				})
				add_child(t)
			}
		}
		

	}
})
add_child(grube_button)

max_stack = 0;
grubes = []
dense_check_timer_max = 2;
dense_check_timer = dense_check_timer_max;

highest_stack = global.highest_grube_stack;
timer_hold_highest_stack_max = 300;
timer_hold_highest_stack = 0;
potential_new_highest_stack = 0;

scroll_accel = 0;