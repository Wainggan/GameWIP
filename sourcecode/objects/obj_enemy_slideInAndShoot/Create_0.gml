// Inherit the parent event
event_inherited();


//directionToMove = point_direction(x, y, startX, startY);
spd = 4
hp = 9;
scoreGive = 9000;


pattern_frame = [
	[bP_aimPlayerDirect, 32],
]

mPattern_getInPosition = [
	[deltaX, deltaY, 999],
	[-deltaX, -deltaY, 3],
	[0, 0, 0, function(){
		movePattern = mPattern_goAway
		bulletPattern = pattern_frame
	}]
]
mPattern_goAway = [
	[directionToMove*WIDTH, 128, 1],
	[0,0,0,function(){instance_destroy()}]
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

movePattern = mPattern_getInPosition

//bulletPattern = pattern_frame