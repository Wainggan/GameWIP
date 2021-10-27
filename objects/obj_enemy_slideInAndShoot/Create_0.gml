// Inherit the parent event
event_inherited();

startX = x;
startY = y;


//directionToMove = point_direction(x, y, startX, startY);
spd = 4
hp = 9;
scoreGive = 9000



pattern_frame = [
	[bP_aimPlayerDirect, 32],
]

mPattern_getInPosition = [
	[deltaX, deltaY, 999],
	[-deltaX, -deltaY, 4],
	[0, 0, 0, function(){
		movePattern = defaultMPattern
		bulletPattern = pattern_frame
	}]
]

movePattern = mPattern_getInPosition

//bulletPattern = pattern_frame