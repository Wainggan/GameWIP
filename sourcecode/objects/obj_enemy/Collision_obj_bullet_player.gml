if !invinsible {
	if timerMinActive && timerMin <= 0 hp -= other.damage * 1.5;
	else hp -= other.damage
	hitAnim = 1
	
	onHit(other)
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop).sprite_index = sprite_index;

	instance_destroy(other)
}
