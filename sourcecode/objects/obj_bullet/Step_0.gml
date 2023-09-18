if firstFrame {
	showDirection = false;
	switch sprite_index {
		case spr_bullet_point:
			showDirection = true;
		case spr_bullet_arrow:
			showDirection = true;
	}
	glowTarget = glow;
	firstFrame = false
}

if pop != 0 {
	pop = lerp(pop, 0, 1 - power(0.001, global.delta_milli * 2));
	if pop <= 0.02 pop = 0
}
glowTarget = merge_color(glowTarget, glow, 1 - power(0.01, global.delta_milli * 4))

event_inherited();

if schedule(2) && random(1) < 0.1 particle_burst(x, y, ps_bulletTrail)
