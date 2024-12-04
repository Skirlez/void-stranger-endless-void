spin_time_h = 0
spin_time_v = 0
follow = false
history_size = 3
position_history = array_create(history_size * 2)

for (var i = 0; i < array_length(position_history) - 1; i += 2) {
	position_history[i] = x;
	position_history[i + 1] = y;
}

last_y_ind = history_size * 2 - 1;
last_x_ind = history_size * 2 - 2;

death_sound = noone
death_timer = -1;
function die() {
	phy_active = false;
	death_timer = 0
	layer = layer_get_id("Explosion")
	death_sound = audio_play_sound(asset_get_index("snd_ex_vacuumcomes"), 10, false, 1.3, 0, 1.2)
}

sprite_index = global.editor_instance.object_player.spr_ind;