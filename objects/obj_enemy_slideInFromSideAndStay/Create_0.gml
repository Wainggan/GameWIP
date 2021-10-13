// Inherit the parent event
event_inherited();

directionToMove = sign(0 - x) * 4

tReloadTime = 32;
reloadTime = tReloadTime;



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