
if grube_mode {
	draw_set_font(global.ev_font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	var highest_str = string(highest_stack) + "\n"
	if potential_new_highest_stack != 0 {
		highest_str += "CHECKING STABILITY\n"
		repeat ((global.editor_time / 3) % 3 + 1) {
			highest_str += "."
		}	
	}
	
	var camera_y = camera_get_view_y(view_camera[0]);
	draw_set_color(c_black)
	ev_draw_rectangle(20, camera_y + 5, 25, camera_y + 30, false)
	draw_set_color(c_white)
	var elevation = 1 - camera_y / 5552
	
	var slider_height = 5;
	var slider_y = lerp(30 - slider_height, 5, elevation)

	
	ev_draw_rectangle(20, camera_y + slider_y, 25, camera_y + slider_y + slider_height, false)

	var txt = "STACK THE GRUBES\nSTACK: " + string(max_stack) + "\nHIGHEST: " + highest_str;
	var size = 0.5
	
	var gy = camera_y + 5;
	
	draw_set_color(c_black)
	draw_text_transformed(112 + size, gy, txt, size, size, 0)
	draw_text_transformed(112 - size, gy, txt, size, size, 0)
	draw_text_transformed(112, gy + size, txt, size, size, 0)
	draw_text_transformed(112, gy - size, txt, size, size, 0)

	draw_set_color(c_white)
	draw_text_transformed(112, gy, txt, size, size, 0)


	draw_sprite(asset_get_index("spr_ev_tools"), 0, mouse_x, mouse_y)

	exit
}

draw_set_font(global.ev_font)
draw_set_halign(fa_left)
draw_set_valign(fa_top)




var long_text = 
@"Development:
Skirlez
KyuuMetis
Pyredrid - Branefuck functions
Meepster99 - GBAStranger export
gullwingdoors - Pencil icon
juliascythe - Helping with 3D cube rendering and the Grube
cyrelouyea - Endless void rod option in chests

Music Credits:
Sunday - crappyblue - astra_jam (...ad astra)
Monday - Skirlez - Monsday (Greedy Groove)
Tuesday - 8bitavo - Tail's Lullaby (Tail, Affection Air, Void)
Wednesday - gooeyPhantasm - Blossom (Dancing lesson, Blossom chime)
Friday - gooeyPhantasm - Endless Void (Voided)
Thursday/Saturday - eebrozgi - Stealie Feelies (slowed down) 

SFX Credits:

Clicking Seatbelt.wav by fatboy94 -- https://freesound.org/s/535807/ 
-- License: Creative Commons 0
toy rattle 2.aiff by SubUnit_FieldRec -- https://freesound.org/s/262380/ 
-- License: Attribution NonCommercial 4.0

";




var draw_y = 5562

var size = 0.35
draw_set_color(c_black)
draw_text_transformed(4 + size, draw_y, long_text, size, size, 0)
draw_text_transformed(4 - size, draw_y, long_text, size, size, 0)
draw_text_transformed(4, draw_y + size, long_text, size, size, 0)
draw_text_transformed(4, draw_y - size, long_text, size, size, 0)

draw_set_color(c_white)
draw_text_transformed(4, draw_y, long_text, size, size, 0)

