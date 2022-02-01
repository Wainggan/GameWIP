bulletList = [];

active = false

x_vel = 0;
y_vel = 0;

hp = var_hp;
maxhp = hp
scoreGive = var_scoreGive;

hitAnim = 0;
hitAnimSpeed = 0.2;

invinsible = false;
important = 0;

deathRadius = 64

parent = noone;
lastParent = noone

directionToMove = sign(WIDTH/2 - x)

//active = false


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

func_addTimeline = function(_t) {
	array_push(bulletPatterns, _t)
}

// [function, time until next]
bulletPatterns = [];

var defaultPattern = new Timeline();
defaultPattern.add(-1, 999)
func_addTimeline(defaultPattern)

// movement

movePattern = new TweenManager()

//

// check
frameFunc = function(){}

movementLoad = function(){
	movePattern.add(new Tween(3, [deltaX, deltaY], [x, y], TWEEN_XY))
	x = deltaX;
	y = deltaY;
}
onLoad = function(){}
