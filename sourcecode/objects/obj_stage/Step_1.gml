if array_length(stage) > 0 {
	minimumTime -= global.delta_multi;
	if waitUntilDone {
		if instance_number(obj_enemy) == 0 && instance_number(obj_collectable_upgrade) == 0 && array_length(enemyBuffer) == 0 {
			waitUntilDone = false;
		}
	} else {
		if timeLeft <= 0 && minimumTime <= 0 {
			stageIndex++
			if stageIndex >= array_length(stage) {
				instance_destroy();
			} else {
				time(60)
				stage[stageIndex]();
			}
			exit;
		} else timeLeft -= global.delta_multi;
	}
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