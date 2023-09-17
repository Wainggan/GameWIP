function Look() constructor {
	
	value = 0
	current = 0
	target = 0
	delta = 0
	
	static set = function(_value = target, _force = false) {
		delta = 0
		target = _value
		if _force {
			current  = _value
			value = _value
		}
	}
	static update = function(_spd) {
		delta = clamp(delta + _spd, 0, 1)
		value = approach(current, target, delta)
	}
	static update_color = function(_spd) {
		delta = clamp(delta + _spd, 0, 1)
		value = merge_color(current, target, delta)
	}
	
}

function Look_Array() constructor {
	
	value = []
	
	static set = function(_value = [], _force = false) {
		while array_length(value) < array_length(_value) {
			array_push(value, new Look())
		}
		while array_length(value) > array_length(_value) {
			array_pop(value)
		}
		
		for (var i = 0; i < array_length(value); i++) {
			value[i].set(_value[i], _force)
		}
	}
	static update = function(_spd) {
		for (var i = 0; i < array_length(value); i++) {
			value[i].update(_spd)
		}
	}
	static update_color = function(_spd) {
		for (var i = 0; i < array_length(value); i++) {
			value[i].update_color(_spd)
		}
	}
	
}