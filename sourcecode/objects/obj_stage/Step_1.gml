if array_length(stage) > 0
	if time == -1 {
		if instance_number(obj_enemy) == 0 && instance_number(obj_collectable_upgrade) == 0 && array_length(enemyBuffer) == 0 {
			stageIndex++
			if stageIndex >= array_length(stage) {
				instance_destroy();
			} else {
				time = 60 * 1;
				stage[stageIndex]();
			}
			exit;
		}
	} else {
		if time <= 0 {
			stageIndex++
			if stageIndex >= array_length(stage) {
				instance_destroy();
			} else {
				time = 60 * 4;
				stage[stageIndex]();
			}
			exit;
		} else time -= global.delta_multi;
	}

for (var i = 0; i < array_length(enemyBuffer); i++) {
	enemyBuffer[i][3] -= global.delta_multi;
	if enemyBuffer[i][3] <= 0 {
		var _func = array_pop(enemyBuffer[i])
		array_delete(enemyBuffer[i], 3, 1);
		var inst = script_execute_ext(method_get_index(enemy), enemyBuffer[i]);
		method(inst, _func)();
		array_delete(enemyBuffer, i, 1);
	}
}