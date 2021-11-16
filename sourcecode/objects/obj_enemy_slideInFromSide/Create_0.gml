// Inherit the parent event
event_inherited();

hp = 2

directionToMove = sign(0 - x)


pattern_shoot = [
	[bP_shootDownNormal, 32]
]
mPattern_move = [
	[directionToMove * 6, 0, 6, function(){
		if sign(directionToMove) == 1 {
			if WIDTH + 64 < x {
				instance_destroy()
			}
		} else {
			if -64 > x {
				instance_destroy()
			}
		}
	}]
]

bulletPattern = pattern_shoot
movePattern = mPattern_move