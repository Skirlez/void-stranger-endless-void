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

enum ev_grube_types {
	gray_cube,
	lillie_cube,
	cif_cube,
	leech_cube,
	egg_cube,
	size,
}
phy_active = false;
fix = physics_fixture_create();
cube_size = 8;
physics_fixture_set_box_shape(fix, cube_size, cube_size);
physics_fixture_set_collision_group(fix, 1);
physics_fixture_set_density(fix, 0.5);
physics_fixture_set_restitution(fix, 0.6);
physics_fixture_set_angular_damping(fix, 0.1);
physics_fixture_set_linear_damping(fix, 0.1);
physics_fixture_set_friction(fix, 0.2);



player_cube = false;
hit_sprite = noone;

switch (type) {
	case ev_grube_types.gray_cube:
		sprite_index = agi("spr_player_down");
		hit_sprite = agi("spr_player_hit");
		player_cube = true;
		break;
	case ev_grube_types.lillie_cube:
		sprite_index = agi("spr_lil_down");
		hit_sprite = agi("spr_lil_hit");
		player_cube = true;
		break;
	case ev_grube_types.cif_cube:
		sprite_index = agi("spr_cif_down");
		hit_sprite = agi("spr_cif_hit");
		player_cube = true;
		break;
	case ev_grube_types.leech_cube:
		sprite_index = global.editor_instance.object_leech.spr_ind;
		break;
	case ev_grube_types.egg_cube:
		sprite_index = global.editor_instance.object_egg.spr_ind
		cube_size *= 1.5;
		image_xscale *= 1.5;
		image_yscale *= 1.5;
		physics_fixture_set_box_shape(fix, cube_size, cube_size);
		physics_fixture_set_restitution(fix, 0.3);
		break;
}
phy_active = true;
physics_fixture_bind(fix, id);

touched_leech_cube = false;
leech_sprite = global.editor_instance.object_leech.spr_ind;