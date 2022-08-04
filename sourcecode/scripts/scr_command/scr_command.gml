function command_set(_array, _loop = false, _obj = self) {
	for (var i = 0; i < array_length(_array); i++) {
		if typeof(_array[i]) == "method"
			_array[i] = method(_obj, _array[i]);
	}
	_obj.commandList = _array;
	_obj.commandIndex = 0;
	_obj.commandTimer = 0;
}
function command_reset(_obj = self) {
	_obj.commandList = undefined;
}

function command_frame(_func, _obj = self) {
	_obj.commandFrame = method(_obj, _func);
}

function command_timer(_time, _func) {
	if !variable_instance_exists(self, "commandStops") commandStops = [];
	array_push(commandStops, [_time, _func]);
}

function command_update() {
	if variable_instance_exists(self, "commandList") {
		if commandList != undefined 
			&& commandIndex < array_length(commandList) 
			&& commandTimer <= 0 
			{
				var lastC = commandIndex;
				if typeof(commandList[commandIndex]) == "method" {
					commandList[commandIndex]();
				} else {
					commandTimer = commandList[commandIndex];
				}
				if lastC == commandIndex commandIndex++
			}
		commandTimer--;
	}
	if variable_instance_exists(self, "commandFrame") commandFrame();
	if variable_instance_exists(self, "commandStops") {
		for (var i = 0; i < array_length(commandStops); i++) {
			if commandStops[i][0]-- <= 0 {
				commandStops[i][1]();
				array_delete(commandStops, i--, 1);
			}
		}
	}
}
