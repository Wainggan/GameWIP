function command_set(_array) {
	commandList = [];
	command_add(_array);
}
function command_add(_array) {
	if !variable_instance_exists(self, "commandList") commandList = [];
	
	for (var i = 0; i < array_length(_array); i++) {
		if typeof(_array[i]) == "method"
			_array[i] = method(self, _array[i]);
	}
	
	array_push(commandList, {
		list: _array,
		index: 0,
		timer: 0
	});
	commandIndex = 0;
	commandTimer = 0;
}
function command_reset() {
	commandList = [];
	commandFrame = function(){};
	//commandStops = [];
}
function command_timer_reset() {
	commandStops = [];
}

function command_frame(_func) {
	commandFrame = method(self, _func);
}

function command_timer(_time, _func) {
	if !variable_instance_exists(self, "commandStops") commandStops = [];
	array_push(commandStops, [_time, _func]);
}

function command_update() {
	if variable_instance_exists(self, "commandList") {
		for (var i = 0; i < array_length(commandList); i++) {
			var cL = commandList[i].list;
			commandIndex = commandList[i].index;
			commandTimer = commandList[i].timer;
			
			var _saftey = 1;
			while commandTimer <= 0 && _saftey-- >= 0 {
				if commandIndex < array_length(cL) 
					&& commandTimer <= 0 
					{
						var lastC = commandIndex;
						if typeof(cL[commandIndex]) == "method" {
							cL[commandIndex]();
						} else {
							commandTimer = cL[commandIndex];
						}
						if lastC == commandIndex commandIndex++;
					}
			}
			
			commandTimer -= global.delta_multi;
			
			commandList[i].index = commandIndex;
			commandList[i].timer = commandTimer;
			
			if commandList[i].index >= array_length(commandList[i].list)
				array_delete(commandList, i--, 1);
		}
	}
	if variable_instance_exists(self, "commandFrame") commandFrame();
	if variable_instance_exists(self, "commandStops") {
		for (var i = 0; i < array_length(commandStops); i++) {
			commandStops[i][0] -= global.delta_multi;
			if commandStops[i][0] <= 0 {
				commandStops[i][1]();
				array_delete(commandStops, i--, 1);
			}
		}
	}
}
