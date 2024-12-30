children = []

function add_child(obj) {
	obj.window = id
	obj.layer_num = layer_num
	array_push(children, obj)	
}

function add_x_button() {
	var inst = instance_create_layer(x + image_xscale * 8 - 8, y - image_yscale * 8 + 8, "WindowElements", asset_get_index("obj_ev_close_window"))
	add_child(inst)	
}

if add_x {
	add_x_button()
}



selected_element = noone

element_object_index = asset_get_index("obj_ev_window_element")

function deselect(element) {
	if object_is_ancestor(element.object_index, element_object_index) {
		with (element)
			event_user(we_deselect_event)
	}	
	if element == selected_element
		selected_element = noone
}
function select(element) {
	if object_is_ancestor(element.object_index, element_object_index) {
		if (!element.is_selectable)
			return;
		with (element)
			event_user(we_select_event)
	}	
	selected_element = element;
}

function find_selected_element() {
	for (var i = 0; i < array_length(children); i++) {
		var child = children[i];
		if position_meeting(mouse_x, mouse_y, child) {
			
			if selected_element != noone {
				if child == selected_element
					return;
				deselect(selected_element)
			}
			
			select(child)
			return
		}
	}
	if selected_element != noone {
		deselect(selected_element)
		selected_element = noone
	}
		
}