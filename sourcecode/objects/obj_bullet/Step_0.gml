showDirection = false;
switch sprite_index {
	case spr_bullet_point:
		showDirection = true;
	case spr_bullet_arrow:
		showDirection = true;
}

pop = lerp(pop, 0, 1 - power(0.001, global.delta_milli * 2));

event_inherited();
