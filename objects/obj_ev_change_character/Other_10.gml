event_inherited()


switch global.stranger {
	case 0: // Gray to Lillie
		global.stranger = 1		
		break
	case 1: // Lillie to Cif
		global.stranger = 2	
		global.memory_style = 1	// Cif's burdens
		global.wings_style = 1
		global.blade_style = 1			
		break	
	case 2: // Cif to Bee
		global.stranger = 7
		global.blade_style = choose(1,1,4) // Chance to get the Void Drill
		break		
	case 4: // Lev to Ninnie, eventually
		global.stranger = 6
		break			
	case 5: // Lily to Ninnie
		global.stranger = 6		
		break	
	case 7: // Bee to Lily
		global.stranger = 5
		global.memory_style = 2	// Lev's burdens for the sake of giving every set 2 reps
		global.wings_style = 2
		global.blade_style = 2				
		break	
	default: // Reset to Gray
		global.stranger = 0
		global.memory_style = 0	// Add's burdens
		global.wings_style = 0
		global.blade_style = 0			
		break				
}

// Reset dialogue globals so you don't need to restart to see different dialogue after switching strangers
global.locust = 0
global.luckylocust = 0
global.memory_get = 0
global.wings_get = 0	
global.blade_get = 0
	
if (global.compiled_for_merge)
	asset_get_index("scr_menueyecatch")(0)

sprite_index = ev_get_stranger_down_sprite(global.stranger)