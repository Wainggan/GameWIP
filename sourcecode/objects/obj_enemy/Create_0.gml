bulletList = [];

x_vel = 0;
y_vel = 0;

hp = var_hp;
scoreGive = var_scoreGive;

hitAnim = 0;
hitAnimSpeed = 0.04;

invinsible = false;
important = 0;

deathRadius = 64

parent = noone;
lastParent = noone

directionToMove = sign(WIDTH/2 - x)


func_destroyBullets = function(){
	for (var i = 0; i < array_length(bulletList); i++) {
		if instance_exists(bulletList[i]) {
			instance_destroy(bulletList[i])
		}
	}
}

func_addBullets = function(_b){
	if (_b != undefined) {
		if (parent == noone) {
			if (is_array(_b)) {
				for (var i = 0; i < array_length(_b); i++) {
					array_push(bulletList, _b[i]);
				}
			} else {
				array_push(bulletList, _b);
			}
		} else {
			parent.func_addBullets(_b)
		}
	}
}

// [function, time until next]
defaultPattern = [
	[-1, 999]
]
bulletPattern = defaultPattern;
bulletPatternTimeline = 0;
bulletPatternBuffer = 0;


// movement

// [deltaX, deltaY, speed, optional function call]
defaultMPattern = [
	[0, 0, 1]
]
targetX = 0;
targetY = 0;

movePattern = defaultMPattern;
movePatternTimeline = -1;

// check
frameFunc = function(){}