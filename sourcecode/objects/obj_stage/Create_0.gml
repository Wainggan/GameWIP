enemies = {};
enemiesMod = {};

enemy = function(_type, _x = 0, _y = 0, _args = []){
	var inst = instance_create_layer(_x, _y, "Instances", obj_enemy);
	var func = method_get_index(method(inst, enemies[$ _type]));
	var modFunc = 
		enemiesMod[$ _type] != undefined 
			? method_get_index(method(inst, enemiesMod[$ _type]))
			: method_get_index(function(){}) ;
	with inst {
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

time = 0;
stageIndex = -1;

stage = []


