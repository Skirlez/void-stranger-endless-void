event_inherited();



are_you_sure_text = "Are you sure you want to\n upload this" + ((irandom($7fffffffffffffff) == 40) ? " stupid " : " ") + "level?"
uploading_text = "Uploading..."
done_text = "Done!\nYour level is now on\nthe server!"
fail_text = "There was an error\ncommunicating with the server\n):"

manage_text = "This level is already\nuploaded. What would you\nlike to do?"


if array_contains(global.uploaded_keys, lvl.save_name)
	state = 4
else {
	state = 0
	var no = instance_create_layer(112 + 30, 72 + 30, "WindowElements", asset_get_index("obj_ev_executing_button"), {
		txt : "No",
		base_scale_x : 0.8,
		base_scale_y : 0.6,
		layer_num : global.mouse_layer,
		func : function() {
			instance_destroy(window)
		}
	})

	var yes = instance_create_layer(112 - 30, 72 + 30, "WindowElements", asset_get_index("obj_ev_executing_button"), {
		txt : "Yes",
		base_scale_x : 0.7,
		base_scale_y : 0.6,
		layer_num : global.mouse_layer,
		func : function() {
			window.start_uploading();
		}
	})

	add_child(no)
	add_child(yes)	
	
}
upload_timeout = 0


function start_uploading() {
	state = 1;
	upload_timeout = 300
	selected_element = noone;
	for (var i = 0; i < array_length(children); i++) {
		instance_destroy(children[i]);	
	}
	children = []
	
	var lvl_str = export_level(lvl);
	post_level = http_post_string(global.server, lvl_str)
}

function create_finish_buttons(ok_text) {
	var ok = instance_create_layer(112, 72 + 30, "WindowElements", asset_get_index("obj_ev_executing_button"), {
		txt : ok_text,
		base_scale_x : 2.5,
		base_scale_y : 0.6,
		layer_num : global.mouse_layer,
		func : function() {
			instance_destroy(window)
		}
	});
	add_child(ok);
	add_x_button()
}
function on_fail() {
	state = 3
	post_level = noone
	create_finish_buttons("Oh damn")
}

function on_finish(key) {
	state = 2
	create_finish_buttons("Okay thanks") 
	global.editor_instance.try_update_online_levels();
	var keyfile = file_text_open_write(global.levels_directory + lvl.save_name + ".key")
	file_text_write_string(keyfile, key)
	file_text_close(keyfile)
	
}