
function ev_get_burden_sprite(burden_style){
	static add = asset_get_index("spr_items")
	static cif = asset_get_index("spr_items_cif")
	static lev = asset_get_index("spr_items_special")		
	static one = asset_get_index("spr_ev_items_one")
	static two = asset_get_index("spr_ev_items_two")
	switch (burden_style) {
		case 0: return add
		case 1: return cif
		case 2: return lev
		case 3: return one			
		case 4: return two				
		default: return add
	}	
}