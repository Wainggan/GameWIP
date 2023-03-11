activeParticles = [];

particleUpdateBuffer = 0;

_burst = function(_x, _y, _system) {
	var _psSystem = part_system_create_layer("Particles", true, _system);
	part_system_position(_psSystem, _x, _y);
	part_system_automatic_update(_psSystem, false);
	part_system_update(_psSystem);
	array_push(activeParticles, _psSystem);
}

