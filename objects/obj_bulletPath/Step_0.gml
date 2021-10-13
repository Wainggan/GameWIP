if parent != noone && !instance_exists(parent) {
	instance_destroy()
	exit
}

if bulletPatternTimeline = -1 {
	bulletPatternTimeline = 0;
	
	targetX = x + bulletPattern[bulletPatternTimeline][0]
	targetY = y + bulletPattern[bulletPatternTimeline][1]
}

var currentCommand = bulletPattern[bulletPatternTimeline]

var dir = point_direction(x, y, targetX, targetY)

x += lengthdir_x(currentCommand[2], dir) * global.delta_multi
y += lengthdir_y(currentCommand[2], dir) * global.delta_multi

if (x == targetX && y == targetY) || dir != point_direction(x, y, targetX, targetY) {
	x = targetX;
	y = targetY;
	
	bulletPatternTimeline += 1;
	if bulletPatternTimeline > array_length(bulletPattern)-1 {
		
		instance_destroy()
		exit
	}
	
	targetX = x + bulletPattern[bulletPatternTimeline][0]
	targetY = y + bulletPattern[bulletPatternTimeline][1]
}

reloadTime = max(reloadTime - global.delta_multi, 0)
if reloadTime <= 0 {
	var inst = bPToShoot()
	if instance_exists(parent) {
		array_push(parent.bulletList, inst)
	}
	reloadTime = bPReload
}
