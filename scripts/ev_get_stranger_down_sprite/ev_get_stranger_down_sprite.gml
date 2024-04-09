
function ev_get_stranger_down_sprite(stranger){
	static gray = asset_get_index("spr_player_down")
	static lil = asset_get_index("spr_lil_down")
	static cif = asset_get_index("spr_cif_down")
	static lev = asset_get_index("spr_lev_d")		
	static lily = asset_get_index("spr_ev_lily_down")
	static ninnie = asset_get_index("spr_ev_ninnie")
	static bee = asset_get_index("spr_ev_bee_down")		
	switch (stranger) {
		case 0: return gray
		case 1: return lil
		case 2: return cif
		case 4: return lev				
		case 5: return lily
		case 6: return ninnie
		case 7: return bee		
		default: return gray
	}	
}