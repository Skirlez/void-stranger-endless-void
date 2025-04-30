function count_down() {
	count--;
	if (count <= 0)
		instance_destroy(id)
}