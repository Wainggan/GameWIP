#macro INPUT_CHECK 0
#macro INPUT_PRESSED 1 
#macro INPUT_RELEASED 2

function Input() constructor {
	
	keyCodes = {}
	
	bind = function(_code, _in) {
		
		var _fix = _in
		if (!is_array(_in)) {
			_fix = [_in]
		}
		variable_struct_set(keyCodes, _code, _fix)
		
	}
	
	func_checkKey = function(_vk, _against) {
		switch _against {
			case INPUT_CHECK:
				return keyboard_check(_vk);
			case INPUT_PRESSED:
				return keyboard_check_pressed(_vk);
			case INPUT_RELEASED:
				return keyboard_check_released(_vk);
		}
	}
	
	check = function(_code, _checkFunc = INPUT_CHECK) {
		var _inputs = variable_struct_get(keyCodes, _code);
		
		for (var i = 0; i < array_length(_inputs); i++) {
			if (func_checkKey(_inputs[i], _checkFunc)) {
				return true;
			}
		}
		return false;
	}
}