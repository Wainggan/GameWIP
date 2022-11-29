if !invinsible {
	hp -= other.damage
	hitAnim = 1
	
	
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop).sprite_index = sprite_index;

	instance_destroy(other)
}
