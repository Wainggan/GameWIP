function Thread(_func = undefined, _data = {}) constructor {
	index = 0;
	func = _func;
	speed = 10;
	data = _data;
	output = undefined;
	sensitivity = 10;
	
	reset = function(_func, _data = {}) {
		func = _func;
		index = 0;
		data = _data;
		return self;
	}
	loop = function(_amount) {
		if finished() return false;
		if (_amount == undefined) {
			if (fps < 59) speed -= sensitivity / 2;
			else speed += sensitivity;
			speed = max(speed, 50);
			
			_amount = speed;
		}
		var _oldIndex = index;
		for (var i = _oldIndex; i - _oldIndex < _amount; i++) {
			var a = func(index, data);
			if (a != undefined) {
				func = undefined;
				output = a;
				return true;
			}
			index++
		}
		return false;
	}
	loop_finish = function() {
		var _stop = false;
		while !_stop {
			_stop = func(index, data) != undefined;
		}
		return true;
	}
	finished = function() {
		return func == undefined;
	}
}