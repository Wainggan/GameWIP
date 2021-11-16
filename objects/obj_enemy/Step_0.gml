// shooting bullets
bulletPatternBuffer += global.delta_multi;
if bulletPatternBuffer >= bulletPattern[bulletPatternTimeline][1] {
	
	bulletPatternBuffer = 0;
	
	bulletPatternTimeline = (bulletPatternTimeline + 1) % (array_length(bulletPattern));
	
	var a = bulletPattern[bulletPatternTimeline][0];
	if a != -1 {
		
		if is_array(a) {
			script_execute_ext(a[0], a, 1);
		} else {
			bulletPattern[bulletPatternTimeline][0]();
		}
		//var _inst = bulletPattern[bulletPatternTimeline][0]();
		//if _inst != undefined && instance_exists(_inst) {
		//	array_push(bulletList, _inst)
		//}
	}
	
}

// movement
if movePatternTimeline = -1 {
	movePatternTimeline = 0;
	
	targetX = x + movePattern[movePatternTimeline][0]
	targetY = y + movePattern[movePatternTimeline][1]
}
var currentCommand = movePattern[movePatternTimeline]

var dir = point_direction(x, y, targetX, targetY)

x += lengthdir_x(currentCommand[2], dir) * global.delta_multi
y += lengthdir_y(currentCommand[2], dir) * global.delta_multi

if (x == targetX && y == targetY) || round(dir) != round(point_direction(x, y, targetX, targetY)) {
	x = targetX;
	y = targetY;
	
	if array_length(movePattern[movePatternTimeline]) == 4 {
		movePattern[movePatternTimeline][3]()
	}
	
	movePatternTimeline += 1;
	if movePatternTimeline > array_length(movePattern)-1 {
		
		
		movePatternTimeline = 0;
		//instance_destroy()
		//exit
	}
	
	targetX = x + movePattern[movePatternTimeline][0]
	targetY = y + movePattern[movePatternTimeline][1]
}