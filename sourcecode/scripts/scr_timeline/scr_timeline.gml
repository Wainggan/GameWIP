function Timeline(_item = undefined, _time = 10) constructor {
	list = [];
	time = 0;
	index = 0;
	changed = false;
	active = true
	add = function(_item, _time) {
		array_push(list, [_item, _time]);
		return self;
	}
	addReset = function() {
		array_push(list, undefined)
		return self;
	}
	update = function(_time) {
		if !active return;
		time += _time;
		if (array_length(list) > 0 && time >= list[index][1]) {
			index = (index + 1) % array_length(list);
			time = 0;
			changed = true;
			if list[index] == undefined {
				reset()
			}
		} else changed = false;
		return changed
	}
	reset = function() {
		list = [];
		index = 0;
		time = 0;
		changed = false;
	}
	evaluate = function() {
		return list[index][0];
	}
	
	if (_item != undefined) {
		add(_item, _time)
	}
}

log("do not use MovementController", LOG_WARNING)
log("i beg of you", LOG_WARNING)
function MovementController() constructor { // DO NOT USE THIS
	
	log("you just created a MovementController, why", LOG_WARNING)
	// DON'T
	
	movementStack = [];
	index = 0;
	
	add = function(_x, _y, _speed, _onFinish = function(){}, _type = "smooth", _continue = true) {
		var _anim = new AnimCurve(_type)
		if array_length(movementStack) != 0 { 
			_anim.add("x", movementStack[array_length(movementStack)-1][0].get("x").target, _x)
			_anim.add("y", movementStack[array_length(movementStack)-1][0].get("y").target, _y)
			var _dist = _speed / point_distance(movementStack[array_length(movementStack)-1][0].get("x").target
			, movementStack[array_length(movementStack)-1][0].get("y").target, _x, _y);
		} else {
			_anim.add("x", other.x, _x)
			_anim.add("y", other.y, _y)
			var _dist = _speed / point_distance(other.x, other.y, _x, _y);
		}
		
		if !_continue array_pop(movementStack)
		array_push(movementStack, [_anim, _dist, _onFinish, _continue])
	}
	
	update = function(_mult = 1) {
		index = clamp(index, 0, array_length(movementStack) - 1);
		if array_length(movementStack) != 0 {
			movementStack[index][0].percent = min(movementStack[index][0].percent + movementStack[index][1] * _mult, 1);
			other.x = movementStack[index][0].evaluate("x");
			other.y = movementStack[index][0].evaluate("y");
			if (movementStack[index][0].percent >= 1) {
				with other { other.movementStack[other.index][2](); }
				if array_length(movementStack) != 0 {
					index = (index + 1) % array_length(movementStack);
					movementStack[index][0].percent = 0
					movementStack[index][0].get("x").start = other.x
					movementStack[index][0].get("y").start = other.y
				}
			}
		}
	}
	pop = function() {
		array_pop(movementStack)
	}
}
