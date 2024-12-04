
if death_timer != -1 {
	death_timer++
	
	if death_timer > 140 || !audio_is_playing(death_sound) {
		audio_stop_sound(death_sound)
		audio_play_sound(asset_get_index("snd_ex_enemyexplosion_009"), 0, false, 0.8)
		for (var i = 0; i < array_length(window.grubes); i++) {
			var grube = window.grubes[i]
			if !instance_exists(grube)
				continue;
			if grube == id
				continue;
			
			
			

			var length = point_distance(x, y, grube.x, grube.y)
			var angle = point_direction(x, y, grube.x, grube.y)
			
			
			var cutoff = 240
			var max_force = 10;
			
			if (length > cutoff)
				continue;
			
			var effect = (cutoff - length) / cutoff;
			
			grube.phy_speed_x = dcos(angle) * effect * max_force;
			grube.phy_speed_y = -dsin(angle) * effect * max_force;
				
		}
		instance_create_layer(x, y, "Explosion", asset_get_index("obj_ev_after_erase"), {
			grube : true	
		})
		instance_destroy(id)
	}
	
	return;	
}

if ev_is_mouse_on_me() {
	if ev_mouse_pressed() {
		follow = true
		if instance_exists(asset_get_index("obj_ev_plucker")) {
			audio_play_sound(asset_get_index("snd_ev_pluck"), 10, false)	
		}
	}
	if ev_mouse_right_pressed() {
		die()
		death_timer = 50
	}
}
if ev_mouse_released() && follow {
	follow = false;
	var previousest_x = position_history[last_x_ind]
	var previousest_y = position_history[last_y_ind]
	
	phy_speed_x = (mouse_x - previousest_x) / history_size
	phy_speed_y = (mouse_y - previousest_y) / history_size

}

if follow {
	phy_speed_x = 0
	phy_speed_y = 0

	phy_speed_x = mouse_x - phy_position_x
	phy_speed_y = mouse_y - phy_position_y


}

if x < 0 || x > room_width || y > room_height
	instance_destroy(id)

for (var i = array_length(position_history) - 1; i > 1; i -= 2) {
	position_history[i - 1] = position_history[i - 3]
	position_history[i] = position_history[i - 2];
}

if follow {
	position_history[0] = mouse_x;
	position_history[1] = mouse_y;
}
position_history[0] = phy_position_x;
position_history[1] = phy_position_y;
