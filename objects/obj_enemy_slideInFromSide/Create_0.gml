// Inherit the parent event
event_inherited();

hp = 2

directionToMove = sign(0 - x) * 4

tReloadTime = 32;
reloadTime = tReloadTime;

bP_shoot = function() {
	var inst = instance_create_depth(x, y, depth, obj_bullet)
	
	with inst {
		x_vel = 0
		y_vel = 3
	}
	 array_push(bulletList, inst)
}

bP_move = function() {
	x += directionToMove;
	
	reloadTime -= global.delta_multi;
	if reloadTime <= 0 {
		reloadTime = tReloadTime;
		
		bP_shoot()
	}
	
	if sign(directionToMove) == 1 {
		if WIDTH + 64 < x {
			instance_destroy()
		}
	} else {
		if -64 > x {
			instance_destroy()
		}
	}
}

pattern_move = [
	[bP_move, 0]
]
//pattern_shoot = [
//	[bP_move, 0]
//]

bulletPattern = pattern_move