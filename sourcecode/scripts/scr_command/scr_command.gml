function CommandBeat(_beat = 1) constructor {
	beat = _beat;
}

function command_setup() {
	commandSwitches = undefined;
	commandList = undefined;
	commandFrame = undefined;
	commandStops = undefined;
}
function command_set(_array) {
	commandList = [];
	command_add(_array);
}
function command_add(_array) {
	if commandList == undefined commandList = [];
	
	for (var i = 0; i < array_length(_array); i++) {
		if typeof(_array[i]) == "method"
			_array[i] = method(self, _array[i]);
	}
	
	array_push(commandList, {
		list: _array,
		index: 0,
		timer: 0,
		beat: 0
	});
	commandIndex = 0;
	commandTimer = 0;
}
function command_get(_index) {
	return commandList[_index].list;
}
function command_reset() {
	commandList = [];
	commandFrame = function(){};
	commandSwitches = {
		index: 0,
		timer: 0,
		list: [],
		timerList: []
	};
	//commandStops = [];
}
function command_timer_reset() {
	commandStops = [];
}

function command_frame(_func) {
	commandFrame = method(self, _func);
}

function command_timer(_time, _func) {
	if commandStops == undefined commandStops = [];
	array_push(commandStops, [_time, _func]);
}

function command_switch(_array) {
	commandSwitches = {
		index: 0,
		timer: 0,
		list: [],
		timerList: []
	};
	for (var i = 0; i < array_length(_array); i += 2) {
		array_push(commandSwitches.list, _array[i]);
		array_push(commandSwitches.timerList, _array[i + 1]);
	}
}
function command_switch_add(_index, _func, _runNow = _index == command_switch_current()) {
	if is_array(commandSwitches.list[_index]) {
		array_push(commandSwitches.list[_index], _func);
	} else {
		commandSwitches.list[_index] = [commandSwitches.list[_index], _func];
	}
	if _runNow _func()
}
function command_switch_push(_array, _runNow = false) {
	for (var i = 0; i < array_length(_array); i += 2) {
		array_push(commandSwitches.list, _array[i]);
		array_push(commandSwitches.timerList, _array[i + 1]);
	}
	if _runNow commandSwitches.index = array_length(commandSwitches.list) - 1;
}
function command_switch_set_time(_index, _time) {
	commandSwitches.timerList[_index] = _time;
}
function command_switch_get_time(_index) {
	return commandSwitches.timerList[_index];
}
function command_switch_current() {
	return commandSwitches.index - 1 < 0 ? array_length(commandSwitches.list) - 1 : commandSwitches.index - 1;
}
function command_switch_set(_index) {
	commandSwitches.index = _index - 1 < 0 ? array_length(commandSwitches.list) - 1 : _index;
	commandSwitches.timer = 0;
}

function command_update() {
	if commandSwitches != undefined && array_length(commandSwitches.list) > 0 {
		commandSwitches.timer -= global.delta_multi;
		if commandSwitches.timer <= 0 {
			if is_array(commandSwitches.list[commandSwitches.index]) 
				for (var i = 0; i < array_length(commandSwitches.list[commandSwitches.index]); i++)
					commandSwitches.list[commandSwitches.index][i]();
			else commandSwitches.list[commandSwitches.index]();
			commandSwitches.timer = commandSwitches.timerList[commandSwitches.index]
			commandSwitches.index++
			if commandSwitches.index >= array_length(commandSwitches.list)
				commandSwitches.index = 0
		}
	}
	if commandList != undefined {
		for (var i = 0; i < array_length(commandList); i++) {
			var cL = commandList[i].list;
			commandIndex = commandList[i].index;
			commandTimer = commandList[i].timer;
			commandBeat = commandList[i].beat;
			
			if commandBeat > 0 {
				var _saftey = 1;
				while commandBeat <= 0 && _saftey-- >= 0 {
					if commandIndex < array_length(cL) 
						&& commandBeat <= 0 
						{
							var lastC = commandIndex;
							if typeof(cL[commandIndex]) == "method" {
								cL[commandIndex]();
							} else if is_struct(cL[commandIndex]) {
								commandBeat = cL[commandIndex].beat;
							} else {
								commandTimer = cL[commandIndex];
							}
							if lastC == commandIndex commandIndex++;
						}
				}
				
				//show_debug_message("{0} {1}", commandBeat, +music.hasBeat)
				commandBeat -= +music.hasBeat;
			} else {
			
				var _saftey = 1;
				while commandTimer <= 0 && _saftey-- >= 0 {
					if commandIndex < array_length(cL) 
						&& commandTimer <= 0 
						{
							var lastC = commandIndex;
							if typeof(cL[commandIndex]) == "method" {
								cL[commandIndex]();
							} else if is_struct(cL[commandIndex]) {
								commandBeat = cL[commandIndex].beat;
							} else {
								commandTimer = cL[commandIndex];
							}
							if lastC == commandIndex commandIndex++;
						}
				}
			
				commandTimer -= global.delta_multi;
			}
			
			commandList[i].index = commandIndex;
			commandList[i].timer = commandTimer;
			commandList[i].beat = commandBeat;
			
			if commandList[i].index >= array_length(commandList[i].list)
				array_delete(commandList, i--, 1);
		}
	}
	if commandFrame != undefined commandFrame();
	if commandStops != undefined {
		for (var i = 0; i < array_length(commandStops); i++) {
			commandStops[i][0] -= global.delta_multi;
			if commandStops[i][0] <= 0 {
				commandStops[i][1]();
				array_delete(commandStops, i--, 1);
			}
		}
	}
}
