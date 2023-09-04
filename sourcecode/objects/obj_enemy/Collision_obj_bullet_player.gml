if !invinsible {
	if timerMinActive && timerMin <= 0 hp -= other.damage * 1.5;
	else hp -= other.damage
	hitAnim = 1
	
	
	var _c = other.s_captured
	with text_damage_random(
		other.x, other.y, 
		_c ? other.dir : point_direction(other.x, other.y, x, y), 
		ceil(other.fakedamage * 10), 32, 
		_c ? 8 : 10, _c ? 10 : undefined, _c ? 2 : undefined
	) {
		if _c {
			//font = ft_bigdamage
		}
	}
	
	//global.score += 10;
	
	onHit(other)
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop).sprite_index = sprite_index;

	instance_destroy(other)
}
