
particleSystems = part_system_create_layer("Particles", true);
part_system_automatic_update(particleSystems, false);

particleUpdateBuffer = 0;

function particle_get_type(particle_asset, emitter_index=0) {
    return particle_get_info(particle_asset).emitters[emitter_index].parttype.ind;
}

_burst = function(_x, _y, _system) {
	
	var _struct = particle_get_info(_system);
	
	for (var i = array_length(_struct.emitters) - 1; i >= 0; i--) {
		var _part = particle_get_type(_system, i);
	    part_particles_create(particleSystems, _x, _y, _part, 1);
	}
	
}

