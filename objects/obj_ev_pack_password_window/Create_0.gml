event_inherited();

password_brand = instance_create_layer(x, y, "WindowElements", agi("obj_ev_make_brand"), {
	brand : int64(0)
})

check = instance_create_layer(x, y + 35, "WindowElements", agi("obj_ev_executing_button"), 
{
	password_brand : password_brand,
	nodeless_pack : nodeless_pack,
	func : function () {
		if password_brand.brand == nodeless_pack.password_brand {
			audio_play_sound(agi("snd_ev_mark_placechanger"), 10, false, 1, 0, 1.2)
			save_pack_password(nodeless_pack)
			instance_destroy(window)
			ev_notify("Password match!")
		}
		else {
			audio_play_sound(agi("snd_player_damage"), 10, false);
			ev_notify("Wrong password!")
		}
	},
	txt : "Check",
	base_scale_y : 0.7,
	base_scale_x : 1.2,
})
add_child(check)

add_child(password_brand)