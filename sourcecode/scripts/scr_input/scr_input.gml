function InputManager(_gamepad = 0, _deadzone = 0.3) constructor {
	
	gamepad = _gamepad;
	deadzone = _deadzone
	
	inputs = {}
	
	update = function() {
		var _inputs = variable_struct_get_names(inputs)
		for (var i = 0; i < array_length(_inputs); i++) {
			inputs[$ _inputs[i]].update()
		}
	}
	
	create_input = function(_name) {
		var _input = new Input(self);
		inputs[$ _name] = _input;
		return _input;
	}
	
	check = function(_name) {
		return inputs[$ _name].check();
	}
	check_pressed = function(_name, _buffered = undefined) {
		return inputs[$ _name].check_pressed(_buffered);
	}
	check_released = function(_name, _buffered = undefined) {
		return inputs[$ _name].check_released(_buffered);
	}
	check_stutter = function(_name, _initial_delay = undefined, _interval = undefined) {
		return inputs[$ _name].check_stutter(_initial_delay, _interval);
	}
	
}

function Input(_manager) constructor {
	manager = _manager;
	keys = []
	time = 0;
	
	buffer = 1;
	
	
	update = function() {
		var active = false;

		for (var i = 0; i < array_length(keys); i++) {
			if (keys[i].check()) {
				active = true;
				break;
			}
		}

		if (active)
			time++;
		else if (time > 0)
			time = -buffer;
		else
			time = min(time + 1, 0);
	}
	
	set_buffer = function(_buffer) {
		buffer = _buffer;
		return self;
	}
	
	add_keyboard_key = function(_key) {
		var key = {
			button : _key
		}
		key.check = method(key, function() {
			return keyboard_check(button);
		});

		array_push(keys, key);
		return self;
	}
	add_gamepad_button = function(_button) {
		var key = {
			creator: other,
			button: _button
		};
		key.check = method(key, function() {
			return gamepad_button_check(creator.manager.gamepad, button);
		});

		array_push(keys, key);
		return self;
    }
	add_gamepad_stick = function(_stick, _direction) {
		var key = {
		    creator: other,
		    axis: _stick,
		    dir: _direction
		};
		key.check = method(key, function() {
		    return gamepad_axis_value(self.creator.manager.gamepad, axis) * self.dir >= self.creator.manager.deadzone;
		});

		array_push(keys, key);
		return self;
    }
	add_gamepad_shoulder = function(_button, _direction) {
		var key = {
		    creator: other,
		    button: _button
		};
		key.check = method(key, function() {
		    return gamepad_button_value(self.creator.manager.gamepad, self.button) >= 0.2;//creator.manager.deadzone;
		});

		array_push(keys, key);
		return self;
    }
	
	check = function() {
		return time > 0;
	}
	check_pressed = function(_buffered = false) {
		if (_buffered)
			    return time > 0 && time <= buffer;
		return time == 1;
	}
	check_released = function(_buffered = false) {
		if (_buffered)
			return time < 0;
		return time == -buffer;
	}
	check_stutter = function(_initial_delay, _interval) {
		if (time == 1)
			return true;
		return time - _initial_delay > 0 && (time - _initial_delay) % _interval == 0;
	}
}