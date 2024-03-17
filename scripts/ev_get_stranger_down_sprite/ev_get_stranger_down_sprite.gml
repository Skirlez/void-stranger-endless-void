
function ev_get_stranger_down_sprite(stranger){
	static gray = asset_get_index("spr_player_down")
	static lil = asset_get_index("spr_lil_down")
	static lily = asset_get_index("spr_ev_lily_down")
	static ninnie = asset_get_index("spr_ev_ninnie")
	switch (stranger) {
		case 0: return gray
		case 1: return lil
		case 5: return lily
		case 6: return ninnie
		default: return gray
	}	
}