#macro INPUT_CHECK 0
#macro INPUT_PRESSED 1 
#macro INPUT_RELEASED 2

#macro INPUT_MODE_KEYBOARD 0
#macro INPUT_MODE_CONTROLLER 1
#macro INPUT_MODE_CONTROLLER_ANALOGBUTTONTODIGITAL 2
#macro INPUT_MODE_CONTROLLER_ANALOGBUTTON 3
#macro INPUT_MODE_CONTROLLER_STICKTODIGITAL 4
#macro INPUT_MODE_CONTROLLER_STICK 5

gamepad_set_axis_deadzone(0, 0.3)

function Input() constructor {
	
	keyCodes = {}
	
	bind = function(_code, _in, _type = INPUT_MODE_KEYBOARD) {
		var _array = _in
		if (!is_array(_in)) {
			_array = [[_type, _in]]
		} else {
			for (var i = 0; i < array_length(_array); i++) {
				_array[i] = [_type, _array[i]]
			}
		}
		if !variable_struct_exists(keyCodes, _code) {
			variable_struct_set(keyCodes, _code, _array)
		} else {
			variable_struct_set(keyCodes, _code, array_append(variable_struct_get(keyCodes, _code), _array))
		}
	}
	
	func_checkKey = function(_vk, _against, _type) {
		if _type == INPUT_MODE_KEYBOARD {
			switch _against {
				case INPUT_CHECK:
					return keyboard_check(_vk);
				case INPUT_PRESSED:
					return keyboard_check_pressed(_vk);
				case INPUT_RELEASED:
					return keyboard_check_released(_vk);
			}
		} else {
			switch _type {
				case INPUT_MODE_CONTROLLER_ANALOGBUTTONTODIGITAL:
					return gamepad_button_value(0, _vk) > 0.2;
				case INPUT_MODE_CONTROLLER_ANALOGBUTTON:
					return gamepad_button_value(0, _vk)
				case INPUT_MODE_CONTROLLER_STICK:
					return gamepad_axis_value(0, _vk);
				case INPUT_MODE_CONTROLLER_STICKTODIGITAL:
					var a = gamepad_axis_value(0, _vk)
					return sign(a)
				case INPUT_MODE_CONTROLLER:
					switch _against {
						case INPUT_CHECK:
							return gamepad_button_check(0, _vk);
						case INPUT_PRESSED:
							return gamepad_button_check_pressed(0, _vk);
						case INPUT_RELEASED:
							return gamepad_button_check_released(0, _vk);
					}
			}
			
		}
	}
	
	check = function(_code, _checkFunc = INPUT_CHECK) {
		var _inputs = variable_struct_get(keyCodes, _code);
		
		for (var i = 0; i < array_length(_inputs); i++) {
			var a = func_checkKey(_inputs[i][1], _checkFunc, _inputs[i][0])
			if (a != false) {
				return a;
			}
		}
		return false;
	}
}