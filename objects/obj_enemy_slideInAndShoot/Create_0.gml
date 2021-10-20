// Inherit the parent event
event_inherited();

startX = x;
startY = y;


directionToMove = point_direction(x, y, startX, startY);
spd = 4
hp = 10;
scoreGive = 8000

imATerribleProgrammerThreshold = HEIGHT

tReloadTime = 32;
reloadTime = tReloadTime;

bP_getInPosition = function() {
	if point_distance(x, y, startX, startY) >= imATerribleProgrammerThreshold {
		// because obj_levelChunker moves the object, startX and startY is never updated
		// this is a horrible idea
		startX = x;
		startY = y;
		x += deltaX;
		y += deltaY;
	}
	
	var dir = point_direction(x, y, startX, startY);

	x += lengthdir_x(spd, dir) * global.delta_multi;
	y += lengthdir_y(spd, dir) * global.delta_multi;
	
	if (x == startX && y == startY) || round(dir) != round(point_direction(x, y, startX, startY)) {
		x = startX;
		y = startY;
	
		bulletPattern = pattern_frame;
	}
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

pattern_getInPosition = [
	[bP_getInPosition, 0]
]
pattern_frame = [
	[bP_aimPlayerDirect, tReloadTime]
]
//pattern_shoot = [
//	[bP_move, 0]
//]

bulletPattern = pattern_getInPosition