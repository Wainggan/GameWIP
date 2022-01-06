if (lastParent != noone) {
	if (!instance_exists(parent)) {
		instance_destroy()
	}
}
lastParent = parent

if hp > maxhp {
	maxhp = hp
}



// making sure the bullet list has active instances
for (var i = 0; i < array_length(bulletList); i++) {
	if (!instance_exists(bulletList[i])) {
		array_delete(bulletList, i, 1)
		i--
	}
}

// shooting bullets
bulletPatternBuffer += global.delta_multi;
if bulletPatternBuffer >= bulletPattern[bulletPatternTimeline][1] {
	
	bulletPatternBuffer = 0;
	
	bulletPatternTimeline = (bulletPatternTimeline + 1) % (array_length(bulletPattern));
	
	var a = bulletPattern[bulletPatternTimeline][0];
	if a != -1 {
		
		var _b = script_execute_deep(a);
		func_addBullets(_b);

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
		var f = movePattern[movePatternTimeline][3]
		script_execute_deep(f);
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

frameFunc()