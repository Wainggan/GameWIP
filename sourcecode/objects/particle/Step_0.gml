particleUpdateBuffer += global.delta_multi;

repeat floor(particleUpdateBuffer) {
	part_system_update(particleSystems);
}

if particleUpdateBuffer >= 1 particleUpdateBuffer -= floor(particleUpdateBuffer);