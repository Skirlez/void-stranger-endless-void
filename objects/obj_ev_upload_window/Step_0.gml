event_inherited();

if (state == 1) {
	upload_timeout--;
	if (upload_timeout == 0) {
		on_fail("Timeout")
	}
}

if state == 6 {
	verify_timeout--;
	if (verify_timeout == 0) {
		on_fail_verify()
	}
}
