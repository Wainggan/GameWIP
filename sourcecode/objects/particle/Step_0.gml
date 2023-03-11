particleUpdateBuffer += global.delta_multi;

for (var i = 0; i < array_length(activeParticles); i++) {
	if part_particles_count(activeParticles[i]) == 0 {
		part_system_destroy(activeParticles[i]);
		array_delete(activeParticles, i, 1);
		i--;
		continue;
	}
	repeat floor(particleUpdateBuffer) {
		part_system_update(activeParticles[i]);
	}
}

if particleUpdateBuffer >= 1 particleUpdateBuffer -= floor(particleUpdateBuffer);