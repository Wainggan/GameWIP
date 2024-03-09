

function Steps(_map = undefined) constructor {
	
	maps = _map == undefined ? [] : [_map];
	index = 0;
	value = undefined;
	
	static next = function(_map) {
		array_push(maps, _map);
		return self;
	}
	
	static run = function(){
		if index < array_length(maps)
			value = maps[index++](value);
		return value;
	}
	
}
