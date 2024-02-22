event_inherited();

if (state == 1) {
	upload_timeout--;
	if (upload_timeout == 0) {
		on_fail()
	}
}
