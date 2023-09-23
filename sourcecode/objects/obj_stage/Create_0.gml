enemies = {};
enemiesMod = {};

enemy = function(_type, _x = 0, _y = 0, _args = []){
	static count = 0
	
	static _empty = function(){};
	var inst = instance_create_layer(_x, _y, "Instances", obj_enemy);
	var func = method_get_index(method(inst, enemies[$ _type]));
	var modFunc = 
		enemiesMod[$ _type] != undefined 
			? method_get_index(method(inst, enemiesMod[$ _type]))
			: method_get_index(_empty) ;
	with inst {
		offset = count++;
		script_execute_ext(func, _args);
		script_execute_ext(modFunc, _args);
	}
	
	return inst;
}
enemyBuffer = [];
enemy_delay = function(_type, _x, _y, _time, _args = [], _func = function(){}){
	var _arr = [];
	for (var i = 0; i < argument_count; i++)
		array_push(_arr, argument[i]);
	
	array_push(enemyBuffer, _arr);
}

spawnUpgrade = function(_t = undefined){
	var _a = struct_get_names(global.upgrades)
	
	var t1 = irandom_range(0, array_length(_a) - 1);
	var t2 = irandom_range(0, array_length(_a) - 1);
	while t2 == t1 {
		t2 = irandom_range(0, array_length(_a) - 1);
	}
	if _t {
		t1 = _t;
		t2 = _t;
	}
	with instance_create_layer(WIDTH / 2 - 128, -32, "Instances", obj_collectable_upgrade)
		type = _a[t1];
	with instance_create_layer(WIDTH / 2 + 128, -32, "Instances", obj_collectable_upgrade)
		type = _a[t2];
}

time = function(_time = 0, _done = false, _buffer = 0){
	timeLeft = _time;
	waitUntilDone = _done
	minimumTime = _buffer
}

timeLeft = 0;
waitUntilDone = false;
minimumTime = 0;
global.stage_time = 0;
stageIndex = 0;

stage = []

addEnemy = function(_name, _func) {
	enemies[$ _name] = _func
}

__Stage = function(_func, _name) constructor {
	func = _func
	name = _name
}
__Pause = function(_amount, _wait, _min) constructor {
	length = _amount
	wait = _wait
	minimumLength = _min
}

addSection = function(_func, _name = undefined) {
	array_push(stage, new __Stage(_func, _name))
}

addPause = function(_length, _wait = false, _min = 0) {
	array_push(stage, new __Pause(_length, _wait, _min))
}

getTime = function() {
	return global.stage_time
}

