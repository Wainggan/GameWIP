if !invinsible {
	if timerMinActive && timerMin <= 0 hp -= other.damage * 1.5;
	else hp -= other.damage
	hitAnim = 1
	
	
	text_damage_random(
		other.x, other.y, point_direction(other.x, other.y, x, y), 
		ceil(other.fakedamage * 10), 32, 10
	);
	
	//global.score += 10;
	
	onHit(other)
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop).sprite_index = sprite_index;

	instance_destroy(other)
}
