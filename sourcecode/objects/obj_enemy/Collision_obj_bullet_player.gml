if !invinsible {
	hp--
	hitAnim = 0.3

	instance_destroy(other)
}
if hp <= 0 {
	global.score += scoreGive;
	
	var list = ds_list_create()
	collision_circle_list(x, y, deathRadius, obj_bullet, 0, true, list, 0)
	for (var i = 0; i < ds_list_size(list); i++) {
		instance_destroy(list[| i])
	}
	
	instance_destroy()
	//func_destroyBullets()
}