if in_brand_room && !instance_exists(agi("obj_exit")) {
	var brand = int64(0)
	for (var i = 1; i <= 6; i++) {
		for (var j = 4; j <= 9; j++) {
			var instance = instance_position(j * 16 + 8, i * 16 + 8, agi("obj_floor_tile"))
			if instance_exists(instance) {
				var bit_index = (j - 4) + (i - 1) * 6
				brand |= (1 << bit_index)
			}
		}
	}
	log_info($"Current brand: {brand}")
	for (var i = 0; i < array_length(brand_node_states); i++) {
		var node_state = brand_node_states[i];
		log_info($"node brand: {node_state.properties.brand}")
		if (node_state.properties.brand == brand) {
			log_info("brand match")
		}
	}
}