function State(_defaultState) constructor {
	currentState = _defaultState;
	states = {};
	owner = other;
	
	add = function(_name, _struct) {
		states[$ _name] = _struct;
	}
	change = function(_name, _leave = function(){}, _enter = function(){}) {
		var _struct = states[$ currentState];
		if (variable_struct_exists(_struct, "leave")) {
			with owner script_execute(method_get_index(_struct.leave))
		}
		with owner script_execute(method_get_index(_leave))
		currentState = _name;
		var _struct = states[$ currentState];
		if (variable_struct_exists(_struct, "enter")) {
			with owner script_execute(method_get_index(_struct.enter))
		}
		with owner script_execute(method_get_index(_enter))
	}
	run = function(_name = currentState) {
		var _struct = states[$ _name];
		if (variable_struct_exists(_struct, "step")) {
			with owner script_execute(method_get_index(_struct.step))
		}
	}
}