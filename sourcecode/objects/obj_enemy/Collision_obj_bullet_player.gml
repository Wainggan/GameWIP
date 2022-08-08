if !invinsible {
	hp--
	hitAnim = 1
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop)

	instance_destroy(other)
}
