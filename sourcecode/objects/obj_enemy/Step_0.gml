//if !active exit

command_update();
movement_update();


if hp > maxhp {
	maxhp = hp
}

if hp <= 0 {
	global.score += scoreGive;
	
	
	var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
	inst.targetSize = deathRadius
	inst.sizeSpeed = 48;
	
	var shockwave = render.shockwave_create(x, y)
	shockwave.mode = 1
	shockwave.scaleTarget = deathRadius * 4
	shockwave.scaleSpeed = 18
	
	onDeath();
	if canDie instance_destroy();
	//func_destroyBullets()
}