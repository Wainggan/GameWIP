enemyList = noone;
active = false;

miniWave = [];
currentMiniWave = 0;
miniWaveReload = 0;

func_setupLevel = function() {
	
	enemyList = [];
	var nearEnemies = ds_list_create()
	instance_place_list(x, y, obj_enemy, nearEnemies, false)
	for (var i = 0; i < ds_list_size(nearEnemies); i++) {
		var inst = nearEnemies[| i];
		array_push(enemyList, inst);
		instance_deactivate_object(inst)
	}
	ds_list_destroy(nearEnemies)
	
	//array_sort(enemyList, function(inst1, inst2) {
	//	return inst1.y - inst2.y;
	//})
	
	
}

func_activateChunk = function() {
	for (var i = 0; i < array_length(enemyList); i++) {
		var inst = enemyList[i];
			
		instance_activate_object(inst);
			
		var offset = inst.y - bbox_bottom;
		inst.y = HEIGHT + offset;
		
	}
	
	active = true;
}


func_createEnemy = function(_deltaX, _deltaY, _object) {
	if object_exists(_object) {
		var _inst = instance_create_layer(_deltaX, _deltaY, "Instances", _object)
		//_inst.scoreGive = 0 // probably a bad idea
		//array_push(enemyList, _inst)
	}
}