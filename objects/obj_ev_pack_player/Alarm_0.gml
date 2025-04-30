// check for enclosure of 6x6 room. if it exists we're in a brand room


function check_6x6_enclosure() {
	for (var i = 0; i <= 7; i += 7) {
		for (var j = 3; j <= 10; j++) {
			var instance = instance_position(j * 16 + 8, i * 16 + 8, agi("obj_collision"))
			if !instance_exists(instance) {
				return false;
			}
		}
	}
	for (var j = 3; j <= 10; j += 7) {
		for (var i = 0; i <= 7; i++) {
			var instance = instance_position(j * 16 + 8, i * 16 + 8, agi("obj_collision"))
			if !instance_exists(instance) {
				return false;
			}
		}
	}
	return true;
}
log_info($"Pack player determined brand room: {in_brand_room}")
in_brand_room = check_6x6_enclosure()
