showDirection = false;
switch sprite_index {
	case spr_bullet_largeinverted:
		deathBorder = 96;
		break;
	case spr_bullet_point:
	case spr_bullet_square:
	case spr_bullet_star:
	case spr_bullet_arrow:
		showDirection = true;
}
glowTarget = glow;
