event_inherited();

for (var i = 0; i < array_length(children); i++) {
	var child = children[i]
	if child.object_index != asset_get_index("obj_ev_textbox")
		continue;
	if child == selected_element
		child.depth = elements_depth - 2
	else if child.size_time != 0
		child.depth = elements_depth - 1
	else
		child.depth = elements_depth
}

if keyboard_check_pressed(ord("T")) {
	instance_create_depth(x, y, depth, agi("obj_ev_branefucker"), {
		add_inst : noone,
		input_1_str : input_1_text.txt,
		input_2_str : input_2_text.txt,
		destroy_value_str : destroy_value_text.txt,
		program_str : program_text.txt,	
	});
}