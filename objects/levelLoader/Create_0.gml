enemyList = noone;
func_setupLevel = function() {
	
	enemyList = [];
	with obj_enemy {
		array_push(other.enemyList, id);
	}
	array_sort(enemyList, function(inst1, inst2) {
		return inst1.y - inst2.y;
	})
	
	instance_deactivate_object(obj_enemy)
}

positionY = HEIGHT/2;