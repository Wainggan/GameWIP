// Inherit the parent event
event_inherited();

hp = 2



pattern_shoot = [
	[bP_shootDownNormal, 32]
]
mPattern_move = [
	[directionToMove * WIDTH, 0, 6]
]

frameFunc = function(){
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

bulletPattern = pattern_shoot
movePattern = mPattern_move