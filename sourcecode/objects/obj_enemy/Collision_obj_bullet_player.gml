if !invinsible {
	hp--
	hitAnim = 1
	
	instance_create_depth(x, y, depth+100, obj_effect_hitpop)

	instance_destroy(other)
}
if hp <= 0 {
	global.score += scoreGive;
	
	
	var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
	inst.targetSize = deathRadius
	
	var shockwave = render.shockwave_create(x, y)
	shockwave.mode = 1
	shockwave.scaleTarget = deathRadius * 4
	shockwave.scaleSpeed = 18
	
	instance_destroy()
	//func_destroyBullets()
}