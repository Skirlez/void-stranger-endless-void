if in_brand_room && instance_exists(brand_secret_exit) {
	var brand_found = false;
	if !instance_exists(agi("obj_exit")) {
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
		for (var i = 0; i < array_length(brand_node_states); i++) {
			var node_state = brand_node_states[i];
			if (node_state.properties.brand == brand) {
				dust_emit_counter++;
				if dust_emit_counter > dust_emit_limit {
					var dp_amount = irandom_range(10, 14)
					for (var j = 0; j < dp_amount; j++) {
						var dp_x = irandom_range(-16, 32)
						var dp_x2 = irandom_range(192, 240)
						var dp_y = irandom_range(10, 14)
						instance_create_depth(dp_x, (dp_y * j), 50, agi("obj_dustparticle"))
						instance_create_depth(dp_x2, (dp_y * j), 50, agi("obj_dustparticle"))
					}
					dust_emit_counter = 0;
					dust_emit_limit = irandom_range(128, 144)
				}
				with (agi("obj_player")) {
					other.brand_secret_exit.x = x
					other.brand_secret_exit.y = y
				}
				brand_secret_exit.exit_brand = brand;
				brand_found = true;
				break;
			}
		}
	
	}
	if !brand_found && (brand_secret_exit.x != -100 || brand_secret_exit.y != -100) {
		brand_secret_exit.x = -100;
		brand_secret_exit.y = -100;
		dust_emit_counter = 0;
		dust_emit_limit = 0;
		if instance_exists(agi("obj_dustparticle")) {
			instance_destroy(agi("obj_dustparticle"))	
		}
	}
	
	
}