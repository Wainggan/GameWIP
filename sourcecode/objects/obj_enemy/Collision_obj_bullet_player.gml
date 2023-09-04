if !invinsible {
	if timerMinActive && timerMin <= 0 hp -= other.damage * 1.5;
	else hp -= other.damage
	hitAnim = 1
	
	ignore with text_splash_random(other.x, other.y, ceil(other.fakedamage * 10), 32, 10) {
		font = ft_damage
		color = #ff6688
	}
	//global.score += 10;
	
	onHit(other)
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop).sprite_index = sprite_index;

	instance_destroy(other)
}
