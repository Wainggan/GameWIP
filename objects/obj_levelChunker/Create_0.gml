enemyList = noone;
active = false
func_setupLevel = function() {
	
	enemyList = [];
	var nearEnemies = ds_list_create()
	instance_place_list(x, y, obj_enemy, nearEnemies, false)
	for (var i = 0; i < ds_list_size(nearEnemies); i++) {
		var inst = nearEnemies[| i];
		array_push(enemyList, inst);
		instance_deactivate_object(inst)
	}
	
	//array_sort(enemyList, function(inst1, inst2) {
	//	return inst1.y - inst2.y;
	//})
	
	ds_list_destroy(nearEnemies)
	
}