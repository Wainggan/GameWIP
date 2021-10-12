for (var i = 0; i < array_length(bulletList); i++) {
	if instance_exists(bulletList[0]) {
		instance_destroy(bulletList[0])
	}
}