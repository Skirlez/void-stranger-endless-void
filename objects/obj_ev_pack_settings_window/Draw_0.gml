draw_self();


var minutes = floor(((current_time - global.pack_editor.save_timestamp) / 1000) / 60);
if minutes > 0 {
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_font(global.ev_font)
	var noun = (minutes == 1) ? "minute" : "minutes";
	draw_text_shadow(x, y + 40, $"{minutes} {noun} since last save")
}