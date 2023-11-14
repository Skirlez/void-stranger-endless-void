event_inherited()


for (var i = 0; i < array_length(children); i++) {
	var child = children[i]
	if child == selected_element
		child.depth = elements_depth - 1
	else
		child.depth = elements_depth
}
