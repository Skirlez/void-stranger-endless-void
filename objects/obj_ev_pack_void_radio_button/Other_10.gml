event_inherited();
global.void_radio_on = !global.void_radio_on
if (!global.void_radio_on)
	ev_stop_music();
else
	additional_spin = 4;