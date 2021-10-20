hp--
hitAnim = 0.3


instance_destroy(other)

if hp <= 0 {
	global.score += scoreGive;
	
	instance_destroy()
	//func_destroyBullets()
}